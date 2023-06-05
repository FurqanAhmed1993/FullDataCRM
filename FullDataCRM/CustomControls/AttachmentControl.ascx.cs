using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilities;
using BAL;
using System.Web.UI.HtmlControls;

public partial class CustomControls_AttachmentControl : System.Web.UI.UserControl
{
    int? Nullint = null;
    double? Nulldouble = null;
    bool? Nullbool = null;
    public int TableTypeId { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDropDown();
        }
    }
    public void BindDropDown()
    {
        //DataTable dtDocType = new BAL_Setup_MasterDetail().usp_Get_Setup_MasterDetail(Setup_Master.DocType, Nullbool, Nullint, "", Nullint);
        //CommonObjects.BindDropDown(ddlDocType, dtDocType, "SetupDetailName", "SetupDetailId", true);
    }
    protected void lbDelete_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton lbDelete = (ImageButton)sender;
            RepeaterItem rptItem = (RepeaterItem)lbDelete.NamingContainer;
            DataTable dt = Attachments;
            dt.Rows.RemoveAt(rptItem.ItemIndex);
            dt.AcceptChanges();
            Attachments = dt;
            BindAttachmentRepaeter();
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    protected void Btn_Add_Attachments_Click(object sender, EventArgs e)
    {
        try
        {
            if (fuAttachments.HasFile)
            {
                if (Attachments == null)
                {
                    CreateAttachmentDatatable();
                }
                DataTable dtAttachments = Attachments;
                string tempPath = null, FileName = null, FileOrignalName = null;
                FileOrignalName = fuAttachments.FileName;
                FileName = fuAttachments.FileName;

                if (!Directory.Exists(Server.MapPath("~/Uploads")))
                {
                    Directory.CreateDirectory(Server.MapPath("~/Uploads"));
                }
                FileName = Guid.NewGuid().ToString() + "_" + FileName;

                tempPath = Server.MapPath("~/Uploads/") + FileName;
                fuAttachments.SaveAs(tempPath);


                DataRow dr = dtAttachments.NewRow();
                int RowNum = 1;
                if (dtAttachments != null && dtAttachments.Rows.Count > 0)
                {
                    RowNum = Convert.ToInt32(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["RowNum"].ToString()) + 1;
                }

                dr["RowNum"] = RowNum;
                dr["TableTypeId"] = TableTypeId;
                dr["DocTypeId"] = ddlDocType.SelectedItem.Value;
                dr["DocType"] = ddlDocType.SelectedItem.Text;
                dr["FileName"] = FileOrignalName;
                dr["FileName_Random"] = FileName;
                dr["FilePath"] = tempPath;
                dr["Description"] = txtFileDescription.Text;
                dtAttachments.Rows.Add(dr);
                Attachments = dtAttachments;
                BindAttachmentRepaeter();
                ResetControl();
            }
            else
            {
                Error("Please Attach a File");
            }
        }
        catch (Exception ex)
        {

            throw;
        }

    }
    public void BindAttachmentRepaeter()
    {
        rptAttachments.DataSource = Attachments;
        rptAttachments.DataBind();
    }
    public void CreateAttachmentDatatable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("RowNum", typeof(int));
        dt.Columns.Add("TableTypeId", typeof(int));
        dt.Columns.Add("DocTypeId", typeof(int));
        dt.Columns.Add("DocType", typeof(string));
        dt.Columns.Add("FileName", typeof(string));
        dt.Columns.Add("FileName_Random", typeof(string));
        dt.Columns.Add("FilePath", typeof(string));
        dt.Columns.Add("Description", typeof(string));

        Attachments = dt;
    }
    private void ResetControl()
    {
        txtFileDescription.Text = "";
        ddlDocType.SelectedIndex = 0;
        fuAttachments = null;
    }
    public DataTable Attachments
    {
        get
        {
            return ViewState["Attachments"] != null ? (DataTable)ViewState["Attachments"] : null;
        }
        set
        {
            ViewState["Attachments"] = value;
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
    public void DisableControl(bool Enabled_Control = true)
    {
        Div_Add.Visible = Enabled_Control;
        Btn_Add_Attachments.Visible = Enabled_Control;

        if (rptAttachments.Items.Count > 0)
        {
            for (int i = 0; i < rptAttachments.Items.Count; i++)
            {
                ImageButton lbDelete = (ImageButton)rptAttachments.Items[i].FindControl("lbDelete");
                if (Enabled_Control == true)
                {
                    HtmlInputHidden hfTableTypeId = (HtmlInputHidden)rptAttachments.Items[i].FindControl("hfTableTypeId");
                    if (Convert.ToInt32(hfTableTypeId.Value) == TableTypeId)
                    {
                        lbDelete.Visible = true;
                    }
                    else
                    {
                        lbDelete.Visible = false;
                    }
                }
                else
                {
                    lbDelete.Visible = false;
                }
            }
        }
    }

    protected void rptAttachments_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                ImageButton lbDelete = (ImageButton)e.Item.FindControl("lbDelete");
                HtmlInputHidden hfTableTypeId = (HtmlInputHidden)e.Item.FindControl("hfTableTypeId");
                if (Convert.ToInt32(hfTableTypeId.Value) == TableTypeId)
                {
                    lbDelete.Visible = true;
                }
                else
                {
                    lbDelete.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
}