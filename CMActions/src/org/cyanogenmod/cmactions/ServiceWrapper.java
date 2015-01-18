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
