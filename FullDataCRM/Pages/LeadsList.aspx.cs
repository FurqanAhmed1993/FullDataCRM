using BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilities;

public partial class Pages_LeadsList : Base
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindRepeater();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ResetControl();
        BindRepeater();
    }

    protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                ImageButton lbEdit = (ImageButton)e.Item.FindControl("lbEdit");
                ImageButton lbDelete = (ImageButton)e.Item.FindControl("lbDelete");
                ImageButton lbView = (ImageButton)e.Item.FindControl("lbView");
                ImageButton lbUploadRecording = (ImageButton)e.Item.FindControl("lbUploadRecording");
                ImageButton lbUploadSnapShot = (ImageButton)e.Item.FindControl("lbUploadSnapShot");
                if (IsEdit.Value == "1")
                {
                    lbEdit.Visible = true;
                }
                if (IsDelete.Value == "1")
                {
                    lbDelete.Visible = true;
                }
                if (IsView.Value == "1")
                {
                    //lbView.Visible = true;
                }
                if(IsUploadRecording.Value=="1")
                {
                    lbUploadRecording.Visible = true;
                }
                if (IsUploadSnapShot.Value == "1")
                {
                    lbUploadSnapShot.Visible = true;
                }

            }
        }
        catch (Exception ex)
        {
            Error("Error Occured during Item data bound");
        }
    }

    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Pages/LeadsDetail.aspx",false);
    }

    protected void lbEdit_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton lbEdit = (ImageButton)sender;
            Rederiction(lbEdit, 1);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void lbDelete_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton lbDelete = (ImageButton)sender;
            RepeaterItem rptItem = (RepeaterItem)lbDelete.NamingContainer;
            int hfLeadId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfLeadId")).Value);
            if (hfLeadId > 0)
            {
                DataSet ds = new BAL_Lead().Lead_Crud((int)OperationTypes.Delete, UserId, Nullint,Nullint,hfLeadId,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,UserIP);

                if (ds != null)
                {
                    if (ds.Tables[0].Rows[0]["HasError"].ToString() == "0")
                    {
                        Success(ds.Tables[0].Rows[0]["Message"].ToString());
                        BindRepeater();
                    }
                    else if (ds.Tables[0].Rows[0]["HasError"].ToString() == "1")
                    {
                        Error(ds.Tables[0].Rows[0]["Message"].ToString());
                    }
                }

            }

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void lbView_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton lbView = (ImageButton)sender;
            Rederiction(lbView, 0);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region Methods

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
                    else if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.UploadRecording)
                    {
                        IsUploadRecording.Value = "1";
                    }
                    else if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.UploadSnapShot)
                    {
                        IsUploadSnapShot.Value = "1";
                    }
                }
            }
        }
        catch (Exception ex) {
            Error("Error Occured during Setting feature");
        }
    }

    public void BindDropDown()
    {
        try
        {
            DataSet ds = new BAL_Lead().Lead_Crud((int)OperationTypes.DropDownValues);
            CommonObjects.BindDropDown(ddlStatus, ds.Tables[0], "LeadStatusName", "LeadStatusId", true, false);

        }
        catch (Exception ex)
        {
            Error("Error Occured during Binding Drop down");
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
            string FirstName =string.IsNullOrEmpty(txtFirstName.Text.Trim())?null:txtFirstName.Text;
            string LastName = string.IsNullOrEmpty(txtLastName.Text.Trim()) ? null : txtLastName.Text;
            string Address = string.IsNullOrEmpty(txtAddress.Text.Trim()) ? null : txtAddress.Text;
            string PhoneNumber = string.IsNullOrEmpty(txtPhone.Text.Trim()) ? null : txtPhone.Text;
            int? StatusId = ddlStatus.SelectedValue=="0" ? Nullint : Convert.ToInt32(ddlStatus.SelectedValue);

            DataSet ds = new BAL_Lead().Lead_Crud((int)OperationTypes.Select,UserId, pageSize, pageNumber,Nullint,FirstName,null,LastName,Address,StatusId, PhoneNumber);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                var li = ds.Tables[0].Select().Skip(skip).Take(pageSize).CopyToDataTable();
                rpt.DataSource = li;
                rpt.DataBind();
                PagingAndSorting.setPagingOptions(ds.Tables[0].Rows.Count);
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
            Error("Error Occured during Binding Data");
            Logger.WriteErrorLog("/Pages/Setup/User.aspx.aspx", "BindRepeater", ex.Message);
        }
    }

    private void ResetControl()
    {
        txtFirstName.Text = string.Empty;
        txtLastName.Text = string.Empty;
        txtAddress.Text = string.Empty;
        txtPhone.Text = string.Empty;
        ddlStatus.SelectedValue = "0";
    }
    private void Rederiction(ImageButton lbBtn, int IsEdit)
    {
        try
        {
            RepeaterItem rptItem = (RepeaterItem)lbBtn.NamingContainer;
            int hfLeadId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfLeadId")).Value);
            if (hfLeadId > 0)
            {
                string Encrypted = "IsEdit=" + IsEdit + "&&LeadId=" + hfLeadId;
                Encrypted = CommonObjects.Encrypt_New(Encrypted);
                Response.Redirect("/Pages/LeadsDetail.aspx?" + Encrypted);
            }
        }
        catch (Exception ex)
        {
            Error("Error Occured during redirection");
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
    public void OpenPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "OpenPopup()", "OpenPopup();", true);
    }
    public void ClosePopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopup()", "ClosePopup();", true);
    }
    public void OpenSnapShotPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "OpenSnapShotPopup()", "OpenSnapShotPopup();", true);
    }
    #endregion

    protected void lbUploadRecording_Click(object sender, ImageClickEventArgs e)
    {

        ImageButton lbUploadRecording = (ImageButton)sender;
        RepeaterItem rptItem = (RepeaterItem)lbUploadRecording.NamingContainer;
        string hfRecordingFileName = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfRecordingFileName")).Value);
        int? hfLeadId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfLeadId")).Value);
        hfId.Value = hfLeadId==null?"0": hfLeadId.ToString();
        if (!string.IsNullOrEmpty(hfRecordingFileName))
        {
           
            divResumeDownload.Visible = true;
            hfRecordingFileNameModal.Value = hfRecordingFileName;
            downloadRecordingFile.HRef = GenericConstants.Uploads + "/" + hfRecordingFileName;
        }
        else
        {
            divResumeDownload.Visible = false;
        }
        OpenPopup();
    }

    protected void btnSaveRecording_Click(object sender, EventArgs e)
    {
        try
        {
            int LeadId = Convert.ToInt32(hfId.Value);
            string RecordingFileName = null;
            string RecordingFileOrignalName = null;
            if (fuRecording.HasFile)
            {
                if (System.IO.Path.GetExtension(fuRecording.PostedFile.FileName) == ".mp3" || System.IO.Path.GetExtension(fuRecording.PostedFile.FileName) == ".mp4")
                {
                    if (!Directory.Exists(Server.MapPath("~/Uploads")))
                    {
                        Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Uploads"));
                    }
                    RecordingFileOrignalName = fuRecording.FileName;
                    RecordingFileName = DateTime.Now.ToString("yyyyMMddhhmmss") + "-" + LeadId + "-" + fuRecording.PostedFile.FileName.Trim();
                    string FilePath = Server.MapPath("~/Uploads/") + RecordingFileName;
                    fuRecording.SaveAs(Server.MapPath("~/Uploads/") + RecordingFileName);

                    DataSet ds = new BAL_Lead().FileRecording_Upload((int)OperationTypes.SaveRecording, LeadId,
                  RecordingFileName, RecordingFileOrignalName, FilePath, UserId, UserIP);

                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows[0]["HasError"].ToString() == "0")
                        {
                            Success(ds.Tables[0].Rows[0]["Message"].ToString());
                            ClosePopup();
                        }
                        else
                        {
                            Error(ds.Tables[0].Rows[0]["Message"].ToString());
                        }
                    }
                    else
                    {
                        Error("Error Occured during saving");
                    }
                }
            }

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void imgDeleteRecordingFile_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            int LeadId = Convert.ToInt32(hfId.Value);

            DataSet ds = new BAL_Lead().FileRecording_Upload((int)OperationTypes.DeleteRecording
                , LeadId, null, null, null, UserId, UserIP);

            if (ds != null || ds.Tables.Count>0)
            {
                if (ds.Tables[0].Rows[0]["HasError"].ToString() == "0")
                {
                    Success(ds.Tables[0].Rows[0]["Message"].ToString());
                    ClosePopup();
                }
                else
                {
                    Error(ds.Tables[0].Rows[0]["Message"].ToString());
                }
            }
            else
            {
                Error("Error Occured during saving");
            }


        }
        catch (Exception)
        {

            throw;
        }
    }


    protected void lbUploadSnapShot_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton lbUploadSnapShot = (ImageButton)sender;
        RepeaterItem rptItem = (RepeaterItem)lbUploadSnapShot.NamingContainer;
        string hfSnapShotFileName = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfSnapShotFileName")).Value);
        int? hfLeadId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfLeadId")).Value);
        hfSnapShotLeadId.Value = hfLeadId == null ? "0" : hfLeadId.ToString();
        if (!string.IsNullOrEmpty(hfSnapShotFileName))
        {

            divSnapshotDownload.Visible = true;
            hfSnapShotFileNameModal.Value = hfSnapShotFileName;
            downloadSnapShotFile.HRef = GenericConstants.Uploads + "/" + hfSnapShotFileName;
        }
        else
        {
            divSnapshotDownload.Visible = false;
        }
        OpenSnapShotPopup();
    }
    protected void btnSaveSnapShot_Click(object sender, EventArgs e)
    {
        try
        {
            int LeadId = Convert.ToInt32(hfSnapShotLeadId.Value);
            string SnapShotFileName = null;
            string SnapShotFileOrignalName = null;
            if (fuSnapShot.HasFile)
            {
                if (System.IO.Path.GetExtension(fuSnapShot.PostedFile.FileName) == ".jpg" || System.IO.Path.GetExtension(fuSnapShot.PostedFile.FileName) == ".jpeg" || System.IO.Path.GetExtension(fuSnapShot.PostedFile.FileName) == ".png")
                {
                    if (!Directory.Exists(Server.MapPath("~/Uploads")))
                    {
                        Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Uploads"));
                    }
                    SnapShotFileOrignalName = fuSnapShot.FileName;
                    SnapShotFileName = DateTime.Now.ToString("yyyyMMddhhmmss") + "-" + LeadId + "-" + fuSnapShot.PostedFile.FileName.Trim();
                    string FilePath = Server.MapPath("~/Uploads/") + SnapShotFileName;
                    fuSnapShot.SaveAs(Server.MapPath("~/Uploads/") + SnapShotFileName);

                    DataSet ds = new BAL_Lead().FileSnapshot_Upload((int)OperationTypes.SaveSnapShot, LeadId,
                  SnapShotFileName, SnapShotFileOrignalName, FilePath, UserId, UserIP);

                    if (ds != null)
                    {
                        if (ds.Tables.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["HasError"].ToString() == "0")
                            {
                                Success(ds.Tables[0].Rows[0]["Message"].ToString());
                                ClosePopup();
                                BindRepeater();
                            }
                            else
                            {
                                Error(ds.Tables[0].Rows[0]["Message"].ToString());
                            }
                        }
                        else
                        {
                            Error("Error Occured in Uploading Snap shot");
                        }
                    }
                    else
                    {
                        Error("Error Occured in Uploading Snap shot");
                    }
                }
            }

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void imgDeleteSnapShotFile_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            int LeadId = Convert.ToInt32(hfSnapShotLeadId.Value);

            DataSet ds = new BAL_Lead().FileSnapshot_Upload((int)OperationTypes.DeleteSnapShot
                , LeadId, null, null, null, UserId, UserIP);

            if (ds != null )
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["HasError"].ToString() == "0")
                    {
                        Success(ds.Tables[0].Rows[0]["Message"].ToString());
                        ClosePopup();
                        BindRepeater();
                    }
                    else
                    {
                        Error(ds.Tables[0].Rows[0]["Message"].ToString());
                    }
                }
                else
                {
                    Error("Error Occured in Deleting Snap shot");
                }
            }
            else
            {
                Error("Error Occured during saving");
            }


        }
        catch (Exception)
        {

            throw;
        }
    }

    
}