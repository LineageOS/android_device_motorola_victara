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
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.telephony.PhoneStateListener;
import android.telecom.TelecomManager;
import android.telephony.TelephonyManager;
import android.util.Log;

import static com.cyanogenmod.settings.device.IrGestureManager.*;
import static android.telephony.TelephonyManager.*;

public class IrSilencer extends PhoneStateListener implements SensorEventListener {
    private static final String TAG = "CMActions-IRSilencer";

    public static final int IR_GESTURES_FOR_RINGING = (1 << IR_GESTURE_SWIPE);

    private TelecomManager mTelecomManager;
    private SensorHelper mSensorHelper;
    private Sensor mSensor;
    private IrGestureVote mIrGestureVote;

    public IrSilencer(Context context, SensorHelper sensorHelper, IrGestureManager irGestureManager) {
        mTelecomManager = (TelecomManager) context.getSystemService(Context.TELECOM_SERVICE);
        TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        mSensorHelper = sensorHelper;
        mSensor = sensorHelper.getIrGestureSensor();
        mIrGestureVote = new IrGestureVote(irGestureManager);
        mIrGestureVote.voteForState(false, 0);

        telephonyManager.listen(this, LISTEN_CALL_STATE);
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        int gesture = (int) event.values[1];

        if (gesture == IR_GESTURE_SWIPE) {
            Log.d(TAG, "event: [" + event.values.length + "]: " + event.values[0] + ", " +
                event.values[1] + ", " + event.values[2]);
            mTelecomManager.silenceRinger();
        }
    }

    @Override
    public void onCallStateChanged(int state, String incomingNumber) {
        if (state == CALL_STATE_RINGING) {
            mSensorHelper.registerListener(mSensor, this);
            mIrGestureVote.voteForState(true, IR_GESTURES_FOR_SCREEN_OFF);
        } else {
            mSensorHelper.unregisterListener(this);
            mIrGestureVote.voteForState(false, 0);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor mSensor, int accuracy) {
    }
}
