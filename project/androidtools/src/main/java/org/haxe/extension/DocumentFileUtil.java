package org.haxe.extension;

import android.net.Uri;
import android.util.Log;
import android.content.ContentResolver;
import androidx.documentfile.provider.DocumentFile;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import org.haxe.extension.Tools;
import org.haxe.extension.Extension;

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

	public static boolean exists(String path)
	{
		DocumentFile file = getFile(path);

		return (file != null && file.exists());
	}

	public static String fullPath(String path)
	{
		DocumentFile file = getFile(path);

		return (file != null) ? file.getUri().toString() : null;
	}

	public static String absolutePath(String path)
	{
		DocumentFile file = getFile(path);

		return (file != null) ? file.getUri().getPath() : null;
	}

	public static boolean isDirectory(String path)
	{
		DocumentFile file = getFile(path);

		return (file != null && file.isDirectory());
	}

	public static boolean createDirectory(String path)
	{
		try
		{
			String[] segments = pathToSegments(path);
			DocumentFile current = rootDocument;

			for (String segment : segments)
			{
				DocumentFile next = current.findFile(segment);

				if (next == null || !next.isDirectory())
				{
					next = current.createDirectory(segment);
				}

				current = next;
			}
			return true;
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "createDirectory: " + e.toString());
			Tools.makeToastText("Failed to create directory: " + e.getMessage(), 1, -1, 0, 0);
			return false;
		}
	}

	public static boolean deleteFile(String path)
	{
		DocumentFile file = getFile(path);

		return (file != null && file.isFile() && file.delete());
	}

	public static boolean deleteDirectory(String path)
	{
		DocumentFile dir = getFile(path);

		return (dir != null && dir.isDirectory() && dir.delete());
	}

	public static String[] readDirectory(String path)
	{
		DocumentFile dir = getFile(path);

		if (dir != null && dir.isDirectory())
			return formatTreeList(dir.listFiles());

		return new String[0];
	}

	public static String getContent(String path)
	{
		DocumentFile file = getFile(path);

		if (file != null && file.isFile())
		{
			try
			{
				InputStream is = contentResolver.openInputStream(file.getUri());

				BufferedReader reader = new BufferedReader(new InputStreamReader(is));
				StringBuilder sb = new StringBuilder();
				String line;

				while ((line = reader.readLine()) != null)
					sb.append(line).append("\n");

				return sb.toString();
			}
			catch (IOException e)
			{
				Log.e(LOG_TAG, "getContent: " + e.toString());
			}
		}

		return null;
	}

	public static boolean saveContent(String path, String content)
	{
		DocumentFile file = getFile(path);

		if (file == null)
		{
			DocumentFile dir = getDirectory(directory(path));

			file = dir.createFile("text/plain", noDirectory(path));
		}

		try
		{
			OutputStream os = contentResolver.openOutputStream(file.getUri());
	
			OutputStreamWriter writer = new OutputStreamWriter(os);
			writer.write(content);
			writer.flush();

			return true;
		}
		catch (IOException e)
		{
			Log.e(LOG_TAG, "saveContent: " + e.toString());
		}

		return false;
	}

	public static byte[] getBytes(String path)
	{
		DocumentFile file = getFile(path);

		if (file != null && file.isFile())
		{
			try
			{
				InputStream is = contentResolver.openInputStream(file.getUri());

				ByteArrayOutputStream buffer = new ByteArrayOutputStream();
				byte[] data = new byte[4096];
				int bytesRead;

				while ((bytesRead = is.read(data)) != -1)
				{
					buffer.write(data, 0, bytesRead);
				}

				return buffer.toByteArray();
			}
			catch (IOException e)
			{
				Log.e(LOG_TAG, "getBytes: " + e.toString());
			}
		}

		return new byte[0];
	}

	public static boolean saveBytes(String path, byte[] bytes)
	{
		DocumentFile file = getFile(path);

		if (file == null)
		{
			DocumentFile dir = getDirectory(directory(path));
			file = dir.createFile("application/octet-stream", noDirectory(path));
		}

		try
		{
			OutputStream os = contentResolver.openOutputStream(file.getUri());
			os.write(bytes);
			return true;
		}
		catch (IOException e)
		{
			Log.e(LOG_TAG, "saveBytes: " + e.toString());
		}

		return false;
	}

	private static DocumentFile getDirectory(String path)
	{
		try
		{
			if (isRootDirectory(path))
				return rootDocument;

			String[] segments = pathToSegments(path);
			DocumentFile current = rootDocument;

			for (String segment : segments)
			{
				DocumentFile next = current.findFile(segment);

				if (next == null || !next.isDirectory())
					return null;

				current = next;
			}

			return current;
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "getDirectory: " + e.toString());
			return null;
		}
	}

	private static DocumentFile getFile(String path)
	{
		try
		{
			if (isRootDirectory(path))
				return null;

			String[] segments = pathToSegments(path);
			DocumentFile current = rootDocument;

			for (int i = 0; i < segments.length - 1; i++)
			{
				DocumentFile next = current.findFile(segments[i]);

				if (next == null || !next.isDirectory())
					return null;

				current = next;
			}

			return current.findFile(segments[segments.length - 1]);
		}
		catch (Exception e)
		{
			Log.e(LOG_TAG, "getFile: " + e.toString());
			return null;
		}
	}

	private static boolean isRootDirectory(String path)
	{
		return path == null || path.trim().isEmpty() || path.equals(".");
	}

	private static String[] pathToSegments(String path)
	{
		List<String> segments = new ArrayList<>();

		for (String segment : path.split("/"))
		{
			if (!segment.trim().isEmpty())
				segments.add(segment);
		}

		return segments.toArray(new String[0]);
	}

	private static String noDirectory(String path)
	{
		return new File(path).getName();
	}

	private static String directory(String path)
	{
		return new File(path).getParent();
	}

	private static String[] formatTreeList(DocumentFile[] files)
	{
		List<String> fileList = new ArrayList<>();

		for (DocumentFile file : files)
		{
			fileList.add(file.getName());
		}

		return fileList.toArray(new String[0]);
	}
}
