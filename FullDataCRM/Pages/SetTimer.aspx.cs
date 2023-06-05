using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;
using System.Drawing;


public partial class Pages_SetTimer : Base
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetFeature();
            BindRepeater();
            GetUserLastRecord();
        }
    }

    protected void btnTimer_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnTimer.Text == "Stop Timer")
            {
                DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_Update, 0, DateTime.Now, DateTime.Now, true, UserId, UserIP, 1, 50);
                if (dt != null && dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["HasError"].ToString() == "1")
                    {
                        Error(dt.Rows[0]["Message"].ToString());
                    }
                    else if (dt.Rows[0]["HasError"].ToString() == "0")
                    {
                        Success(dt.Rows[0]["Message"].ToString());
                        BindRepeater();
                        btnTimer.Text = "Start Timer";
                        btnTimer.BackColor = System.Drawing.Color.Green;
                        lblStartTime.Text = "";
                        Response.Redirect("SetTimer.aspx");
                    }
                }
            }

            else if (btnTimer.Text == "Start Timer")
            {
                DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_Insert, 0, DateTime.Now, null, true, UserId, UserIP, 1, 50);
                if (dt != null && dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["HasError"].ToString() == "1")
                    {
                        Error(dt.Rows[0]["Message"].ToString());
                    }
                    else if (dt.Rows[0]["HasError"].ToString() == "0")
                    {
                        Success(dt.Rows[0]["Message"].ToString());
                        BindRepeater();
                        btnTimer.Text = "Stop Timer";
                        btnTimer.BackColor = System.Drawing.Color.Red;
                        lblStartTime.Text = "Started at :" + DateTime.Now.ToString("MM/dd/yyyy hh:mm tt");
                        Response.Redirect("SetTimer.aspx");
                    }
                }
            }
        }

        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/SetTimer.aspx", "btnTimer_Click", ex.Message);
        }

    }

    public void BindRepeater()
    {
        try
        {
            int pageSize = 100;
            int pageNumber = 1;
            if (PagingAndSorting.DdlPageSize.SelectedValue.toInt() > 0)
            {
                pageSize = PagingAndSorting.DdlPageSize.SelectedValue.toInt();
            }
            if (PagingAndSorting.DdlPage.Items.Count > 0)
            {
                pageNumber = PagingAndSorting.DdlPage.SelectedValue.toInt();
            }

            int skip = pageNumber * pageSize - pageSize;

            DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_Select, 0, DateTime.Now, null, true, UserId, UserIP, 1, 50);

            if (dt != null && dt.Rows.Count > 0)
            {
                var li = dt.Select().Skip(skip).Take(pageSize).CopyToDataTable();
                rpt.DataSource = li;
                rpt.DataBind();
                PagingAndSorting.setPagingOptions(dt.Rows.Count);
            }
            else
            {
                rpt.DataSource = null;
                rpt.DataBind();
                PagingAndSorting.setPagingOptions(0);
            }
        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/Setup/Bank.aspx", "BindRepeater", ex.Message);
        }
    }


    public void Success(string message)
    {
        message = "AlertBox('Success!','" + message + "','success');";
        ScriptManager.RegisterStartupScript(this, GetType(), message, message, true);
    }
    public void Error(string message)
    {
        message = "AlertBox('Error!','" + message + "','error');";
        ScriptManager.RegisterStartupScript(this, GetType(), message, message, true);
    }

    private void GetUserLastRecord()
    {
        DataTable dt = new BAL_Timer().TimerDetails_Crud(Setup_MasterDetail.OperationType_SelectLastRecord, 0, DateTime.Now, DateTime.Now, true, UserId, UserIP, 1, 50);
        if (dt != null && dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["StartTimer"].ToString() != "" && dt.Rows[0]["EndTimer"].ToString() == "")
            {
                btnTimer.Text = "Stop Timer";
                btnTimer.BackColor = System.Drawing.Color.Red;
                DateTime StartDate = Convert.ToDateTime(dt.Rows[0]["StartTimer"].ToString());
                lblStartTime.Text = "Started at :" + StartDate.ToString("MM/dd/yyyy hh:mm tt");
            }
            else
            {
                btnTimer.Text = "Start Timer";
                btnTimer.BackColor = System.Drawing.Color.Green;
                lblStartTime.Text = "";
            }
        }


    }
    private void SetFeature()
    {
        try
        {
            btnTimer.Visible = false;
            string url = HttpContext.Current.Request.Url.PathAndQuery;
            string[] Array = url.Split('?');
            url = Array[0];
            DataTable dt = new BAL_Setup_MenuItem().usp_CheckMenuAccess(RoleId, url);
            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.Add)
                    {
                        IsAdd.Value = "1";
                        btnTimer.Visible = true;
                    }
                    else if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.Update)
                    {
                        IsEdit.Value = "1";
                    }
                    else if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.Delete)
                    {
                        IsDelete.Value = "1";
                    }
                    else if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.View)
                    {
                        IsView.Value = "1";
                    }
                }
            }
        }
        catch (Exception ex) { }
    }
}