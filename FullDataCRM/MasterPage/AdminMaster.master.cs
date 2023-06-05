using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;

public partial class MasterPage_AdminMaster : System.Web.UI.MasterPage
{
    Base objbase = new Base();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblYear.Text = Convert.ToString(DateTime.Now.Year);
            lblLoginStatus.Text = new Base().FullName;
            GetUserLastRecord();


        }
    }
    protected void lbLogout_Click(object sender, EventArgs e)
    {
       
        // remove session before sending to login page.
        DataTable dts = new BAL_Login().Get_UserByLoginId(Setup_MasterDetail.OperationType_Update, new Base().LoginId, false);

        Session.Abandon();
        new Base().ExpireCookie();
        Response.Redirect("/Login.aspx", true);
    }

    protected void btnTimer_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnTimer.Text == "Stop Timer")
            {
                DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_Update, 0, DateTime.Now, DateTime.Now, true, new Base().UserId, new Base().UserIP, 1, 50);
                if (dt != null && dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["HasError"].ToString() == "1")
                    {

                    }
                    else if (dt.Rows[0]["HasError"].ToString() == "0")
                    {
                        btnTimer.Text = "Start Timer";
                        btnTimer.BackColor = System.Drawing.Color.Green;
                        lblStartTime.Text = "";
                        Response.Redirect("Home.aspx");
                    }
                }
            }

            else if (btnTimer.Text == "Start Timer")
            {
                DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_Insert, 0, DateTime.Now, null, true, new Base().UserId, new Base().UserIP, 1, 50);
                if (dt != null && dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["HasError"].ToString() == "1")
                    {
                       
                    }
                    else if (dt.Rows[0]["HasError"].ToString() == "0")
                    {
                        btnTimer.Text = "Stop Timer";
                        btnTimer.BackColor = System.Drawing.Color.Red;
                        lblStartTime.Text = "Started at : " + DateTime.Now.ToString("MM/dd/yyyy hh:mm tt");
                        Response.Redirect("Home.aspx");
                    }
                }
            }
        }

        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/SetTimer.aspx", "btnTimer_Click", ex.Message);
        }

    }

    private void GetUserLastRecord()
    {
        DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_SelectLastRecord, 0, DateTime.Now, DateTime.Now, true, new Base().UserId, new Base().UserIP, 1, 50);
        if (dt != null && dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["StartTimer"].ToString() != "" && dt.Rows[0]["EndTimer"].ToString() == "")
            {
                btnTimer.Text = "Stop Timer";
                btnTimer.BackColor = System.Drawing.Color.Red;
                DateTime StartDate = Convert.ToDateTime(dt.Rows[0]["StartTimer"].ToString());
                lblStartTime.Text = "Started at : " + StartDate.ToString("MM/dd/yyyy hh:mm tt");
            }
            else
            {
                btnTimer.Text = "Start Timer";
                btnTimer.BackColor = System.Drawing.Color.Green;
                lblStartTime.Text = "";
            }
        }


    }

}
