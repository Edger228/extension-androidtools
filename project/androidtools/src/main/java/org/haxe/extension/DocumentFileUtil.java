package org.haxe.extension;

import android.net.Uri;
import android.util.Log;
import android.content.ContentResolver;
import androidx.documentfile.provider.DocumentFile;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.ByteArrayOutputStream;
import org.haxe.extension.Tools;
import org.haxe.extension.Extension;

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
public class DocumentFileUtil extends Extension
{
	public static final String LOG_TAG = "DocumentFileUtil";

	public static Uri rootUri;
	public static DocumentFile rootDocument;
	public static ContentResolver contentResolver;

	public static void init(String uriString)
	{
		try
		{
			rootUri = Uri.parse(uriString);
			rootDocument = DocumentFile.fromTreeUri(mainContext, rootUri);
			contentResolver = mainContext.getContentResolver();
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "init: " + e.toString());
			Tools.makeToastText("Initialization failed: " + e.getMessage(), 1, -1, 0, 0);
		}
	}

	public static void createDirectory(String directory)
	{
		try
		{
			String[] pathSegments = pathToSegments(directory);
			DocumentFile currentDirectory = rootDocument;

			for (String segment : pathSegments)
			{
				DocumentFile nextDirectory = currentDirectory.findFile(segment);

				if (nextDirectory == null || !nextDirectory.isDirectory())
					nextDirectory = currentDirectory.createDirectory(segment);

				currentDirectory = nextDirectory;
			}
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "createDirectory: " + e.toString());
			Tools.makeToastText("Failed to create directory: " + e.getMessage(), 1, -1, 0, 0);
		}
	}

	public static void saveBytes(String file, int[] intArray)
	{
		try
		{
			DocumentFile targetFile = getFile(file);

			if (targetFile == null || !targetFile.isFile())
			{
				DocumentFile parentDirectory = getDirectory(directory(file));

				if (parentDirectory == null)
					throw new IOException("Target directory not found: " + directory(file));

				targetFile = parentDirectory.createFile("application/octet-stream", noDirectory(file));
			}

			writeBytesToBinaryFile(targetFile, getBytesArray(intArray));
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "saveBytes: " + e.toString());
			Tools.makeToastText("Failed to save bytes: " + e.getMessage(), 1, -1, 0, 0);
		}
	}

	public static int[] getBytes(final String file)
	{
		DocumentFile documentFile = getFile(file);

		if (documentFile == null || !documentFile.isFile())
		{
			Tools.makeToastText("File not found: " + file, 1, -1, 0, 0);
			return new int[0];
		}

		try (InputStream inputStream = contentResolver.openInputStream(documentFile.getUri()))
		{
			ByteArrayOutputStream buffer = new ByteArrayOutputStream();
			byte[] data = new byte[4096];
			int bytesRead;

			while ((bytesRead = inputStream.read(data)) != -1)
			{
				buffer.write(data, 0, bytesRead);
			}

			byte[] bytes = buffer.toByteArray();
			int[] intArray = new int[bytes.length];

			for (int i = 0; i < bytes.length; i++)
			{
				intArray[i] = bytes[i] & 0xFF;
			}

			return intArray;
		}
		catch (IOException e)
		{
			Log.e(LOG_TAG, "getBytes: " + e.toString());

			Tools.makeToastText("Failed to get bytes: " + e.getMessage(), 1, -1, 0, 0);

			return new int[0];
		}
	}

	private static DocumentFile createBinaryFile(DocumentFile directory, String fileName)
	{
		try
		{
			DocumentFile file = directory.findFile(fileName);

			if (file == null || !file.isFile())
				file = directory.createFile("application/octet-stream", fileName);

			return file;
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "createBinaryFile: " + e.toString());
			Tools.makeToastText("Failed to create binary file: " + e.getMessage(), 1, -1, 0, 0);
			return null;
		}
	}

	public static DocumentFile getDirectory(String path)
	{
		try
		{
			if (isRootDirectory(path))
				return rootDocument;

			String[] pathSegments = pathToSegments(path);
			DocumentFile currentDirectory = rootDocument;

			for (String segment : pathSegments)
			{
				DocumentFile nextDirectory = currentDirectory.findFile(segment);

				if (nextDirectory == null || !nextDirectory.isDirectory())
					return null;

				currentDirectory = nextDirectory;
			}

			return currentDirectory;
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "getDirectory: " + e.toString());
			Tools.makeToastText("Failed to get directory: " + e.getMessage(), 1, -1, 0, 0);
			return null;
		}
	}

	public static DocumentFile getFile(String path)
	{
		try
		{
			if (isRootDirectory(path))
				return null;

			String[] pathSegments = pathToSegments(path);
			DocumentFile currentDirectory = rootDocument;

			for (int i = 0; i < pathSegments.length - 1; i++)
			{
				DocumentFile nextDirectory = currentDirectory.findFile(pathSegments[i]);

				if (nextDirectory == null || !nextDirectory.isDirectory())
					return null;

				currentDirectory = nextDirectory;
			}

			return currentDirectory.findFile(pathSegments[pathSegments.length - 1]);
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "getFile: " + e.toString());
			Tools.makeToastText("Failed to get file: " + e.getMessage(), 1, -1, 0, 0);
			return null;
		}
	}

	public static String[] readDirectory(String directory)
	{
		try
		{
			DocumentFile targetDirectory = getDirectory(directory);

			if (targetDirectory == null || !targetDirectory.isDirectory())
			{
				Tools.makeToastText("Directory not found: " + directory, 1, -1, 0, 0);
				return new String[0];
			}

			return formatTreeList(targetDirectory.listFiles());
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "readDirectory: " + e.toString());
			Tools.makeToastText("Failed to read directory: " + e.getMessage(), 1, -1, 0, 0);
			return new String[0];
		}
	}

	private static void writeBytesToBinaryFile(DocumentFile file, byte[] bytes)
	{
		try (OutputStream outputStream = contentResolver.openOutputStream(file.getUri()))
		{
			if (outputStream != null)
				outputStream.write(bytes);
		}
		catch (IOException e)
		{
			Log.e(LOG_TAG, "writeBytesToBinaryFile: " + e.toString());
			Tools.makeToastText("Failed to write bytes: " + e.getMessage(), 1, -1, 0, 0);
		}
	}

	private static byte[] getBytesArray(int[] intArray)
	{
		byte[] byteArray = new byte[intArray.length];

		for (int i = 0; i < intArray.length; i++)
			byteArray[i] = (byte) intArray[i];

		return byteArray;
	}

	private static String noDirectory(final String path)
	{
		return new File(path).getName();
	}

	private static String directory(final String path)
	{
		return new File(path).getParent();
	}

	private static String[] pathToSegments(final String path)
	{
		List<String> nonEmptyList = new ArrayList<String>();
	
		for (String str : path.split("/"))
		{
			if (!str.trim().isEmpty())
				nonEmptyList.add(str);
		}

		return nonEmptyList.toArray(new String[0]);
	}

	private static String[] formatTreeList(final DocumentFile[] treeList)
	{
		List<String> pathList = new ArrayList<>();

		for (DocumentFile tree : treeList)
		{
			String[] splitPath = tree.getUri().getPath().split(":");

			if (splitPath.length > 1)
				pathList.add(splitPath[1]);
			else
				pathList.add(splitPath[0]);
		}

		return pathList.toArray(new String[0]);
	}

	private static boolean isRootDirectory(String path)
	{
		return path == null || path.trim().isEmpty() || path.equals(".");
	}
}
