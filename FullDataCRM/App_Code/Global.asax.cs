﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Global
/// </summary>
public class Global : System.Web.HttpApplication
{
    protected void Application_BeginRequest(object sender, EventArgs e)
    {
        //HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
        //if (HttpContext.Current.Request.HttpMethod == "OPTIONS")
        //{
        //    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
        //    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
        //    HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
        //    HttpContext.Current.Response.End();
        //}
    }
}
