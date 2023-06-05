using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class Pages_Home : Base
{
    string Page = "/Pages/Home.aspx";
    int? Nullint = null;
    bool? Nullbool = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

           // Timer1.Enabled = true;

        }
    }
    //protected void Timer1_Tick(object sender, EventArgs e)
    //{
       
    //}
}