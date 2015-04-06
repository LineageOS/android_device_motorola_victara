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

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.util.Log;

public class IrGestureSensor implements ActionableSensor, SensorEventListener {
    private static final String TAG = "CMActions-IRGestureSensor";

    // Something occludes the sensor
    public static final int IR_GESTURE_OBJECT_DETECTED             = 1;
    // No occlusion
    public static final int IR_GESTURE_GESTURE_OBJECT_NOT_DETECTED = 2;
    // Swiping above the phone (send doze)
    public static final int IR_GESTURE_SWIPE                       = 3;
    // Hand wave in front of the phone (send doze)
    public static final int IR_GESTURE_APPROACH                    = 4;
    // Gestures not tracked
    public static final int IR_GESTURE_COVER                       = 5;
    public static final int IR_GESTURE_DEPART                      = 6;
    public static final int IR_GESTURE_HOVER                       = 7;
    public static final int IR_GESTURE_HOVER_PULSE                 = 8;
    public static final int IR_GESTURE_PROXIMITY_NONE              = 9;
    public static final int IR_GESTURE_HOVER_FIST                  = 10;

    public static final int IR_GESTURES_FOR_SCREEN_OFF = (1 << IR_GESTURE_SWIPE) | (1 << IR_GESTURE_APPROACH);

    private SensorHelper mSensorHelper;
    private SensorAction mSensorAction;
    private Sensor mSensor;

    static
    {
       System.load("/system/lib/libjni_CMActions.so");
    }

    public IrGestureSensor(SensorHelper sensorHelper, SensorAction action) {
        mSensorHelper = sensorHelper;
        mSensorAction = action;

        mSensor = sensorHelper.getIrGestureSensor();
        nativeSetIrDisabled(true);
    }

    @Override
    public void setScreenOn() {
        Log.d(TAG, "Disabling");
        mSensorHelper.unregisterListener(this);
        if (! nativeSetIrWakeConfig(0)) {
           Log.e(TAG, "Failed setting IR wake config");
        }
        if (!nativeSetIrDisabled(true)) {
            Log.e(TAG, "Failed disabling IR sensor!");
        }
    }

    @Override
    public void setScreenOff() {
        Log.d(TAG, "Enabling");
        mSensorHelper.registerListener(mSensor, this);
        if (! nativeSetIrWakeConfig(IR_GESTURES_FOR_SCREEN_OFF)) {
           Log.e(TAG, "Failed setting IR wake config");
        }
        if (!nativeSetIrDisabled(false)) {
            Log.e(TAG, "Failed enabling IR sensor!");
        }
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        Log.d(TAG, "event: [" + event.values.length + "]: " + event.values[0] + ", " +
            event.values[1] + ", " + event.values[2]);
        mSensorAction.action();
    }

    @Override
    public void onAccuracyChanged(Sensor mSensor, int accuracy) {
    }

    private final native boolean nativeSetIrDisabled(boolean disabled);
    private final native boolean nativeSetIrWakeConfig(int wakeConfig);
}
