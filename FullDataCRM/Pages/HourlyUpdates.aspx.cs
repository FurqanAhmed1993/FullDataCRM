using BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Utilities;

public partial class Pages_HourlyUpdates : Base
{
    int? Nullint = null;
    double? Nulldouble = null;
    bool? Nullbool = null;
    DateTime? NullDateTime = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
        }
    }
    private void BindRepeater(int UserId_)
    {
      
    }
    protected void DLIST_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindRepeater(0);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
       
    }
    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        ResetModalControls();
        OpenPopup();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        
    }
    protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
       
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
    private void BindDropDown()
    {

        
    }
    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
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
    private void ResetModalControls()
    {
        txtDescription.Text = "";
       // DataSet dtTimeInterval = new BAL_HourlyUpdates().HourlyUpdates_Crud(19, UserRole.SuperAdmin, 0, "", UserId, NullDateTime, NullDateTime, UserId, UserIP);
        //CommonObjects.BindDropDown(ddlTimeInterval, dtTimeInterval, "Value", "Id", dtTimeInterval.Tables[0].Rows.Count == 1 ? false : true, false);

    }
    public void ClosePopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopup()", "ClosePopup();", true);
    }
    public void OpenPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "OpenPopup()", "OpenPopup();", true);
    }
    public void CloseBreakPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopupBreak()", "ClosePopupBreak();", true);
    }
    public void OpenBreakPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "OpenPopupBreak()", "OpenPopupBreak();", true);
    }
    protected void btnAddBreak_Click(object sender, EventArgs e)
    {
        
    }

    protected void btnSaveBreak_Click(object sender, EventArgs e)
    {
        
    }

    protected void lbEnd_Click(object sender, EventArgs e)
    {
       
    }
}