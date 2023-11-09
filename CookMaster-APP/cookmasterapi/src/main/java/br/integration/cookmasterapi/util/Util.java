package br.integration.cookmasterapi.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.zip.DataFormatException;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;





import com.google.common.base.Charsets;
import com.google.common.base.Strings;
public class Util {

	
	public static byte[] compressData(String messageContent) throws IOException
	{
		byte[] bytes = messageContent.getBytes(Charsets.UTF_8);

		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		GZIPOutputStream gzos = new GZIPOutputStream(bos);
		gzos.write(bytes);
		gzos.close();
		return bos.toByteArray();
	}
	
	public static byte[] compressData(byte[] messageContent) throws IOException
	{
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		GZIPOutputStream gzos = new GZIPOutputStream(bos);
		gzos.write(messageContent);
		gzos.close();
		return bos.toByteArray();
	}
	
	public static String decompress(byte[] bytes) throws IOException, DataFormatException
	{
		InputStream in = new GZIPInputStream(new ByteArrayInputStream(bytes));
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int len;
		while ((len = in.read(buffer)) > 0)
			baos.write(buffer, 0, len);
		return new String(baos.toByteArray(), Charsets.UTF_8);
	}

}
