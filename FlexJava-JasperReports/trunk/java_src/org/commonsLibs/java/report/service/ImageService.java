package org.commonsLibs.java.report.service;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.commonsLibs.java.report.model.ImageFile;

public class ImageService {

	public Collection<ImageFile> findImages()
	{
		List<ImageFile> images = new ArrayList<ImageFile>();

        try
        {
            File file = new File(System.getProperty("catalina.home") + File.separator + "MV" + File.separator + "relatorios" + File.separator);

            images = getImagesFolderList(file);
        }
        catch (Exception e)
        {
        }
        return images;
	}
	
	public ImageFile getImageFileBytes(ImageFile imageFile) throws IOException
	{
		File file = new File(imageFile.getPath());
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
        FileInputStream in = new FileInputStream(file);  
        int b;  
        while((b = in.read())>-1){  
           out.write(b);  
        }  
        out.close();  
        in.close();  
        
        imageFile.setBitmapData(out.toByteArray());
        
        return imageFile;
	}
	
	private List<ImageFile> getImagesFolderList(File file) throws IOException 
    {
        List<ImageFile> images = new ArrayList<ImageFile>();
        
        for (File imgFile : file.listFiles(new Filtro()))
        {
            ImageFile image;
            
            if(!imgFile.isDirectory())
            {
	            image = new ImageFile(imgFile.getName(), imgFile.getAbsolutePath());
	            images.add(image);
            }
        }
        return images;
    }

	public void remover(ImageFile imageFile) throws IOException
    {
    	File file = new File(imageFile.getPath());
    	file.delete();
    }
	
	private class Filtro implements FilenameFilter
    {
        public boolean accept(File dir, String name)
        {
            return name.endsWith(".png") || name.endsWith(".jpg") || name.endsWith(".gif") || new File(dir,name).isDirectory();
        }
    }
	
}
