package android;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import lime.system.JNI;
import lime.utils.Log;
import haxe.io.Bytes;

class DocumentFileUtil
{
    private static var initialized:Bool = false;

    public static function init(treeUri:String):Void
    {
        init_jni(treeUri);

        initialized = true;
    }

    public static function createDirectory(directory:String):Void
    {
        createDirectory_jni(directory);
    }

    public static function saveBytes(path:String, bytes:Bytes):Void
    {
        var bytesInt:Array<Int> = cast bytes.getData();

        saveBytes_jni(path, bytesInt);
    }

    public static function saveContent(path:String, content:String):Void
    {
        var bytesInt:Array<Int> = cast Bytes.ofString(content).getData();
        saveBytes_jni(path, bytesInt);
    }

    public static function getBytes(path:String):Bytes
    {
        var bytesInt:Array<Int> = getBytes_jni(path);

        return Bytes.ofData(cast bytesInt);
    }

    public static function getContent(path:String):String
    {
        return getBytes(path).toString();
    }

    public static function readDirectory(path:String):Array<String>
    {
        return readDirectory_jni(path);
    }

    @:noCompletion
	private static var init_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'init', '(Ljava/lang/String;)V');

    @:noCompletion
	private static var createDirectory_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'createDirectory', '(Ljava/lang/String;)V');

    @:noCompletion
	private static var saveBytes_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'saveBytes', '(Ljava/lang/String;[I)V');

    @:noCompletion
	private static var getBytes_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'getBytes', '(Ljava/lang/String;)[I');

    @:noCompletion
	private static var readDirectory_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'readDirectory', '(Ljava/lang/String;)[Ljava/lang/String;');
}
