/*
 * Copyright (c) 2014 The CyanogenMod Project
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 * Also add information on how to contact you by electronic and paper mail.
 *
 */

package org.cyanogenmod.cmactions;

import java.util.List;

import android.app.IntentService;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.util.Log;

public class CMActionsService extends IntentService {
	private static final String TAG = "CMActions";

	private static final int SENSOR_TYPE_MMI_IR_GESTURE = 65541;
	private static final int SENSOR_TYPE_MMI_IR_OBJECT = 65543;
	private static final int SENSOR_TYPE_MMI_STOW = 65539;

	private static final int DOZE_WAKELOCK_IN_MS = 500;
	private static final int DELAY_BETWEEN_DOZES_IN_MS = 1500;
	private static final int BATCH_LATENCY_IN_MS = 100;

	private PowerManager mPowerManager;
	private SensorManager mSensorManager;

	//private Sensor mIrGestureSensor;
	private Sensor mIrStowSensor;
	private boolean mLastStowed = false;
	private long mLastDoze;

	private static Context mContext;

	public CMActionsService(Context context) {
		super("CMActionService");
		mContext = context;

		Log.i(TAG, "Starting");

		mPowerManager = (PowerManager) context
				.getSystemService(Context.POWER_SERVICE);

		mSensorManager = (SensorManager) mContext
				.getSystemService(Context.SENSOR_SERVICE);
		dumpSensorsList();

		//mIrGestureSensor = getUnofficialSensorAndListen(
		//		SENSOR_TYPE_MMI_IR_GESTURE, new IrGestureListener());
		mIrStowSensor = getUnofficialSensorAndListen(SENSOR_TYPE_MMI_STOW,
				new StowListener());
	}

	@Override
	protected void onHandleIntent(Intent intent) {
	}

	private void dumpSensorsList() {
		List<Sensor> sensorList = mSensorManager.getSensorList(Sensor.TYPE_ALL);
		for (Sensor sensor : sensorList) {
			Log.i(TAG, "sensor " + sensor.getType() + " = " + sensor.getName()
					+ " max batch: " + sensor.getFifoMaxEventCount());
		}
	}

	private Sensor getUnofficialSensorAndListen(int type,
			SensorEventListener listener) {
		List<Sensor> sensorList = mSensorManager.getSensorList(type);
		if (sensorList.isEmpty()) {
			throw new RuntimeException("Could not find any sensors of type "
					+ type);
		}
		Sensor sensor = sensorList.get(0);
		if (!mSensorManager.registerListener(listener, sensor,
				SensorManager.SENSOR_DELAY_NORMAL, BATCH_LATENCY_IN_MS * 1000)) {
			// if (!mSensorManager.registerListener(listener, sensor,
			// SensorManager.SENSOR_DELAY_FASTEST)) {
			throw new RuntimeException(
					"Failed to listen for updates for sensor type " + type);
		}
		return sensor;
	}

	private synchronized boolean dozePulse() {
		long now = System.currentTimeMillis();
		if (now - mLastDoze > DELAY_BETWEEN_DOZES_IN_MS) {
			Log.i(TAG, "Sending doze.pulse intent");
			mContext.sendBroadcast(new Intent("com.android.systemui.doze.pulse"));
			mLastDoze = now;
			return true;
		} else {
			return false;
		}
	}

	private WakeLock getWakeLock() {
		WakeLock wakeLock = mPowerManager.newWakeLock(
				PowerManager.PARTIAL_WAKE_LOCK, "WakeForDoze");
		wakeLock.acquire(DOZE_WAKELOCK_IN_MS);
		return wakeLock;
	}

	private class IrGestureListener implements SensorEventListener {
		@Override
		public void onSensorChanged(SensorEvent event) {
			WakeLock wakeLock = getWakeLock();
			Log.i(TAG, "ir gesture: [" + event.values.length + "]: "
					+ event.values[0] + ", " + event.values[1] + ", "
					+ event.values[2]);

			if (!dozePulse()) {
				wakeLock.release();
			}
		}

		@Override
		public void onAccuracyChanged(Sensor sensor, int accuracy) {
		}
	}

	private class StowListener implements SensorEventListener {
		@Override
		public void onSensorChanged(SensorEvent event) {
			WakeLock wakeLock = getWakeLock();
			boolean sentDoze = false;
			boolean thisStowed = (event.values[0] != 0);

			Log.i(TAG, "stowed event: " + thisStowed + " lastStowed "
					+ mLastStowed);
			if (mLastStowed != thisStowed) {
				mLastStowed = thisStowed;
				if (mLastStowed) {
				} else {
					sentDoze = dozePulse();
				}
			}

			if (!sentDoze) {
				wakeLock.release();
			}
		}

		@Override
		public void onAccuracyChanged(Sensor sensor, int accuracy) {
		}
	}
}
