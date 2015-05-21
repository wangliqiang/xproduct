/**  
 * @Project: xproduct
 * @Title: ZipUtils.java
 * @Package cn.com.checknull.util
 * @Description: TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-12 下午2:42:59
 * @Copyright: 2015 check_null Reserved.
 * @version v1.0  
 */

package cn.com.checknull.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.zip.ZipException;

import org.apache.commons.io.FileUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName ZipUtils
 * @Description TODO
 * @author chenweiliu chenwei.liu@163.com
 * @date 2015-3-12 下午2:42:59
 */
public final class ZipUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(ZipUtils.class);
	
	/**
	 * 
	* @Title: unZip 
	* @Description: 解压
	* @param jar
	* @param subDir
	* @param loc
	* @param force
	 */
	 public static void unZip(String jar, String subDir, String loc, boolean force){
	        try {
	            File base=new File(loc);
	            if(!base.exists()){
	                base.mkdirs();
	            }

	            ZipFile zip=new ZipFile(new File(jar));
	            Enumeration<? extends ZipEntry> entrys = zip.getEntries();
	            while(entrys.hasMoreElements()){
	                ZipEntry entry = entrys.nextElement();
	                String name=entry.getName();
	                if(!name.startsWith(subDir)){
	                    continue;
	                }
	                //去掉subDir
	                name=name.replace(subDir,"").trim();
	                if(name.length()<2){
	                	logger.debug(name+" 长度 < 2");
	                    continue;
	                }
	                if(entry.isDirectory()){
	                    File dir=new File(base,name);
	                    if(!dir.exists()){
	                        dir.mkdirs();
	                        logger.debug("创建目录");
	                    }else{
	                    	logger.debug("目录已经存在");
	                    }
	                    logger.debug(name+" 是目录");
	                }else{
	                    File file=new File(base,name);
	                    if(file.exists() && force){
	                        file.delete();
	                    }
	                    if(!file.exists()){
	                        InputStream in=zip.getInputStream(entry);
	                        FileUtils.copyInputStreamToFile(in,file);
	                        logger.debug("创建文件");
	                    }else{
	                    	logger.debug("文件已经存在");
	                    }
	                    logger.debug(name+" 不是目录");
	                }
	            }
	        } catch (ZipException ex) {
	        	logger.error("文件解压失败",ex);
	        } catch (IOException ex) {
	        	logger.error("文件操作失败",ex);
	        }
	    }
	 
	/**
	 * 
	 * @Title: createZip
	 * @Description: 压缩文件夹
	 * @param sourcePath
	 * @param zipPath
	 */
	public static void createZip(String sourcePath, String zipPath) {
		FileOutputStream fos = null;
        ZipOutputStream zos = null;
        try {
            fos = new FileOutputStream(zipPath);
            zos = new ZipOutputStream(fos);
            writeZip(new File(sourcePath), "", zos);
            logger.info("创建ZIP文件成功，存放位置：" + zipPath);
        } catch (FileNotFoundException e) {
        	logger.error("创建ZIP文件失败",e);
        } finally {
            try {
                if (zos != null) {
                    zos.close();
                }
            } catch (IOException e) {
            	logger.error("创建ZIP文件失败",e);
            }
        }
	}

	private static void writeZip(File file, String parentPath,
			ZipOutputStream zos) {
		if (file.exists()) {
			if (file.isDirectory()) {// 处理文件夹
				parentPath += file.getName() + File.separator;
				File[] files = file.listFiles();
				for (File f : files) {
					writeZip(f, parentPath, zos);
				}
			} else {
				FileInputStream fis = null;
				try {
					fis = new FileInputStream(file);
					ZipEntry ze = new ZipEntry(parentPath + file.getName());
					zos.putNextEntry(ze);
					byte[] content = new byte[1024];
					int len;
					while ((len = fis.read(content)) != -1) {
						zos.write(content, 0, len);
						zos.flush();
					}

				} catch (FileNotFoundException e) {
					logger.error("创建ZIP文件失败", e);
				} catch (IOException e) {
					logger.error("创建ZIP文件失败", e);
				} finally {
					try {
						if (fis != null) {
							fis.close();
						}
					} catch (IOException e) {
						logger.error("创建ZIP文件失败", e);
					}
				}
			}
		}
	}
}
