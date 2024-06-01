package android;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import haxe.Json;
import haxe.Resource;
import lime.app.Event;
import lime.system.JNI;
import android.macros.FlxMacroUtil;

using StringTools;

enum abstract FileDialogType(Int) from Int to Int
{
	public static var fromStringMap(default, null):Map<String, FileDialogType> = FlxMacroUtil.buildMap("android.FileDialogType");
	public static var toStringMap(default, null):Map<FileDialogType, String> = FlxMacroUtil.buildMap("android.FileDialogType", true);
	var OPEN_DOCUMENT = 1;
	var CREATE_DOCUMENT = 2;
	var OPEN_DOCUMENT_TREE = 3;

	@:from
	public static inline function fromString(s:String)
	{
		return fromStringMap.get(s.toUpperCase());
	}

	@:to
	public inline function toString():String
	{
		return 'android.intent.action.${toStringMap.get(this)}';
	}
}

class FileDialog
{
	// public static var onCancel:Event<Void->Void> = new Event<Void->Void>();
	public static var onOpen:Event<Resource->Void> = new Event<Resource->Void>();
	public static var onSave:Event<String->Void> = new Event<String->Void>();
	public static var onSelect:Event<String->Void> = new Event<String->Void>();

	// public static var onSelectMultiple:Event<Array<String>->Void> = new Event<Array<String>->Void>();
	@:noCompletion
	private static var initialized:Bool = false;

	public static function init():Void
	{
		if (initialized)
			return;

		initCallBack_jni(new FileDialogCallBack());

		initialized = true;
	}

	public static function launch(type:FileDialogType, ?mime:String):Void
	{
		launch_jni(type.toString(), type);
	}

	@:noCompletion
	private static var initCallBack_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/FileDialog', 'initCallBack', '(Lorg/haxe/lime/HaxeObject;)V');

	@:noCompletion
	private static var launch_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/FileDialog', 'launch', '(Ljava/lang/String;I)V');
}

@:noCompletion
private class FileDialogCallBack #if (lime >= "8.0.0") implements JNISafety #end
{
	public function new():Void {}

	#if (lime >= "8.0.0")
	@:runOnMainThread
	#end
	public function onActivityResult(content:String):Void
	{
		if (content == null || content.length <= 0)
			return;

		var data:Dynamic = Json.parse(content.trim());

		switch (data.requestCode)
		{
			case 1:
				FileDialog.onOpen.dispatch(data);
			case 2:
				FileDialog.onSave.dispatch(data);
			case 3:
				FileDialog.onSelect.dispatch(data.uri);
		}

		// if (FileDialog.onActivityResult != null)
		// FileDialog.onActivityResult.dispatch(Json.parse(content.trim()));
	}
}
