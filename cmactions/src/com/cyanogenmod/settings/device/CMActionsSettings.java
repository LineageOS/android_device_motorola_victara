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
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.provider.Settings;

import android.util.Log;

public class CMActionsSettings {
    private static final String TAG = "CMActions";

    private static final int ACTION_NONE = 0;
    private static final int ACTION_LAUNCH_CAMERA = 1;
    private static final int ACTION_TORCH = 2;

    private static final String GESTURE_CAMERA_ACTION_KEY = "gesture_camera_action";
    private static final String GESTURE_CHOP_CHOP_KEY = "gesture_chop_chop";
    private static final String GESTURE_PICK_UP_KEY = "gesture_pick_up";
    private static final String GESTURE_IR_WAKEUP_KEY = "gesture_ir_wake_up";
    private static final String GESTURE_IR_SILENCER_KEY = "gesture_ir_silencer";

    private final Context mContext;
    private final UpdatedStateNotifier mUpdatedStateNotifier;

    private int mCameraGestureAction;
    private int mChopChopAction;
    private boolean mIrWakeUpEnabled;
    private boolean mIrSilencerEnabled;
    private boolean mPickUpGestureEnabled;

    public CMActionsSettings(Context context, UpdatedStateNotifier updatedStateNotifier) {
        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
        loadPreferences(sharedPrefs);
        sharedPrefs.registerOnSharedPreferenceChangeListener(mPrefListener);
        mContext = context;
        mUpdatedStateNotifier = updatedStateNotifier;
    }

    public boolean isCameraGestureEnabled() {
        return mCameraGestureAction != ACTION_NONE;
    }

    public boolean isChopChopGestureEnabled() {
        return mChopChopAction != ACTION_NONE;
    }

    public boolean isDozeEnabled() {
        return (Settings.Secure.getInt(mContext.getContentResolver(),
                                    Settings.Secure.DOZE_ENABLED, 1) != 0);
    }

    public boolean isIrWakeupEnabled() {
        return isDozeEnabled() && mIrWakeUpEnabled;
    }

    public boolean isPickUpEnabled() {
        return isDozeEnabled() && mPickUpGestureEnabled;
    }

    public boolean isIrSilencerEnabled() {
        return mIrSilencerEnabled;
    }

    public void cameraAction() {
        action(mCameraGestureAction);
    }

    public void chopChopAction() {
        action(mChopChopAction);
    }

    private void action(int action) {
        if (action == ACTION_LAUNCH_CAMERA) {
            new CameraActivationAction(mContext).action();
        } else if (action == ACTION_TORCH) {
            new TorchAction(mContext).action();
        }
    }

    private void loadPreferences(SharedPreferences sharedPreferences) {
        mCameraGestureAction = getActionPreference(sharedPreferences, GESTURE_CAMERA_ACTION_KEY);
        mChopChopAction = getActionPreference(sharedPreferences, GESTURE_CHOP_CHOP_KEY);
        mIrWakeUpEnabled = sharedPreferences.getBoolean(GESTURE_IR_WAKEUP_KEY, false);
        mPickUpGestureEnabled = sharedPreferences.getBoolean(GESTURE_PICK_UP_KEY, false);
        mIrSilencerEnabled = sharedPreferences.getBoolean(GESTURE_IR_SILENCER_KEY, false);
    }

    private int getActionPreference(SharedPreferences sharedPreferences, String key) {
        String value = sharedPreferences.getString(key, "0");
        return Integer.valueOf(value);
    }

    private SharedPreferences.OnSharedPreferenceChangeListener mPrefListener =
            new SharedPreferences.OnSharedPreferenceChangeListener() {
        @Override
        public void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key) {
            boolean updated = true;

            if (GESTURE_CAMERA_ACTION_KEY.equals(key)) {
                mCameraGestureAction = getActionPreference(sharedPreferences, GESTURE_CAMERA_ACTION_KEY);
            } else if (GESTURE_CHOP_CHOP_KEY.equals(key)) {
                mChopChopAction = getActionPreference(sharedPreferences, GESTURE_CHOP_CHOP_KEY);
            } else if (GESTURE_IR_WAKEUP_KEY.equals(key)) {
                mIrWakeUpEnabled = sharedPreferences.getBoolean(GESTURE_IR_WAKEUP_KEY, false);
            } else if (GESTURE_PICK_UP_KEY.equals(key)) {
                mPickUpGestureEnabled = sharedPreferences.getBoolean(GESTURE_PICK_UP_KEY, false);
            } else if (GESTURE_IR_SILENCER_KEY.equals(key)) {
                mIrSilencerEnabled = sharedPreferences.getBoolean(GESTURE_IR_SILENCER_KEY, false);
            } else {
                updated = false;
            }

            if (updated) {
                mUpdatedStateNotifier.updateState();
            }
        }
    };
}
