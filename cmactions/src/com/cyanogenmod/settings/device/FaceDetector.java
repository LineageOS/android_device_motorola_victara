/*
 * Copyright (c) 2015 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.content.Context;
import android.graphics.ImageFormat;
import android.hardware.camera2.*;
import android.hardware.camera2.params.*;
import android.media.Image;
import android.media.ImageReader;
import android.media.Image.Plane;
import android.util.Log;
import android.view.Surface;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.LinkedList;
import java.util.List;

import static android.hardware.camera2.CameraDevice.*;
import static android.hardware.camera2.CaptureRequest.*;
import static android.hardware.camera2.CaptureResult.*;

public class FaceDetector {
    static final String TAG = "CMActions-FaceDetector";
    static final String FRONT_CAMERA_DEFAULT_ID = "1";

    private CameraDevice mCameraDevice;
    private ImageReader mImageReader;

    public FaceDetector(Context context) {
        Log.d(TAG, "Opening the camera");
        try {
            CameraManager cameraManager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
            cameraManager.openCamera(findFrontFacingCamera(cameraManager), mStateCallback, null);
        } catch (CameraAccessException cae) {
            Log.e(TAG, "Failed to access the camera: " + cae);
        }
    }

    private String findFrontFacingCamera(CameraManager cameraManager) throws CameraAccessException {
         for (String cameraId : cameraManager.getCameraIdList()) {
             CameraCharacteristics characteristics = cameraManager.getCameraCharacteristics(cameraId);
             if (characteristics.get(CameraCharacteristics.LENS_FACING)
                 == CameraCharacteristics.LENS_FACING_FRONT) {
                Log.d(TAG, "Using camera id: " + cameraId);
                return cameraId;
             }
        }
        Log.d(TAG, "Using default camera id: " + FRONT_CAMERA_DEFAULT_ID);
        return FRONT_CAMERA_DEFAULT_ID;
    }

    private synchronized void setCameraDevice(CameraDevice cameraDevice) {
        Log.d(TAG, "Camera is opened");
        mCameraDevice = cameraDevice;
        try {
            int picWidth = 1080;
            int picHeight = 1920;
            mImageReader = ImageReader.newInstance(picWidth, picHeight, ImageFormat.JPEG, 2);
            mImageReader.setOnImageAvailableListener(mImageAvailableListener, null);
            List<Surface> surfaces = new LinkedList<Surface>();
            surfaces.add(mImageReader.getSurface());
            Log.d(TAG, "createCaptureSession");
            mCameraDevice.createCaptureSession(surfaces, mCaptureSessionCallback, null);
        } catch (CameraAccessException cae) {
            Log.e(TAG, "Failed to access the camera: " + cae);
        }
    }

    public synchronized void close() {
        if (mCameraDevice != null) {
            mCameraDevice.close();
            mCameraDevice = null;
        }
        if (mImageReader != null) {
            mImageReader.close();
            mImageReader = null;
        }
    }

    private synchronized void startImageCapture(CameraCaptureSession session) {
        if (mCameraDevice != null) {
            try {
                Log.d(TAG, "capturing image");
                CaptureRequest captureRequest = createCaptureRequest();
                session.setRepeatingRequest(captureRequest, mCaptureListener, null);
            } catch (CameraAccessException cae) {
                Log.e(TAG, "Failed to access the camera: " + cae);
            }
        }
    }

    private CaptureRequest createCaptureRequest() throws CameraAccessException {
        CaptureRequest.Builder builder = mCameraDevice.createCaptureRequest(TEMPLATE_STILL_CAPTURE);
        builder.set(CaptureRequest.CONTROL_MODE, CONTROL_MODE_OFF);
        builder.set(CaptureRequest.CONTROL_MODE, CONTROL_MODE_USE_SCENE_MODE);
        builder.set(CaptureRequest.CONTROL_SCENE_MODE, CONTROL_SCENE_MODE_FACE_PRIORITY);
        builder.set(CaptureRequest.STATISTICS_FACE_DETECT_MODE, STATISTICS_FACE_DETECT_MODE_SIMPLE);
        builder.addTarget(mImageReader.getSurface());
        return builder.build();
    }

    private int getJpegOrientation(CameraCharacteristics c, int deviceOrientation) {
        if (deviceOrientation == android.view.OrientationEventListener.ORIENTATION_UNKNOWN) return 0;
        int sensorOrientation = c.get(CameraCharacteristics.SENSOR_ORIENTATION);

        // Round device orientation to a multiple of 90
        deviceOrientation = (deviceOrientation + 45) / 90 * 90;

        // Reverse device orientation for front-facing cameras
        boolean facingFront = c.get(CameraCharacteristics.LENS_FACING) == CameraCharacteristics.LENS_FACING_FRONT;
        if (facingFront) deviceOrientation = -deviceOrientation;

        // Calculate desired JPEG orientation relative to camera orientation to make
        // the image upright relative to the device orientation
        int jpegOrientation = (sensorOrientation + deviceOrientation + 360) % 360;

        return jpegOrientation;
    }

    private void setHasFace(boolean hasFaces) {
        Log.d(TAG, "Found hasFaces=" + hasFaces);
    }

    private ImageReader.OnImageAvailableListener mImageAvailableListener = new ImageReader.OnImageAvailableListener() {
        @Override
        public void onImageAvailable(ImageReader reader) {
            Log.d(TAG, "new image available");
        }
    };

    private CameraDevice.StateCallback mStateCallback = new CameraDevice.StateCallback() {
        @Override
        public void onClosed(CameraDevice camera) {
        }

        @Override
        public void onDisconnected(CameraDevice camera) {
        }

        @Override
        public void onError(CameraDevice camera, int error) {
        }

        @Override
        public void onOpened(CameraDevice camera) {
            setCameraDevice(camera);
        }
    };

    private CameraCaptureSession.StateCallback mCaptureSessionCallback = new CameraCaptureSession.StateCallback() {
        @Override
        public void onActive(CameraCaptureSession session) {
        }

        @Override
        public void onClosed(CameraCaptureSession session) {
        }

        @Override
        public void onConfigureFailed(CameraCaptureSession session) {
        }

        @Override
        public void onConfigured(CameraCaptureSession session) {
        }

        @Override
        public void onReady(CameraCaptureSession session) {
            startImageCapture(session);
        }

    };

    private CameraCaptureSession.CaptureCallback mCaptureListener = new CameraCaptureSession.CaptureCallback() {
        private int mTotalFaces;
        private int mNumSamples;
        private boolean mFinished;

        private synchronized void finish() {
            if (! mFinished) {
                mFinished = true;
                dumpFile("/sdcard/capture.jpeg", getJpegData());
                setHasFace(mTotalFaces > 0);
                close();
            }
        }

        @Override
        public void onCaptureCompleted(CameraCaptureSession session, CaptureRequest request, TotalCaptureResult result) {
            Log.d(TAG, "onCaptureCompleted");
            Face[] faces = result.get(STATISTICS_FACES);
            mTotalFaces += (faces != null ? faces.length : 0);
            mNumSamples++;
            if (mNumSamples >= 10) {
                finish();
            } else {
                getJpegData();
            }
        }

        @Override
        public void onCaptureFailed(CameraCaptureSession session, CaptureRequest request, CaptureFailure failure) {
            Log.d(TAG, "onCaptureFailed");
            close();
        }

        @Override
        public void onCaptureProgressed(CameraCaptureSession session, CaptureRequest request, CaptureResult partialResult) {
            Log.d(TAG, "onCaptureProgressed");
        }

        @Override
        public void onCaptureSequenceAborted(CameraCaptureSession session, int sequenceId) {
            Log.d(TAG, "onCaptureSequenceAborted");
        }

        @Override
        public void onCaptureSequenceCompleted(CameraCaptureSession session, int sequenceId, long frameNumber) {
            Log.d(TAG, "onCaptureSequenceCompleted");
        }

        @Override
        public void onCaptureStarted(CameraCaptureSession session, CaptureRequest request, long timestamp, long frameNumber) {
            Log.d(TAG, "onCaptureStarted");
        }
    };

    private byte[] getJpegData() {
        Image image = mImageReader.acquireNextImage();
        byte[] data = getJpegData(image);
        image.close();
        return data;
    }

    private static byte[] getJpegData(Image image) {
        Plane[] planes = image.getPlanes();
        ByteBuffer buffer = planes[0].getBuffer();
        byte[] data = new byte[buffer.capacity()];
        buffer.get(data);
        return data;
    }

    public static void dumpFile(String fileName, byte[] data) {
        FileOutputStream outStream;
        try {
            Log.v(TAG, "output will be saved as " + fileName);
            outStream = new FileOutputStream(fileName);
        } catch (IOException ioe) {
            throw new RuntimeException("Unable to create debug output file " + fileName, ioe);
        }
        try {
            outStream.write(data);
            outStream.close();
        } catch (IOException ioe) {
            throw new RuntimeException("failed writing data to file " + fileName, ioe);
        }
    }
}
