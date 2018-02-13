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

package com.lineageos.settings.device;

import android.app.IntentService;
import android.content.Context;
import android.content.Intent;
import android.os.PowerManager;
import android.provider.Settings;
import android.util.Log;

import java.util.List;
import java.util.LinkedList;

public class LineageActionsService extends IntentService implements ScreenStateNotifier,
        UpdatedStateNotifier {
    private static final String TAG = "LineageActions";

    private final Context mContext;

    private final DozePulseAction mDozePulseAction;
    private final IrGestureManager mIrGestureManager;
    private final PowerManager mPowerManager;
    private final PowerManager.WakeLock mWakeLock;
    private final ScreenReceiver mScreenReceiver;
    private final SensorHelper mSensorHelper;

    private final List<ScreenStateNotifier> mScreenStateNotifiers = new LinkedList<ScreenStateNotifier>();
    private final List<UpdatedStateNotifier> mUpdatedStateNotifiers =
                        new LinkedList<UpdatedStateNotifier>();

    public LineageActionsService(Context context) {
        super("CMActionService");
        mContext = context;

        Log.d(TAG, "Starting");

        LineageActionsSettings cmActionsSettings = new LineageActionsSettings(context, this);
        mSensorHelper = new SensorHelper(context);
        mScreenReceiver = new ScreenReceiver(context, this);
        mIrGestureManager = new IrGestureManager();

        mDozePulseAction = new DozePulseAction(context);
        mScreenStateNotifiers.add(mDozePulseAction);

        // Actionable sensors get screen on/off notifications
        mScreenStateNotifiers.add(new FlatUpSensor(cmActionsSettings, mSensorHelper, mDozePulseAction));
        mScreenStateNotifiers.add(new IrGestureSensor(cmActionsSettings, mSensorHelper, mDozePulseAction, mIrGestureManager));
        mScreenStateNotifiers.add(new StowSensor(cmActionsSettings, mSensorHelper, mDozePulseAction));
        mScreenStateNotifiers.add(new UserAwareDisplay(cmActionsSettings, mSensorHelper, mIrGestureManager, context));

        // Other actions that are always enabled

        SensorAction cameraAction = cmActionsSettings.newCameraActivationAction();
        SensorAction chopChopAction = cmActionsSettings.newChopChopAction();

        mUpdatedStateNotifiers.add(new CameraActivationSensor(cmActionsSettings, cameraAction, mSensorHelper));
        mUpdatedStateNotifiers.add(new ChopChopSensor(cmActionsSettings, chopChopAction, mSensorHelper));
        mUpdatedStateNotifiers.add(new IrSilencer(cmActionsSettings, context, mSensorHelper,
                mIrGestureManager));

        mPowerManager = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        mWakeLock = mPowerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "LineageActionsWakeLock");
        updateState();
    }

    @Override
    protected void onHandleIntent(Intent intent) {
    }

    @Override
    public void screenTurnedOn() {
        if (!mWakeLock.isHeld()) {
            mWakeLock.acquire();
        }
        for (ScreenStateNotifier screenStateNotifier : mScreenStateNotifiers) {
            screenStateNotifier.screenTurnedOn();
        }
    }

    @Override
    public void screenTurnedOff() {
        if (mWakeLock.isHeld()) {
            mWakeLock.release();
        }
        for (ScreenStateNotifier screenStateNotifier : mScreenStateNotifiers) {
            screenStateNotifier.screenTurnedOff();
        }
    }

    public void updateState() {
        if (mPowerManager.isInteractive()) {
            screenTurnedOn();
        } else {
            screenTurnedOff();
        }
        for (UpdatedStateNotifier notifier : mUpdatedStateNotifiers) {
            notifier.updateState();
        }
    }
}
