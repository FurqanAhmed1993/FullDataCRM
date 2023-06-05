using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Chat : Base
{
    public string UserCode = "";
    public string UserName = "";
    public string UserStatus = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        UserCode = UserId.ToString();
        UserName = FullName;
    }
}