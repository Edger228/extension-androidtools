package android;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import haxe.Json;
import haxe.Resource;
import lime.app.Event;
import lime.system.JNI;

enum abstract FileDialogType(String) from String to String
{
	var OPEN_DOCUMENT = 'android.intent.action.OPEN_DOCUMENT';
	var CREATE_DOCUMENT = 'android.intent.action.CREATE_DOCUMENT';
	var OPEN_DOCUMENT_TREE = 'android.intent.action.OPEN_DOCUMENT_TREE';
}

class FileDialog
{
	public static var onCancel:Event<Void->Void> = new Event<Void->Void>();
	public static var onOpen:Event<Resource->Void> = new Event<Resource->Void>();
	public static var onSave:Event<String->Void> = new Event<String->Void>();
	public static var onSelect:Event<String->Void> = new Event<String->Void>();
	public static var onSelectMultiple:Event<Array<String>->Void> = new Event<Array<String>->Void>();

	@:noCompletion
	private static var initialized:Bool = false;

	public static function init():Void
	{
		if (initialized)
			return;

		initCallBack_jni(new FileDialogCallBack());

		initialized = true;
	}

	public static function launch(type:FileDialogType, mime:String, requestCode:Int = 1):Void
	{
		launch_jni(type, requestCode);
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

		// if (FileDialog.onActivityResult != null)
			// FileDialog.onActivityResult.dispatch(Json.parse(content.trim()));
	}
}
