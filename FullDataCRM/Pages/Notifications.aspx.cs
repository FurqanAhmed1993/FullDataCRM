using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;


public partial class Pages_Notifications : Base
{
    int? Nullint = null;
    double? Nulldouble = null;
    bool? Nullbool = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                SetFeature();
                BindDropDown();
                BindRepeater();
                BindTimeToDDL();
            }
            PagingHandler();
        }
        catch (Exception)
        {

            throw;
        }
    }
    #region PAGING
    private void PagingHandler()
    {
        PagingAndSorting.ImgNext.Click += ImgNext_Click;
        PagingAndSorting.ImgPrevious.Click += ImgPrevious_Click;
        PagingAndSorting.DdlPage.SelectedIndexChanged += DdlPage_SelectedIndexChanged;
        PagingAndSorting.DdlPageSize.SelectedIndexChanged += DdlPageSize_SelectedIndexChanged;
    }

    void DdlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindRepeater();
    }
    void DdlPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindRepeater();
    }
    void ImgNext_Click(object sender, ImageClickEventArgs e)
    {
        BindRepeater();
    }
    void ImgPrevious_Click(object sender, ImageClickEventArgs e)
    {
        BindRepeater();
    }
    #endregion
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindRepeater();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ResetControl();
        BindRepeater();
    }

    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        ResetModalControls();
        OpenPopup();
    }

    protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                ImageButton lbEdit = (ImageButton)e.Item.FindControl("lbEdit");
                ImageButton lbDelete = (ImageButton)e.Item.FindControl("lbDelete");
                Label lbIslogin = (Label)e.Item.FindControl("txtLoginStatus");
                if (IsEdit.Value == "1")
                {
                    //lbEdit.Visible = true;
                }
                if (IsDelete.Value == "1")
                {
                    // lbDelete.Visible = true;
                }

            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void lbEdit_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void lbDelete_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {

            if (System.TimeSpan.Parse(ddlTimeFrom.SelectedValue) >= System.TimeSpan.Parse(ddlTimeTo.SelectedValue))
            {
                lblTimeError.Text = "To Time Should be Greater than From Time";
                return;
            }

            DataTable dt = new BAL_Notifications().Notification_Crud((int)OperationTypes.Insert, 1, 100, UserId,
                UserIP, Nullint, txtTitle.Text, Convert.ToInt32(ddlNotificationType.SelectedValue),
                txtNotificationMessage.Text, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"), Convert.ToDateTime(txtNotifyDate.Text));

            DateTime start = Convert.ToDateTime(txtNotifyDate.Text+" "+ddlTimeFrom.SelectedValue);
            DateTime end = Convert.ToDateTime(txtNotifyDate.Text + " " + ddlTimeTo.SelectedValue);

            int NotificationId = Convert.ToInt32(dt.Rows[0]["LastNotificationId"].ToString());
            DataTable dtEvent = new BAL_Event().Event_Crud((int)OperationTypes.Insert
                                           , 1, 50, null, NotificationId, start, end, txtTitle.Text, txtNotificationMessage.Text, true, UserId, UserIP);


            ClosePopup();
            Success("Successfully Added");
            BindRepeater();
        }
        catch (Exception ex)
        {
            Error("Something went wrong");
            throw;
        }
    }

    public void BindDropDown()
    {
        try
        {
            DataTable dt_Role = new BAL_Notifications().Notification_Crud((int)OperationTypes.DropDownValues);
            CommonObjects.BindDropDown(ddlNotificationType, dt_Role, "NotificationTypeName", "NotificationTypeId", true, false);
            CommonObjects.BindDropDown(ddlNotificationTypeSearch, dt_Role, "NotificationTypeName", "NotificationTypeId", true, false);


        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/Setup/User.aspx", "BindDropDown", ex.ToString());
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
            string Title = txtTitleSearch.Text.Trim();
            int? NotificationTypeId = (ddlNotificationTypeSearch.SelectedValue == "" || ddlNotificationTypeSearch.SelectedValue == "0") ? 0 : Convert.ToInt32(ddlNotificationTypeSearch.SelectedValue);

            DateTime NotifyDateFrom = Convert.ToDateTime("1900/01/01");
            if (txtNotifyDateSearch.Text != "")
            {
                NotifyDateFrom = Convert.ToDateTime(txtNotifyDateSearch.Text);
            }

            DateTime NotifyDateTo = Convert.ToDateTime("1900/01/01");
            if (txtNotifyDateTo.Text != "")
            {
                NotifyDateTo = Convert.ToDateTime(txtNotifyDateTo.Text);
            }


            DataTable dt = new BAL_Notifications().Notification_Crud((int)OperationTypes.Select, pageNumber, pageSize, UserId, null, Nullint, Title, NotificationTypeId, null, null, null, NotifyDateFrom, NotifyDateTo);
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
            Logger.WriteErrorLog("/Pages/Setup/User.aspx.aspx", "BindRepeater", ex.Message);
        }
    }

    private void SetFeature()
    {
        try
        {
            Btn_Add.Visible = false;
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
                        Btn_Add.Visible = true;
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

    public void ClosePopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopup()", "ClosePopup();", true);
    }
    public void OpenPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "OpenPopup()", "OpenPopup();", true);
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

    private void ResetControl()
    {

        txtTitleSearch.Text = "";
        ddlNotificationTypeSearch.SelectedValue = "0";
        txtNotifyDateSearch.Text = "";
        txtNotifyDateTo.Text = "";
        ResetModalControls();
    }
    private void ResetModalControls()
    {
        txtTitle.Text = "";
        txtNotificationMessage.Text = "";
        ddlNotificationType.SelectedValue = "0";
        txtNotifyDate.Text = "";
        lblTimeError.Text = "";

        ddlTimeFrom.SelectedValue = "0";
        ddlTimeTo.SelectedValue = "0";
        hfId.Value = "0";
    }

    public void BindTimeToDDL()
    {
        List<string> time24hr = new List<string>();
        DateTime myDate = DateTime.ParseExact("2009-05-08 00:00", "yyyy-MM-dd HH:mm", System.Globalization.CultureInfo.InvariantCulture);


        int min = 0;
        for (int i = 0; i <= 48; i++)
        {

            string strtime = FormatearHoraA24(myDate.AddMinutes(min));
            time24hr.Add(strtime);
            min = min + 30;
        }
        ddlTimeFrom.DataSource = time24hr.ToList();
        ddlTimeFrom.DataBind();

        ddlTimeTo.DataSource = time24hr.ToList();
        ddlTimeTo.DataBind();

        ddlTimeFrom.Items.Insert(0, new ListItem("-- Select From Time --", "0"));
        ddlTimeTo.Items.Insert(0, new ListItem("-- Select To Time --", "0"));
    }

    public static string FormatearHoraA24(DateTime fechaHora)
    {
        return fechaHora.ToString("HH:mm");
    }
}