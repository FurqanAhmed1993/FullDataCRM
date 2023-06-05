using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.IO.Compression;
using Utilities;

public class Base : System.Web.UI.Page
{
    public string FullName
    {
        get { return GetCookie("FullDataCRM_fullname"); }
        set { SaveCookie("FullDataCRM_fullname", value); }
    }
    public int RoleId
    {
        get
        {
            if (string.IsNullOrEmpty(GetCookie("FullDataCRM_RoleId")))
                return 0;
            else
                return int.Parse(GetCookie("FullDataCRM_RoleId"));
        }
        set { SaveCookie("FullDataCRM_RoleId", value.ToString()); }
    }
    public int UserId
    {
        get
        {
            if (string.IsNullOrEmpty(GetCookie("FullDataCRM_UserId")))
                return 0;
            else
                return int.Parse(GetCookie("FullDataCRM_UserId"));
        }
        set { SaveCookie("FullDataCRM_UserId", value.ToString()); }
    }
    public string UserIP
    {
        get { return Context.Request.UserHostAddress + " -- " + CommonObjects.GetMAC(); }
    }
    public string LoginId
    {
        get { return GetCookie("FullDataCRM_LoginId"); }
        set { SaveCookie("FullDataCRM_LoginId", value); }
    }
    private bool ValidateError(string errorMessage)
    {
        // exclude common backend exceptions
        if (errorMessage == "File does not exist.")
            return false;
        else
            return true;
    }
    private Exception SetExceptionText()
    {
        Exception ex = HttpContext.Current.Server.GetLastError();
        if (ex != null)
        {
            if (ex.GetBaseException() != null)
            {
                ex = ex.GetBaseException();
                // lblError.Text = ex.Message;
            }
        }
        return ex;
    }
    public void SaveCookie(string strKey, string strValue)
    {
        Session[strKey] = strValue;
    }
    public string GetCookie(string strKey)
    {
        if (Session[strKey] != null)
        {
            return Session[strKey].ToString();
        }
        else
        {
            return null;
        }
    }
    public void ExpireCookie()
    {
        HttpRequest req = HttpContext.Current.Request;
        HttpResponse res = HttpContext.Current.Response;
        int count = req.Cookies.Count;
        for (int i = 0; i < count; i++)
        {
            HttpCookie cookie = new HttpCookie(req.Cookies[i].Name);
            cookie.Expires = DateTime.Now.AddDays(-1);
            res.Cookies.Add(cookie);
        }
    }
}

public static class UIExtensions
{
    public static void EnableCompression(this HttpResponse response)
    {
        response.Filter = new GZipStream(response.Filter, CompressionMode.Compress);
        response.AddHeader("Content-Encoding", "gzip");
    }
}