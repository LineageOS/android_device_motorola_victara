package org.cyanogenmod.cmactions;

import android.content.Intent;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

public class ServiceWrapper extends android.app.Service {
	static final String TAG = "CMActions-ServiceWrapper";

	private final IBinder mBinder = new LocalBinder();
	private CMActionsService cmActionsService;

	public interface ServiceCallback {
		void sendResults(int resultCode, Bundle b);
	}

	public class LocalBinder extends Binder {
		ServiceWrapper getService() {
			// Return this instance of the service so clients can call public
			// methods
			return ServiceWrapper.this;
		}
	}

	@Override
	public void onCreate() {
		Log.i(TAG, "onCreate");
		super.onCreate();
		cmActionsService = new CMActionsService(this);
	}

	@Override
	public IBinder onBind(Intent intent) {
		Log.i(TAG, "onBind");
		return null;
	}

	public void setCallback(ServiceCallback callback) {
	}

	public void start() {
		Log.i(TAG, "start");
	}

	public void stop() {
	}

}