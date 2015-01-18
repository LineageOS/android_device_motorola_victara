/*
 * Copyright (c) 2014 The CyanogenMod Project
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

package org.cyanogenmod.cmactions;

import java.util.List;

import android.app.IntentService;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ActivityInfo;
import android.content.pm.ResolveInfo;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.provider.MediaStore;
import android.provider.Settings;
import android.util.Log;

public class CMActionsService extends IntentService {
        private static final String TAG = "CMActions";

        private static final int SENSOR_TYPE_MMI_CAMERA_ACTIVATION = 65540;
        private static final int SENSOR_TYPE_MMI_IR_GESTURE = 65541;
        private static final int SENSOR_TYPE_MMI_IR_OBJECT = 65543;
        private static final int SENSOR_TYPE_MMI_STOW = 65539;

        private static final int BATCH_LATENCY_IN_MS = 100;
        private static final int DELAY_BETWEEN_DOZES_IN_MS = 1500;
        private static final int TURN_SCREEN_ON_WAKE_LOCK_MS = 500;

        private PowerManager mPowerManager;
        private SensorManager mSensorManager;

        private Sensor mCameraActivationSensor;
        private Sensor mIrGestureSensor;
        private Sensor mStowSensor;

        private CameraActivationListener mCameraActivationListener;
        private IrGestureListener mIrGestureListener;
        private StowListener mStowListener;

        private boolean mLastStowed = false;
        private long mLastDoze;

        private static Context mContext;

        public CMActionsService(Context context) {
                super("CMActionService");
                mContext = context;

                Log.d(TAG, "Starting");

                IntentFilter filter = new IntentFilter(Intent.ACTION_SCREEN_ON);
                filter.addAction(Intent.ACTION_SCREEN_OFF);
                BroadcastReceiver mReceiver = new ScreenReceiver();
                context.registerReceiver(mReceiver, filter);

                mPowerManager = (PowerManager) context
                                .getSystemService(Context.POWER_SERVICE);

                mSensorManager = (SensorManager) mContext
                                .getSystemService(Context.SENSOR_SERVICE);
                dumpSensorsList();

                mCameraActivationSensor = getUnofficialSensor(SENSOR_TYPE_MMI_CAMERA_ACTIVATION);
                mIrGestureSensor = getUnofficialSensor(SENSOR_TYPE_MMI_IR_GESTURE);
                mStowSensor = getUnofficialSensor(SENSOR_TYPE_MMI_STOW);

                mCameraActivationListener = new CameraActivationListener();
                mIrGestureListener = new IrGestureListener();
                mStowListener = new StowListener();
        }

        @Override
        protected void onHandleIntent(Intent intent) {
        }

        private void dumpSensorsList() {
                List<Sensor> sensorList = mSensorManager.getSensorList(Sensor.TYPE_ALL);
                for (Sensor sensor : sensorList) {
                        Log.d(TAG, "sensor " + sensor.getType() + " = " + sensor.getName()
                                        + " max batch: " + sensor.getFifoMaxEventCount());
                }
        }

        private Sensor getUnofficialSensor(int type) {
                List<Sensor> sensorList = mSensorManager.getSensorList(type);
                if (sensorList.isEmpty()) {
                        throw new RuntimeException("Could not find any sensors of type "
                                        + type);
                }
                return sensorList.get(0);
        }

        private synchronized void dozePulse() {
                long now = System.currentTimeMillis();
                if (now - mLastDoze > DELAY_BETWEEN_DOZES_IN_MS) {
                        Log.d(TAG, "Sending doze.pulse intent");
                        mContext.sendBroadcast(new Intent("com.android.systemui.doze.pulse"));
                        mLastDoze = now;
                }
        }

        private class ScreenReceiver extends BroadcastReceiver {
                @Override
                public void onReceive(Context context, Intent intent) {
                        if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)) {
                                registerListeners();
                        } else if (intent.getAction().equals(Intent.ACTION_SCREEN_ON)) {
                                unregisterListeners();
                        }
                }

                private void registerListeners() {
                        Log.d(TAG, "registering listeners");
                        if (isDozeEnabled()) {
                            //registerListener(mIrGestureSensor, mIrGestureListener);
                            registerListener(mStowSensor, mStowListener);
                        }
                        registerListener(mCameraActivationSensor, mCameraActivationListener);
                }

                private void unregisterListeners() {
                        mSensorManager.unregisterListener(mCameraActivationListener);
                        //mSensorManager.unregisterListener(mIrGestureListener);
                        mSensorManager.unregisterListener(mStowListener);
                }

                private void registerListener(Sensor sensor, SensorEventListener listener) {
                        if (!mSensorManager.registerListener(listener, sensor,
                                        SensorManager.SENSOR_DELAY_NORMAL,
                                        BATCH_LATENCY_IN_MS * 1000)) {
                                throw new RuntimeException(
                                                "Failed to registerListener for sensor " + sensor);
                        }

                }
        }

        private boolean isDozeEnabled() {
                return  Settings.Secure.getInt(mContext.getContentResolver(),
                        Settings.Secure.DOZE_ENABLED, 1) != 0;
        }

        private void turnScreenOn() {
                PowerManager.WakeLock wl = mPowerManager.newWakeLock(
                        PowerManager.SCREEN_BRIGHT_WAKE_LOCK |
                        PowerManager.ACQUIRE_CAUSES_WAKEUP,
                        TAG);
                wl.acquire(TURN_SCREEN_ON_WAKE_LOCK_MS);
        }

        private void launchCameraIntent() {
                Intent intent = new Intent(MediaStore.INTENT_ACTION_STILL_IMAGE_CAMERA_SECURE);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.addFlags(Intent.FLAG_FROM_BACKGROUND);
                PackageManager packageManager = mContext.getPackageManager();
                List <ResolveInfo> activities = packageManager.queryIntentActivities(intent, 0);
                if (activities.size() > 0) {
                        ActivityInfo activity = activities.get(0).activityInfo;
                        ComponentName componentName =new ComponentName(
                                        activity.applicationInfo.packageName,
                                        activity.name);
                        intent.setComponent(componentName);
                }
                mContext.startActivity(intent);
        }

        private class CameraActivationListener implements SensorEventListener {
                @Override
                public void onSensorChanged(SensorEvent event) {
                        Log.d(TAG, "activate camera");
                        turnScreenOn();
                        launchCameraIntent();
                }

                @Override
                public void onAccuracyChanged(Sensor sensor, int accuracy) {
                }
        }

        private class IrGestureListener implements SensorEventListener {
                @Override
                public void onSensorChanged(SensorEvent event) {
                        Log.d(TAG, "ir gesture: [" + event.values.length + "]: "
                                        + event.values[0] + ", " + event.values[1] + ", "
                                        + event.values[2]);

                        dozePulse();
                }

                @Override
                public void onAccuracyChanged(Sensor sensor, int accuracy) {
                }
        }

        private class StowListener implements SensorEventListener {
                @Override
                public void onSensorChanged(SensorEvent event) {
                        boolean thisStowed = (event.values[0] != 0);

                        Log.d(TAG, "stowed event: " + thisStowed + " lastStowed "
                                        + mLastStowed);
                        if (mLastStowed != thisStowed && ! thisStowed) {
                                dozePulse();
                        }
                        mLastStowed = thisStowed;
                }

                @Override
                public void onAccuracyChanged(Sensor sensor, int accuracy) {
                }
        }
}
