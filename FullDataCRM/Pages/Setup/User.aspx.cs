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

public partial class Pages_Setup_User : Base
{
    int? Nullint = null;
    double? Nulldouble = null;
    bool? Nullbool = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetFeature();
            BindDropDown();
            BindRepeater();
        }
        PagingHandler();
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

    public void BindDropDown()
    {
        try
        {
           DataTable dt_Role = new BAL_Role().usp_GetUserRole(Nullint, null, true, RoleId);
            CommonObjects.BindDropDown(ddlRole, dt_Role, "RoleName", "RoleId", true, false);
            CommonObjects.BindDropDown(ddlRoleSearch, dt_Role, "RoleName", "RoleId", true, false);
           
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
            string User = txtUserSearch.Text.Trim();
           int _RoleId = (ddlRoleSearch.SelectedValue == "" || ddlRoleSearch.SelectedValue == "0") ? 0 : Convert.ToInt32(ddlRoleSearch.SelectedValue);
            DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_Select,pageNumber,pageSize, 0, _RoleId, txtUserSearch.Text);
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
        txtEmailAddress.Enabled = true;
        OpenPopup();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            int RoleID = (ddlRole.SelectedValue == "" || ddlRole.SelectedValue == "0") ? 0 : Convert.ToInt32(ddlRole.SelectedValue);
           
            string Password = CommonObjects.GetHash(GenericConstants.DefaultPassword);

            string msg = new BAL_User().ValidateControls(RoleID);
            if (msg == "")
            {
                int Id = hfId.Value == string.Empty ? 0 : Convert.ToInt32(hfId.Value);
                if (Id == 0)
                {
                    DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_Insert
                        , 1, 50, Id, RoleID, txtUserName.Text, txtEmailAddress.Text, Password, false,
                        chkIsActive.Checked, UserId, UserIP);


                    if (dt != null && dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["HasError"].ToString() == "1")
                        {
                            Error(dt.Rows[0]["Message"].ToString());
                        }
                        else if (dt.Rows[0]["HasError"].ToString() == "0")
                        {
                            Success(dt.Rows[0]["Message"].ToString());
                            ResetModalControls();
                            BindRepeater();
                            ClosePopup();
                        }
                    }

                }
                else
                {
                    DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_Update
                       , 1, 50, Id, RoleID, txtUserName.Text, txtEmailAddress.Text, Password, false,
                       true, UserId, UserIP);


                    if (dt != null && dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["HasError"].ToString() == "1")
                        {
                            Error(dt.Rows[0]["Message"].ToString());
                        }
                        else if (dt.Rows[0]["HasError"].ToString() == "0")
                        {
                            Success(dt.Rows[0]["Message"].ToString());
                            ResetModalControls();
                            BindRepeater();
                            ClosePopup();
                        }
                    }
                }
            }
            else
            {
                Error(msg);
            }
        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/Setup/User.aspx", "btnAdd_Click", ex.Message);
        }
    }
    protected void lbEdit_Click(object sender, EventArgs e)
    {
        try
        {
            ResetModalControls();
            ImageButton lbEdit = (ImageButton)sender;
            RepeaterItem rptItem = (RepeaterItem)lbEdit.NamingContainer;
            int hfUserId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfUserId")).Value);
            if (hfUserId > 0)
            {
                string hfName = ((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfName")).Value;
                string hfRoleId = ((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfRoleId")).Value;
                string hfIsActive = ((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfIsActive")).Value;
                string hfEmailAddress = ((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfEmailAddress")).Value;

               
                chkIsActive.Checked = Convert.ToBoolean(hfIsActive == "" ? "0" : hfIsActive);
                ddlRole.SelectedValue = Convert.ToString(hfRoleId == "" ? "0" : hfRoleId);
                txtEmailAddress.Text = hfEmailAddress;
                txtUserName.Text = hfName;



                hfId.Value = hfUserId.ToString();
                txtEmailAddress.Enabled = false;
                OpenPopup();

            }
        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/Setup/User.aspx", "lbEdit_Click", ex.Message);
        }
    }
    protected void lbDelete_Click(object sender, EventArgs e)
    {
        try
        {
            hfmodalDeleteId.Value = "0";
            ImageButton lbEdit = (ImageButton)sender;
            RepeaterItem rptItem = (RepeaterItem)lbEdit.NamingContainer;
            int hfUserId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfUserId")).Value);
            if (hfUserId > 0)
            {
                hfmodalDeleteId.Value = hfUserId.ToString();
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModalDeleteModal()", "OpenModalDeleteModal();", true);
            }
        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/Setup/User.aspx", "lbDelete_Click", ex.Message);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            int Id = Convert.ToInt32(hfmodalDeleteId.Value == "" ? "0" : hfmodalDeleteId.Value);
            if (Id > 0)
            {
                DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_Delete, 
                     1,50,Id);
                if (dt != null && dt.Rows.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "CloseDeleteModal()", "CloseDeleteModal();", true);
                    if (dt.Rows[0]["HasError"].ToString() == "1")
                    {
                        Error(dt.Rows[0]["Message"].ToString());
                    }
                    else if (dt.Rows[0]["HasError"].ToString() == "0")
                    {
                        Success(dt.Rows[0]["Message"].ToString());
                        BindRepeater();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog("/Pages/Setup/User.aspx", "btnDelete_Click", ex.Message);
        }
    }
    private void ResetControl()
    {
       
        txtUserSearch.Text = "";
    
        ddlRoleSearch.SelectedIndex = 0;
        ResetModalControls();
    }
    private void ResetModalControls()
    {
        
       
        ddlRole.SelectedValue = "0";
       
        
        //chk_IsActive.Checked = true;
        hfId.Value = "0";
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
                    lbEdit.Visible = true;
                }
                if (IsDelete.Value == "1")
                {
                    lbDelete.Visible = true;
                }
                if(lbIslogin.Text=="Online")
                {
                    lbIslogin.BackColor = Color.Green;

                }
                else
                {
                    lbIslogin.BackColor =Color.Red;
                }
            }
        }
        catch (Exception ex)
        {
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

    
}