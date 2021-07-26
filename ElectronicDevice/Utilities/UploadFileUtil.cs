using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace ElectronicDevice.Utilities
{
    public class UploadFileUtil
    {
        public static bool SaveFile(String base64,string name,String path)
        {
            try
            {
                string ImgName = name;
                if (!string.IsNullOrEmpty(base64))
                {
                    //Image image = Base64ToImage(Image.base64Image);
                    //Check if directory exist
                    if (!System.IO.Directory.Exists(path))
                    {
                        System.IO.Directory.CreateDirectory(path);
                        //If directory doesn't exist then Create it 
                    }
                    //string imageName = ImgName + ".jpg";
                    //set the image path
                    string imgPath = Path.Combine(path, ImgName);
                    if (base64.Contains("data:image"))
                    {
                        //Need To remove some header information at the beginning if image data contains
                        //ImageDataUrl = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD....";
                        //Otherwise, this will give an error.
                        //Remove everything in front of the DataUrl and including the first comma.
                        //ImageDataUrl = "9j/4AAQSkZJRgABAQAAAQABAAD...
                        base64 = base64.Substring(base64.LastIndexOf(',') + 1);
                        // removing extra header information 
                    }
                    byte[] imageBytes = Convert.FromBase64String(base64);
                    MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);
                    ms.Write(imageBytes, 0, imageBytes.Length);
                    System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
                    image.Save(imgPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                }
                return true;

            }
            catch 
            {
                return false;
            }
        }
    }
}