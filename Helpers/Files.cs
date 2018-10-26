using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Newtonsoft.Json;

namespace API.Helpers
{
    public class Files
    {
        internal static object SaveJson(IHostingEnvironment appEnvironment, Dictionary<string, object> res)
        {
            try
            {
                string path =$"{appEnvironment.ContentRootPath}/wwwroot/metadata/";

                //Check if directory exist
                if (!System.IO.Directory.Exists(path))
                {
                    System.IO.Directory.CreateDirectory(path); //Create directory if it doesn't exist
                }

                System.IO.File.WriteAllText($"{path}/data.json", JsonConvert.SerializeObject(res));

                return true;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        internal static object SaveImage(string base64, string name, string type, IHostingEnvironment _appEnvironment, string dir)
        {
            try
            {
                string path = $"{_appEnvironment.ContentRootPath}/wwwroot/uploads/{dir}";  

                //Check if directory exist
                if (!System.IO.Directory.Exists(path))
                {
                    System.IO.Directory.CreateDirectory(path); //Create directory if it doesn't exist
                }

                string imageName = name + $".{type}";

                //set the image path
                string imgPath = Path.Combine(path, imageName);
                string b = base64.Split(new string[] { $"data:image/{type};base64," }, StringSplitOptions.None)[1].Replace(" ", "+");
                b = b.Replace(" ", "+");
                byte[] imageBytes = Convert.FromBase64String(b);
                File.WriteAllBytes(imgPath, imageBytes);

                return true;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }

        internal static object GetFiles(IHostingEnvironment _appEnvironment, string dir)
        {
            try
            {
                string path = $"{_appEnvironment.ContentRootPath}/wwwroot/uploads/{dir}";
                List<string> files = new List<string>();
                if (!System.IO.Directory.Exists(path))
                    return files;
                string[] fileEntries = Directory.GetFiles(path);
                foreach (string fileName in fileEntries)
                   files.Add(fileName.Split("wwwroot/")[1]);
                return files;
            }
            catch (Exception ex)
            {

                return ex.Message;
            }
        }

        internal static object DeleteFile(string path, IHostingEnvironment appEnvironment)
        {
            try
            {
                string fullPath = $"{appEnvironment.ContentRootPath}/wwwroot/{path}";  
                File.Delete(fullPath);
                return true;
            }
            catch (System.Exception e)
            {
               return e.Message;
            }
        }
    }
}