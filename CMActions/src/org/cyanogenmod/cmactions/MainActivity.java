package org.cyanogenmod.cmactions;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

public class MainActivity extends Activity {
	private CMActionsService mCMActionsMain;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		// mCMActionsMain = new CMActionsService(this);
		setContentView(new LinearLayout(this));
	}
}
