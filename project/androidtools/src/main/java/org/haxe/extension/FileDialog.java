package org.haxe.extension;

import android.app.AlertDialog;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.media.MediaCodecList;
import android.media.MediaFormat;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build;
import android.util.ArrayMap;
import android.util.Log;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;
import androidx.core.content.FileProvider;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

/*
	You can use the Android Extension class in order to hook
	into the Android activity lifecycle. This is not required
	for standard Java code, this is designed for when you need
	deeper integration.

	You can access additional references from the Extension class,
	depending on your needs:

	- Extension.assetManager (android.content.res.AssetManager)
	- Extension.callbackHandler (android.os.Handler)
	- Extension.mainActivity (android.app.Activity)
	- Extension.mainContext (android.content.Context)
	- Extension.mainView (android.view.View)

	You can also make references to static or instance methods
	and properties on Java classes. These classes can be included
	as single files using <java path="to/File.java" /> within your
	project, or use the full Android Library Project format (such
	as this example) in order to include your own AndroidManifest
	data, additional dependencies, etc.

	These are also optional, though this example shows a static
	function for performing a single task, like returning a value
	back to Haxe from Java.
*/
public class FileDialog extends Extension
{
	public static final String LOG_TAG = "FileDialog";

	public static HaxeObject cbObject;

	public static Gson gson;

	public static void initCallBack(final HaxeObject cbObject)
	{
		FileDialog.cbObject = cbObject;
	}

	public static void launch(final String action, final int requestCode)
	{
		List<String> actions = new ArrayList<String>();
		actions.add(Intent.ACTION_OPEN_DOCUMENT);
		actions.add(Intent.ACTION_CREATE_DOCUMENT);
		actions.add(Intent.ACTION_OPEN_DOCUMENT_TREE);

		if(!actions.contains(action)) return;

		Intent intent = new Intent(action);
		intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
		intent.addFlags(Intent.FLAG_GRANT_PREFIX_URI_PERMISSION);
		intent.addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
		intent.putExtra(Intent.EXTRA_LOCAL_ONLY, true);
        mainActivity.startActivityForResult(intent, requestCode);
    }

	@Override
	public boolean onActivityResult(int requestCode, int resultCode, Intent data)
	{
		if (cbObject != null)
		{
			ArrayMap<String, Object> content = new ArrayMap<String, Object>();

			content.put("requestCode", requestCode);
			content.put("resultCode", resultCode);

			if (data != null && data.getData() != null)
			{
				content.put("uri", data.getData().toString());
				content.put("path", data.getData().getPath());
			}

			if (gson == null)
				gson = new GsonBuilder().serializeNulls().create();

			cbObject.call("onActivityResult", new Object[] {
				gson.toJson(content)
			});
		}

		return true;
	}
}
