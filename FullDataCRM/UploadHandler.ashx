<%@ WebHandler Language="C#" Class="UploadHandler" %>

using System;
using System.Web;
using System.IO;

public class UploadHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.AllKeys[0] == "FileUploader")
        {
            for (int i = 0; i < context.Request.Files.Count; i++)
            {
                if (context.Request.Files.AllKeys[0] == "FileUploader" && context.Request.Files[i].FileName != "")
                {
                    HttpPostedFile postedFile = context.Request.Files[i];
                    string folderPath = context.Server.MapPath("~/Uploads/");
                    string fileName = Path.GetFileName(postedFile.FileName);
                    postedFile.SaveAs(folderPath + fileName);
                }
            }
        }


        else
        {
            Random RandomNumber = new Random();
            //string FileRandom = RandomNumber.Next(0, 999999).ToString();
            string FileRandom = "";
            HttpFileCollection files = context.Request.Files;
            HttpPostedFile file = files[0];
            string FileType = GetFileType(file.FileName);
            string fileName = System.IO.Path.GetFileName(file.FileName).Replace("&", "-");
            fileName = System.IO.Path.GetFileName(fileName).Replace(" ", "__");
            if (System.IO.File.Exists(context.Server.MapPath("~/Uploads/") + "" + fileName))
            {
                FileRandom = RandomNumber.Next(0, 999999).ToString();
            }

            string fname = context.Server.MapPath("~/Uploads/" + FileRandom + fileName);
            file.SaveAs(fname);
            context.Response.Write(FileRandom + fileName + "," + fileName + "," + FileType);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    public static string GetFileType(string FileName)
    {
        if (FileName.IndexOf(".gif") != -1)
        {
            return "Image";
        }
        if (FileName.IndexOf(".jpg") != -1)
        {
            return "Image";
        }
        if (FileName.IndexOf(".doc") != -1)
        {
            return "Word Document";
        }
        if (FileName.IndexOf(".pdf") != -1)
        {
            return "PDF";
        }
        if (FileName.IndexOf(".xls") != -1)
        {
            return "Excel Spreadsheet";
        }
        if (FileName.IndexOf(".txt") != -1)
        {
            return "Text File";
        }
        if (FileName.IndexOf(".rar") != -1)
        {
            return "Rar File";
        }
        if (FileName.IndexOf(".zip") != -1)
        {
            return "Zip File";
        }
        if (FileName.IndexOf(".msg") != -1)
        {
            return "Outlook File";
        }
        return "";
    }

}