package android;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import haxe.io.Bytes;
import lime.system.JNI;
import lime.utils.Log;

/**
 * Utility class for interacting with the Android DocumentFile API.
 */
class DocumentFileUtil
{
	private static var initialized:Bool = false;

	/**
	 * Initializes the DocumentFileUtil with the specified root URI.
	 *
	 * @param uriString The string representation of the root URI.
	 */
	public static function init(uriString:String, forceInitialize:Bool = false):Void
	{
		if (initialized && !forceInitialize)
			return;

		Log.info('Initializing DocumentFileUtil with "$uriString" root URI.');

		init_jni(uriString);

		initialized = true;
	}

	/**
	 * Checks if a file or directory exists at the specified path.
	 *
	 * @param path The path to the file or directory.
	 *
	 * @return true if the file or directory exists, false otherwise.
	 */
	public static function exists(path:String):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return exists_jni(path);
	}

	/**
	 * Returns the full path of the file or directory specified by `path`.
	 *
	 * @param path The path to the file or directory.
	 *
	 * @return The full path as a string, or null if the path does not exist.
	 */
	public static function fullPath(path:String):String
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return fullPath_jni(path);
	}

	/**
	 * Returns the absolute path of the file or directory specified by `path`.
	 *
	 * @param path The path to the file or directory.
	 *
	 * @return The absolute path as a string, or null if the path does not exist.
	 */
	public static function absolutePath(path:String):String
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return absolutePath_jni(path);
	}

	/**
	 * Checks if the specified path is a directory.
	 *
	 * @param path The path to check.
	 *
	 * @return true if the path is a directory, false otherwise.
	 */
	public static function isDirectory(path:String):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return isDirectory_jni(path);
	}

	/**
	 * Creates a directory at the specified path.
	 *
	 * @param path The path where the directory should be created.
	 *
	 * @return true if the directory was created successfully, false otherwise.
	 */
	public static function createDirectory(path:String):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return createDirectory_jni(path);
	}

	/**
	 * Deletes the file at the specified path.
	 *
	 * @param path The path to the file to delete.
	 *
	 * @return true if the file was deleted successfully, false otherwise.
	 */
	public static function deleteFile(path:String):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return deleteFile_jni(path);
	}

	/**
	 * Deletes the directory at the specified path.
	 *
	 * @param path The path to the directory to delete.
	 *
	 * @return true if the directory was deleted successfully, false otherwise.
	 */
	public static function deleteDirectory(path:String):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return deleteDirectory_jni(path);
	}

	/**
	 * Reads the contents of the directory at the specified path.
	 *
	 * @param path The path to the directory to read.
	 *
	 * @return An array of strings representing the names of the files and directories in the specified directory.
	 */
	public static function readDirectory(path:String):Array<String>
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return readDirectory_jni(path);
	}

	/**
	 * Gets the content of the file at the specified path as a string.
	 *
	 * @param path The path to the file.
	 *
	 * @return The content of the file as a string, or null if the file does not exist or an error occurred.
	 */
	public static function getContent(path:String):String
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return getContent_jni(path);
	}

	/**
	 * Saves the specified content to the file at the specified path.
	 *
	 * @param path The path to the file.
	 * @param content The content to save to the file.
	 *
	 * @return true if the content was saved successfully, false otherwise.
	 */
	public static function saveContent(path:String, content:String):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return saveContent_jni(path, content);
	}

	/**
	 * Gets the content of the file at the specified path as a byte array.
	 *
	 * @param path The path to the file.
	 *
	 * @return The content of the file as a byte array, or an empty byte array if the file does not exist or an error occurred.
	 */
	public static function getBytes(path:String):Bytes
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return Bytes.ofData(getBytes_jni(path));
	}

	/**
	 * Saves the specified byte array to the file at the specified path.
	 *
	 * @param path The path to the file.
	 * @param bytes The byte array to save to the file.
	 *
	 * @return true if the byte array was saved successfully, false otherwise.
	 */
	public static function saveBytes(path:String, bytes:Bytes):Bool
	{
		if (!initialized)
			Log.error('DocumentFileUtil is not initialized. Call init() first.');

		return saveBytes_jni(path, bytes.getData());
	}

	@:noCompletion
	private static var init_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'init', '(Ljava/lang/String;)V');

	@:noCompletion
	private static var exists_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'exists', '(Ljava/lang/String;)Z');

	@:noCompletion
	private static var fullPath_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'fullPath',
		'(Ljava/lang/String;)Ljava/lang/String;');

	@:noCompletion
	private static var absolutePath_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'absolutePath',
		'(Ljava/lang/String;)Ljava/lang/String;');

	@:noCompletion
	private static var isDirectory_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'isDirectory', '(Ljava/lang/String;)Z');

	@:noCompletion
	private static var createDirectory_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'createDirectory', '(Ljava/lang/String;)Z');

	@:noCompletion
	private static var deleteFile_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'deleteFile', '(Ljava/lang/String;)Z');

	@:noCompletion
	private static var deleteDirectory_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'deleteDirectory', '(Ljava/lang/String;)Z');

	@:noCompletion
	private static var readDirectory_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'readDirectory',
		'(Ljava/lang/String;)[Ljava/lang/String;');

	@:noCompletion
	private static var getContent_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'getContent',
		'(Ljava/lang/String;)Ljava/lang/String;');

	@:noCompletion
	private static var saveContent_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'saveContent',
		'(Ljava/lang/String;Ljava/lang/String;)Z');

	@:noCompletion
	private static var getBytes_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'getBytes', '(Ljava/lang/String;)[B');

	@:noCompletion
	private static var saveBytes_jni:Dynamic = JNI.createStaticMethod('org/haxe/extension/DocumentFileUtil', 'saveBytes', '(Ljava/lang/String;[B)Z');
}
