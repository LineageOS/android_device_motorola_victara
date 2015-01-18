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

import org.cyanogenmod.cmactions.ServiceWrapper.LocalBinder;

import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;

public class BootCompletedReceiver extends BroadcastReceiver {
        static final String TAG = "CMActions";
        private ServiceWrapper serviceWrapper;

        @Override
        public void onReceive(final Context context, Intent intent) {
                Log.i(TAG, "Booting");
                context.startService(new Intent(context, ServiceWrapper.class));
        }

        private ServiceConnection serviceConnection = new ServiceConnection() {
                @Override
                public void onServiceConnected(ComponentName className, IBinder service) {
                        LocalBinder binder = (LocalBinder) service;
                        serviceWrapper = binder.getService();
                        serviceWrapper.start();
                }

                @Override
                public void onServiceDisconnected(ComponentName className) {
                        serviceWrapper = null;
                }
        };
}
