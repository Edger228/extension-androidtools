package org.haxe.extension;

import android.net.Uri;
import android.os.Build;
import android.util.Log;
import android.content.Context;
import android.content.ContentResolver;
import androidx.documentfile.provider.DocumentFile;
import java.io.File;
import java.util.List;
import java.util.ArrayList;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
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
            Tools.makeToastText("init: " + e.toString(), 1, -1, 0, 0);
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
                if ((nextDirectory == null || !nextDirectory.isDirectory()))
                {
                    nextDirectory = currentDirectory.createDirectory(segment);
                }
                currentDirectory = nextDirectory;
            }
        }
        catch (Exception e)
        {
            Tools.makeToastText("createDirectory: " + e.toString(), 1, -1, 0, 0);
        }
    }

    public static void saveBytes(String file, int[] intArray)
    {
        try
        {
            // i'll keep it so we make the directory ourselves in haxe
            DocumentFile targetDirectory = getDirectory(directory(file));

            DocumentFile targetFile = createBinaryFile(targetDirectory, noDirectory(file));

            writeBytesToBinaryFile(targetFile, getBytesArray(intArray));
        }
        catch (Exception e)
        {
            Tools.makeToastText("saveBytes: " + e.toString(), 1, -1, 0, 0);
        }
    }

    public static int[] getBytes(final String file)
    {
        DocumentFile documentFile = getDirectory(file);
        try(InputStream inputStream = contentResolver.openInputStream(documentFile.getUri()))
        {
            byte[] bytes;
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            int bytesRead;
            byte[] data = new byte[4096];
            while ((bytesRead = inputStream.read(data, 0, data.length)) != -1)
            {
                buffer.write(data, 0, bytesRead);
            }
            bytes = buffer.toByteArray();

            int[] intArray = new int[bytes.length];
            for (int i = 0; i < bytes.length; i++)
            {
                intArray[i] = bytes[i] & 0xFF;
            }
            inputStream.close();
            return intArray;
        }
        catch (IOException e)
        {
            Tools.makeToastText("getBytes: " + e.toString(), 1, -1, 0, 0);
            return new int[0];
        }
    }

    private static DocumentFile createBinaryFile(DocumentFile directory, String fileName)
    {
        try
        {
            DocumentFile file = directory.findFile(fileName);
            if (file == null || !file.isFile())
            {
                file = directory.createFile("application/octet-stream", fileName);
            }
            return file;
        }
        catch (Exception e)
        {
            Tools.makeToastText("createBinaryFile: " + e.toString(), 1, -1, 0, 0);
            return rootDocument;
        }
    }

    // it might be named getDirectory but it works as a getFile too ig??
    public static DocumentFile getDirectory(String directory)
    {
        try
        {
            final String dir = directory(directory);
            final String file = noDirectory(directory);

            if((dir == null || dir == "") || dir == "./")
            {
                if(file == null || file == "")
                    return rootDocument;
                else
                    return rootDocument.findFile(file);
            }

            String[] pathSegments = pathToSegments(directory);

            DocumentFile currentDirectory = rootDocument;

            for (String segment : pathSegments)
            {
                DocumentFile nextDirectory = currentDirectory.findFile(segment);
                currentDirectory = nextDirectory;
            }
            return currentDirectory;
        }
        catch (Exception e)
        {
            Tools.makeToastText("getDirectory: " + e.toString(), 1, -1, 0, 0);
            return rootDocument;
        }
    }

    public static String[] readDirectory(String directory)
    {
        try
        {
            final String dir = directory(directory);

            // if no directory was specified, straight up return the list of rootDocument
            // NOTE: readDirectory in FileSystem dosen't actuall work when you give it an empty string... it might work if you give it Sys.getCwd() tho so i'm keeping it this way
            if((dir == null || dir == ""))
                return formatTreeList(rootDocument.listFiles());

            String[] pathSegments = pathToSegments(directory);

            DocumentFile currentDirectory = rootDocument;

            for (String segment : pathSegments)
            {
                DocumentFile nextDirectory = currentDirectory.findFile(segment);
                currentDirectory = nextDirectory;
            }
            return formatTreeList(currentDirectory.listFiles());
        }
        catch (Exception e)
        {
            Tools.makeToastText("readDirectory: " + e.toString(), 1, -1, 0, 0);
            return new String[0];
        }
    }

    private static void writeBytesToBinaryFile(DocumentFile file, byte[] bytes)
    {
        try(OutputStream outputStream = contentResolver.openOutputStream(file.getUri()))
        {
            if (outputStream != null)
            {
                outputStream.write(bytes);
                outputStream.close();
            }
        }
        catch (IOException e)
        {
            Tools.makeToastText("writeBytesToBinaryFile: " + e.toString(), 1, -1, 0, 0);
        }
    }

    private static byte[] getBytesArray(int[] intArray)
    {
        try
        {
            byte[] byteArray = new byte[intArray.length];

            for (int i = 0; i < intArray.length; i++)
            {
                byteArray[i] = (byte) intArray[i];
            }

            return byteArray;
        }
        catch (Exception e)
        {
            Tools.makeToastText("getBytesArray: " + e.toString(), 1, -1, 0, 0);
            return new byte[0];
        }
    }

    private static String noDirectory(final String path)
    {
        // String[] pathSplit = pathToSegments(path);

        // if(!pathSplit[pathSplit.length - 1].contains(".")) return "";

        // return pathSplit[pathSplit.length - 1];

        File file = new File(path);

        return file.getName();
    }

    private static String directory(final String path)
    {
        // if(!noDirectory(path).contains(".")) return path;

        // String[] pathSegments = pathToSegments(path);
        // String[] newArray = new String[pathSegments.length - 1];
        // String pathDir = "";

        // for (int i = 0; i < newArray.length; i++) {
        //     newArray[i] = pathSegments[i];
        // }

		// if (path.charAt(0) == '/')
		// 	pathDir = "/" + pathDir;

		// if (pathDir.charAt(pathDir.length()-1) != '/')
		// 	pathDir += "/";

        // return pathDir;

        File file = new File(path);

        return file.getParent();
    }

    private static String[] pathToSegments(final String path)
    {
        List<String> nonEmptyList = new ArrayList<>();
        for (String str : path.split("/"))
        {
            if (str != null && str != "" && !str.trim().isEmpty())
            {
                nonEmptyList.add(str);
            }
        }

        String[] pathSegments = nonEmptyList.toArray(new String[0]);
        return pathSegments;
    }

    // there probably is a better way to do this but that's what got
    private static String[] formatTreeList(final DocumentFile[] treeList)
    {
        try
        {
            List<String> pathList = new ArrayList<>();

            for(DocumentFile tree : treeList)
            {
                pathList.add(tree.getUri().getPath().split(":")[2]);
            }

            return pathList.toArray(new String[0]);
        }
        catch (Exception e)
        {
            Tools.makeToastText("formatTreeList: " + e.toString(), 1, -1, 0, 0);
            return new String[0];
        }
    }
}
