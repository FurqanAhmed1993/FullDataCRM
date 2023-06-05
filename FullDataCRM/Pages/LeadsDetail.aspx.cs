using BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilities;

public partial class Pages_LeadsDetail : Base
{
    int? Nullint = null;
    double? Nulldouble = null;
    decimal? Nulldecimal = null;
    bool? Nullbool = null;
    public int GetLeadId
    {
        get
        {
            if (string.IsNullOrEmpty(hfLeadId.Value))
                return 0;
            else
                return int.Parse(hfLeadId.Value);
        }
    }
    public void SetLeadId()
    {
        hfLeadId.Value = "0";
        if (!string.IsNullOrEmpty(Request.Url.Query.TrimStart('?')))
        {
            try
            {
                string EncryptedQueryString = Request.Url.Query.TrimStart('?');
                string Id = CommonObjects.DecryptById(EncryptedQueryString, "LeadId");
                if (!string.IsNullOrEmpty(Id) && Id != "0")
                {
                    hfLeadId.Value = Convert.ToString(Id);
                }
                else
                {
                    AlertBox_Error_Return("Record not found");
                }
            }
            catch (Exception ex)
            {
                AlertBox_Error_Return("Record not found");
            }
        }
    }
    public int GetIsEdit
    {
        get
        {
            if (string.IsNullOrEmpty(IsEdit.Value))
                return 0;
            else
                return int.Parse(IsEdit.Value);
        }
    }
    public void SetIsEdit()
    {
        IsEdit.Value = "0";
        if (!string.IsNullOrEmpty(Request.Url.Query.TrimStart('?')))
        {
            try
            {
                string EncryptedQueryString = Request.Url.Query.TrimStart('?');
                string Id = CommonObjects.DecryptById(EncryptedQueryString, "IsEdit");
                if (!string.IsNullOrEmpty(Id))
                {
                    IsEdit.Value = Convert.ToString(Id);
                }
                else
                {
                    AlertBox_Error_Return("Record not found");
                }
            }
            catch (Exception ex)
            {
                AlertBox_Error_Return("Record not found");
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                SetFeature();
                SetLeadId();
                SetIsEdit();
                BindDropDown();
                Disable_Controls();
                if (GetLeadId > 0)
                {
                    BindElementOnEdit();
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ((DataTable)ViewState["FinancialTable"]);
            if (dt != null)
            {
                if (dt.Columns.Contains("RowNum"))
                {
                    dt.Columns.Remove("RowNum");
                }
                if (dt.Columns.Contains("AccountName"))
                {
                    dt.Columns.Remove("AccountName");
                }
                //if (dt.Columns.Contains("BankName"))
                //{
                //    dt.Columns.Remove("BankName");
                //}
                if (dt.Columns.Contains("LeadId"))
                {
                    dt.Columns.Remove("LeadId");
                }
                //if (dt.Columns.Contains("CreatedByName"))
                //{
                //    dt.Columns.Remove("CreatedByName");
                //}
                //if (dt.Columns.Contains("ModifiedByName"))
                //{
                //    dt.Columns.Remove("ModifiedByName");
                //}
                //if (dt.Columns.Contains("CreatedDate"))
                //{
                //    dt.Columns.Remove("CreatedDate");
                //}
                //if (dt.Columns.Contains("ModifiedDate"))
                //{
                //    dt.Columns.Remove("ModifiedDate");
                //}
            }
            else
            {
                dt = null;
            }
            string FirstName = string.IsNullOrEmpty(txtFirstName.Text) ? null : txtFirstName.Text;
            string MiddleName = string.IsNullOrEmpty(txtMiddleName.Text) ? null : txtMiddleName.Text;
            string LastName = string.IsNullOrEmpty(txtLastName.Text) ? null : txtLastName.Text;
            string Address = string.IsNullOrEmpty(txtAddress.Text) ? null : txtAddress.Text;
            string City = string.IsNullOrEmpty(txtCity.Text) ? null : txtCity.Text;
            string State = string.IsNullOrEmpty(txtState.Text) ? null : txtState.Text;
            string Zip = string.IsNullOrEmpty(txtZip.Text) ? null : txtZip.Text;
            string PhoneNumber = string.IsNullOrEmpty(txtPhoneNumber.Text) ? null : txtPhoneNumber.Text;
            string Email = string.IsNullOrEmpty(txtEmail.Text) ? null : txtEmail.Text;
            string SSN = string.IsNullOrEmpty(txtSSN.Text) ? null : txtSSN.Text;
            string MMN = string.IsNullOrEmpty(txtMMN.Text) ? null : txtMMN.Text;
            string DateOfBirth = string.IsNullOrEmpty(txtDateOfBirth.Text) ? null : txtDateOfBirth.Text;
            string ConfirmNumber = string.IsNullOrEmpty(txtConfirmNumber.Text) ? null : txtConfirmNumber.Text;
            decimal? Fee = string.IsNullOrEmpty(txtFee.Text) ? Nulldecimal : Convert.ToDecimal(txtFee.Text);
            string QANumber = string.IsNullOrEmpty(txtQANumber.Text) ? null : txtQANumber.Text;
            string PaymentNotes = string.IsNullOrEmpty(txtPaymentNotes.Text) ? null : txtPaymentNotes.Text;
            string TimeStamp = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            string Agent = ddlAgent.SelectedValue;
            string Closer = ddlCloser.SelectedValue;
            int StatusId = Convert.ToInt32(ddlStatus.SelectedValue);
            int AdvisersId = Convert.ToInt32(ddlAdvisers.SelectedValue);
            decimal? TotalDebt = string.IsNullOrEmpty(txtTotalDebt.Text) ? Nulldecimal : Convert.ToDecimal(txtTotalDebt.Text);
            decimal? Savings = string.IsNullOrEmpty(txtSavings.Text) ? Nulldecimal : Convert.ToDecimal(txtSavings.Text);
            decimal? Deal = string.IsNullOrEmpty(txtDeal.Text) ? Nulldecimal : Convert.ToDecimal(txtDeal.Text);
            int? DispositionId = Convert.ToInt32(ddlDisposition.SelectedValue);
            string Comments = string.IsNullOrEmpty(txtComments.Text) ? null : txtComments.Text;
            string TollFreePhone = string.IsNullOrEmpty(txtTollFree.Text) ? null : txtTollFree.Text;

            int OperationType = hfMasterLeadId.Value == "0" ? (int)OperationTypes.Insert : (int)OperationTypes.Update;
            int MasterLeadId = Convert.ToInt32(hfMasterLeadId.Value);
            DataSet ds = new BAL_Lead().Lead_Crud(OperationType, UserId, 100, 1, MasterLeadId, FirstName, MiddleName, LastName
                , Address, StatusId, PhoneNumber, City, State, Zip, Email, SSN, MMN, DateOfBirth, ConfirmNumber, Fee,
                QANumber, PaymentNotes, TimeStamp, Agent, Closer, AdvisersId, TotalDebt, Savings, Deal,
                UserIP, DispositionId, dt, Comments, TollFreePhone);

            if (ds != null)
            {
                if (ds.Tables[0].Rows[0]["HasError"].ToString() == "0")
                {
                    Success(ds.Tables[0].Rows[0]["Message"].ToString());
                    Response.Redirect("/Pages/LeadsList.aspx", false);
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
        catch (Exception ex)
        {

            Error("Error Occured On Saving Data");
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Pages/LeadsList.aspx", false);
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
    public void AlertBox_Error_Return(string message)
    {
        message = "AlertBox_Error_Return('Error!','" + message + "','error');";
        ScriptManager.RegisterStartupScript(this, GetType(), message, message, true);
    }


    private void Disable_Controls()
    {
        bool Enabled_Control = false;
        if (GetLeadId > 0 && GetIsEdit == 1)
        {
            btnSave.Visible = true;
            btnAddFinancial.Visible = true;
            Enabled_Control = true;
        }
        else if (GetLeadId == 0)
        {
            btnSave.Visible = true;
            btnAddFinancial.Visible = true;
            Enabled_Control = true;
        }
        else if (GetLeadId > 0 && GetIsEdit == 0)
        {
            btnAddFinancial.Visible = false;
            btnSave.Visible = false;
            Enabled_Control = false;
        }
        txtFirstName.Enabled = txtMiddleName.Enabled = txtLastName.Enabled = txtAddress.Enabled = txtCity.Enabled
            = txtZip.Enabled = txtEmail.Enabled = txtSSN.Enabled = txtMMN.Enabled = txtMMN.Enabled = txtDateOfBirth.Enabled
            = txtConfirmNumber.Enabled = txtFee.Enabled = txtQANumber.Enabled = txtPaymentNotes.Enabled = txtTimeStamp.Enabled
             = ddlAgent.Enabled = ddlCloser.Enabled = ddlStatus.Enabled = ddlAdvisers.Enabled =
             txtTotalDebt.Enabled = txtSavings.Enabled = txtPhoneNumber.Enabled = txtDeal.Enabled
            = txtEmail.Enabled = Enabled_Control;
        txtTimeStamp.Enabled = false;
        txtTimeStamp.Text = DateTime.Now.ToString("yyyy-MM-dd");
    }
    private void BindDropDown()
    {
        try
        {
            DataSet ds = new BAL_Lead().Lead_Crud((int)OperationTypes.DropDownValues);
            CommonObjects.BindDropDown(ddlStatus, ds.Tables[0], "LeadStatusName", "LeadStatusId", true, false);
            //CommonObjects.BindDropDown(ddlBank, ds.Tables[1], "BankName", "BankId", true, false);
            CommonObjects.BindDropDown(ddlAccounts, ds.Tables[1], "AccountName", "AccountId", true, false);
            CommonObjects.BindDropDown(ddlAdvisers, ds.Tables[2], "Name", "UserId", true, false);
            CommonObjects.BindDropDown(ddlAgent, ds.Tables[3], "Name", "UserId", true, false);
            CommonObjects.BindDropDown(ddlCloser, ds.Tables[4], "Name", "UserId", true, false);
            CommonObjects.BindDropDown(ddlDisposition, ds.Tables[5], "DispositionCallName", "Id", true, false);

        }
        catch (Exception ex)
        {
            Error("Error Occured during Binding Drop down");
            Logger.WriteErrorLog("/Pages/Setup/User.aspx", "BindDropDown", ex.ToString());
        }
    }

    private void BindElementOnEdit()
    {
        try
        {
            DataSet ds = new BAL_Lead().Lead_Crud((int)OperationTypes.Select, UserId, 100, 1, GetLeadId);
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    hfMasterLeadId.Value = dt.Rows[0]["LeadId"].ToString();
                    txtFirstName.Text = dt.Rows[0]["FirstName"].ToString();
                    txtMiddleName.Text = dt.Rows[0]["MiddleName"].ToString();
                    txtLastName.Text = dt.Rows[0]["LastName"].ToString();
                    txtAddress.Text = dt.Rows[0]["Address"].ToString();
                    txtCity.Text = dt.Rows[0]["City"].ToString();
                    txtState.Text = dt.Rows[0]["State"].ToString();
                    txtZip.Text = dt.Rows[0]["Zip"].ToString();
                    txtPhoneNumber.Text = dt.Rows[0]["PhoneNumber"].ToString();
                    txtEmail.Text = dt.Rows[0]["Email"].ToString();
                    txtSSN.Text = dt.Rows[0]["SSN"].ToString();
                    txtMMN.Text = dt.Rows[0]["MMN"].ToString();
                    txtDateOfBirth.Text = string.IsNullOrEmpty(dt.Rows[0]["DateOfBirth"].ToString()) ? "" : Convert.ToDateTime(dt.Rows[0]["DateOfBirth"].ToString()).ToString("yyyy-MM-dd");
                    txtConfirmNumber.Text = dt.Rows[0]["ConfirmNumber"].ToString();
                    txtFee.Text = dt.Rows[0]["Fee"].ToString();
                    txtQANumber.Text = dt.Rows[0]["QAnumber"].ToString();
                    txtPaymentNotes.Text = dt.Rows[0]["PaymentNotes"].ToString();
                    txtTimeStamp.Text = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
                    ddlAgent.SelectedValue = dt.Rows[0]["Agent"].ToString();
                    ddlCloser.SelectedValue = dt.Rows[0]["Closer"].ToString();
                    ddlStatus.SelectedValue = dt.Rows[0]["StatusId"].ToString();
                    ddlAdvisers.SelectedValue = dt.Rows[0]["AdvisersId"].ToString();
                    txtTotalDebt.Text = dt.Rows[0]["TotalDebt"].ToString();
                    txtSavings.Text = dt.Rows[0]["Savings"].ToString();
                    txtDeal.Text = dt.Rows[0]["Deal"].ToString();
                    ddlDisposition.SelectedValue = dt.Rows[0]["DispositionCallId"].ToString();
                    txtTollFree.Text = dt.Rows[0]["TollFreeNumber"].ToString();
                    txtComments.Text = dt.Rows[0]["Comments"].ToString();

                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
                else
                {
                    AlertBox_Error_Return("df");
                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    DataTable dt = ds.Tables[1];
                    FinancialTable = dt;
                    BindFinancialRepaeter();
                }

                if (ds.Tables[2].Rows.Count > 0)
                {
                   
                    DataTable dt = ds.Tables[2];
                    txtComments.Text = dt.Rows[0]["Comments"].ToString();
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void btnAddFinancial_Click(object sender, EventArgs e)
    {
        TabNoActive();
        ClearFinancialModalControl();
        OpenPopup();
    }



    protected void rptFinancial_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                ImageButton lbEdit = (ImageButton)e.Item.FindControl("lbEditFinancial");
                ImageButton lbDelete = (ImageButton)e.Item.FindControl("lbDeleteFinancial");

                if ( IsEditFinancial.Value=="1")
                {
                    lbEdit.Visible = true;
                }
                if ( IsDeleteFinancial.Value == "1")
                {
                    lbDelete.Visible = true;
                }


            }
        }
        catch (Exception ex)
        {
            Error("Error Occured during Item data bound");
        }
    }

    protected void lbEditFinancial_Click(object sender, ImageClickEventArgs e)
    {
        OpenPopup();
        ImageButton lbEdit = (ImageButton)sender;
        RepeaterItem rptItem = (RepeaterItem)lbEdit.NamingContainer;

        int hfLeadFinancialId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfLeadFinancialId")).Value);
        int RowNumber = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfRowNum")).Value);
        int hfAccountId = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfAccountsId")).Value);
        string hfBankName = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfBankName")).Value);
        string hfServiceNumber = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfServiceNumber")).Value);
        string hfCC = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfCC")).Value);
        string hfExp = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfExp")).Value);
        int hfCVC = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfCVC")).Value);
        decimal hfOwe = decimal.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfOwe")).Value);
        decimal hfAvailableBalance = decimal.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfAvailableBalance")).Value);
        decimal hfLP = decimal.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfLP")).Value);
        decimal hfDP = decimal.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfDP")).Value);
        decimal hfMP = decimal.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfMP")).Value);
        decimal hfAPR = decimal.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfAPR")).Value);
        bool IsSelected = bool.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfIsSelected")).Value);

        ddlAccounts.SelectedValue = hfAccountId.ToString();
        txtBankName.Text = hfBankName;
        txtServiceNumber.Text = hfServiceNumber;
        txtCC.Text = hfCC;
        txtExp.Text = hfExp;
        txtCVC.Text = hfCVC.ToString();
        txtOwe.Text = hfOwe.ToString();
        txtAvailableBalance.Text = hfAvailableBalance.ToString();
        txtLP.Text = hfLP.ToString();
        txtDP.Text = hfDP.ToString();
        txtMP.Text = hfMP.ToString();
        txtAPR.Text = hfAPR.ToString();
        hfRowNumber.Value = RowNumber.ToString();
        hfId.Value = hfLeadFinancialId.ToString();
        hfIsSelect.Value = IsSelected == true ? "True" : "False";
    }

    protected void lbDeleteFinancial_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton lbDeleteFinancial = (ImageButton)sender;
            RepeaterItem rptItem = (RepeaterItem)lbDeleteFinancial.NamingContainer;
            DataTable dt = FinancialTable;
            dt.Rows.RemoveAt(rptItem.ItemIndex);
            dt.AcceptChanges();
            FinancialTable = dt;
            BindFinancialRepaeter();
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    public void BindFinancialRepaeter()
    {
        rptFinancial.DataSource = FinancialTable;
        rptFinancial.DataBind();
    }
    public void CreateFinancialDatatable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("RowNum", typeof(int));
        dt.Columns.Add("LeadFinancialId", typeof(int));
        dt.Columns.Add("AccountName", typeof(string));
        //dt.Columns.Add("CreatedByName", typeof(string));
        //dt.Columns.Add("ModifiedByName", typeof(string));
        //dt.Columns.Add("CreatedDate", typeof(string));
        //dt.Columns.Add("ModifiedDate", typeof(string));
        dt.Columns.Add("AccountsId", typeof(int));
        dt.Columns.Add("BankName", typeof(string));
        dt.Columns.Add("ServiceNumber", typeof(string));
        dt.Columns.Add("CC", typeof(string));
        dt.Columns.Add("Exp", typeof(string));
        dt.Columns.Add("CVC", typeof(int));
        dt.Columns.Add("Owe", typeof(decimal));
        dt.Columns.Add("AvailableBalance", typeof(decimal));
        dt.Columns.Add("LP", typeof(decimal));
        dt.Columns.Add("DP", typeof(decimal));
        dt.Columns.Add("MP", typeof(decimal));
        dt.Columns.Add("APR", typeof(decimal));
        dt.Columns.Add("IsSelected", typeof(bool));

        FinancialTable = dt;
    }
    public DataTable FinancialTable
    {
        get
        {
            return ViewState["FinancialTable"] != null ? (DataTable)ViewState["FinancialTable"] : null;
        }
        set
        {
            ViewState["FinancialTable"] = value;
        }
    }

    protected void btnSaveFinancial_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfId.Value == "0" && hfRowNumber.Value == "0")
            {
                if (FinancialTable == null)
                {
                    CreateFinancialDatatable();
                }
                DataTable dtFinancials = FinancialTable;
                DataRow dr = dtFinancials.NewRow();
                int RowNum = 1;
                if (dtFinancials != null && dtFinancials.Rows.Count > 0)
                {
                    RowNum = Convert.ToInt32(dtFinancials.Rows[dtFinancials.Rows.Count - 1]["RowNum"].ToString()) + 1;
                }


                dr["RowNum"] = Convert.ToInt32(RowNum);
                dr["LeadFinancialId"] = 0;
                dr["AccountName"] = ddlAccounts.SelectedItem.Text;
                dr["BankName"] = txtBankName.Text;
                //dr["CreatedByName"] = FullName;
                //dr["ModifiedByName"] = FullName;
                //dr["CreatedDate"] = DateTime.Now.ToString("yyyy-MM-dd");
                //dr["ModifiedDate"] = DateTime.Now.ToString("yyyy-MM-dd");
                dr["AccountsId"] = Convert.ToInt32(ddlAccounts.SelectedValue);
                dr["BankName"] = txtBankName.Text;
                dr["ServiceNumber"] = txtServiceNumber.Text;
                dr["CC"] = txtCC.Text;
                dr["Exp"] = txtExp.Text;
                dr["CVC"] = string.IsNullOrEmpty(txtCVC.Text) ? Nullint : Convert.ToInt32(txtCVC.Text);
                dr["Owe"] = string.IsNullOrEmpty(txtOwe.Text) ? Nulldecimal : Convert.ToDecimal(txtOwe.Text);
                dr["AvailableBalance"] = string.IsNullOrEmpty(txtAvailableBalance.Text) ? Nulldecimal : Convert.ToDecimal(txtAvailableBalance.Text);
                dr["LP"] = string.IsNullOrEmpty(txtLP.Text) ? Nulldecimal : Convert.ToDecimal(txtLP.Text);
                dr["DP"] = string.IsNullOrEmpty(txtDP.Text) ? Nulldecimal : Convert.ToDecimal(txtDP.Text);
                dr["MP"] = string.IsNullOrEmpty(txtMP.Text) ? Nulldecimal : Convert.ToDecimal(txtMP.Text);
                dr["APR"] = string.IsNullOrEmpty(txtAPR.Text) ? Nulldecimal : Convert.ToDecimal(txtAPR.Text);
                dr["IsSelected"] = hfIsSelect.Value;

                dtFinancials.Rows.Add(dr);
                FinancialTable = dtFinancials;
                BindFinancialRepaeter();
                ClearFinancialModalControl();
                ClosePopup();
            }
            else
            {
                if (FinancialTable != null && FinancialTable.Rows.Count > 0)
                {
                    DataTable dtFinancials = FinancialTable;
                    int RowNumber = Convert.ToInt32(hfRowNumber.Value);
                    int LeadFinancialId = Convert.ToInt32(hfId.Value);
                    DataRow dr = dtFinancials.Select("RowNum=" + RowNumber.ToString()).CopyToDataTable().Rows[0];
                    dr["RowNum"] = RowNumber;

                    dr["LeadFinancialId"] = LeadFinancialId;
                    dr["AccountName"] = ddlAccounts.SelectedItem.Text;
                    dr["BankName"] = txtBankName.Text;
                    //dr["CreatedByName"] = FullName;
                    //dr["ModifiedByName"] = FullName;
                    //dr["CreatedDate"] = DateTime.Now.ToString("yyyy-MM-dd");
                    //dr["ModifiedDate"] = DateTime.Now.ToString("yyyy-MM-dd");
                    dr["AccountsId"] = Convert.ToInt32(ddlAccounts.SelectedValue);
                    dr["BankName"] = txtBankName.Text;
                    dr["ServiceNumber"] = txtServiceNumber.Text;
                    dr["CC"] = txtCC.Text;
                    dr["Exp"] = txtExp.Text;
                    dr["CVC"] = string.IsNullOrEmpty(txtCVC.Text) ? Nullint : Convert.ToInt32(txtCVC.Text);
                    dr["Owe"] = string.IsNullOrEmpty(txtOwe.Text) ? Nulldecimal : Convert.ToDecimal(txtOwe.Text);
                    dr["AvailableBalance"] = string.IsNullOrEmpty(txtAvailableBalance.Text) ? Nulldecimal : Convert.ToDecimal(txtAvailableBalance.Text);
                    dr["LP"] = string.IsNullOrEmpty(txtLP.Text) ? Nulldecimal : Convert.ToDecimal(txtLP.Text);
                    dr["DP"] = string.IsNullOrEmpty(txtDP.Text) ? Nulldecimal : Convert.ToDecimal(txtDP.Text);
                    dr["MP"] = string.IsNullOrEmpty(txtMP.Text) ? Nulldecimal : Convert.ToDecimal(txtMP.Text);
                    dr["APR"] = string.IsNullOrEmpty(txtAPR.Text) ? Nulldecimal : Convert.ToDecimal(txtAPR.Text);
                    dr["IsSelected"] = false;
                    FinancialTable = dtFinancials;
                    BindFinancialRepaeter();
                    ClearFinancialModalControl();
                    ClosePopup();
                }
            }
        }
        catch (Exception ex)
        {

            Error("Error on Adding Financial");
        }
    }
    public void ClosePopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopup()", "ClosePopup();", true);
    }
    public void OpenPopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "OpenPopup()", "OpenPopup();", true);
    }
    public void TabNoActive()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "TabNoActive()", "TabNoActive();", true);
    }
    private void SetFeature()
    {
        try
        {
            btnAddFinancial.Visible = false;
            btnSave.Visible = false;
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
                        btnAddFinancial.Visible = true;
                    }
                    if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.Update)
                    {
                        IsEdit.Value = "1";
                    }
                    if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.Delete)
                    {
                        IsDelete.Value = "1";
                    }
                    if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.EditFinancial)
                    {
                        IsEditFinancial.Value = "1";
                    }
                    if (Convert.ToInt32(dt.Rows[i]["FeatureId"].ToString()) == (int)Feature.DeleteFinancial)
                    {
                        IsDeleteFinancial.Value = "1";
                    }
                }
            }
        }
        catch (Exception ex) { }
    }
    private void ClearFinancialModalControl()
    {
        ddlAccounts.SelectedValue = "0";
        txtBankName.Text = "";
        txtServiceNumber.Text = "";
        txtCC.Text = "";
        txtExp.Text = "";
        txtCVC.Text = "";
        txtOwe.Text = "";
        txtAvailableBalance.Text = "";
        txtLP.Text = "";
        txtDP.Text = "";
        txtMP.Text = "";
        txtAPR.Text = "";
    }

    protected void rdIsSelected_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton rdIsSelected = (RadioButton)sender;
        RepeaterItem rptItem = (RepeaterItem)rdIsSelected.NamingContainer;

        rdIsSelected.Checked = true;
        bool rdIsSelecteds = (((RadioButton)rptItem.FindControl("rdIsSelected")).Checked);
        string hfIsSelecteds = (((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfIsSelected")).Value);
        int RowNum = int.Parse(((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfRowNum")).Value);
        foreach (DataRow item in FinancialTable.Rows)
        {
            item["IsSelected"] = "False";
        }
        DataTable dtFinancials = FinancialTable;
        foreach (DataRow item in dtFinancials.Rows)
        {
            if (item["RowNum"].ToString() == RowNum.ToString())
            {
                item["IsSelected"] = "True";
            }
        }
        //DataRow dr = dtFinancials.Select("RowNum=" + RowNum.ToString()).CopyToDataTable().Rows[0];
        //dr["IsSelected"] = true;
        //dtFinancials.AcceptChanges();
        FinancialTable = dtFinancials;
        BindFinancialRepaeter();
        //((System.Web.UI.HtmlControls.HtmlInputHidden)rptItem.FindControl("hfIsSelected")).Value = "True";
        hfTabNoActive.Value = "2";
        TabNoActive();
    }

    private void AssignValuesToDataTable(DataRow drs)
    {
        DataRow dr = drs;
        dr["AccountName"] = ddlAccounts.SelectedItem.Text;
        dr["BankName"] = txtBankName.Text;
        //dr["CreatedByName"] = FullName;
        //dr["ModifiedByName"] = FullName;
        //dr["CreatedDate"] = DateTime.Now.ToString("yyyy-MM-dd");
        //dr["ModifiedDate"] = DateTime.Now.ToString("yyyy-MM-dd");
        dr["AccountsId"] = Convert.ToInt32(ddlAccounts.SelectedValue);
        dr["BankName"] = txtBankName.Text;
        dr["ServiceNumber"] = txtServiceNumber.Text;
        dr["CC"] = txtCC.Text;
        dr["Exp"] = txtExp.Text;
        dr["CVC"] = string.IsNullOrEmpty(txtCVC.Text) ? Nullint : Convert.ToInt32(txtCVC.Text);
        dr["Owe"] = string.IsNullOrEmpty(txtOwe.Text) ? Nulldecimal : Convert.ToDecimal(txtOwe.Text);
        dr["AvailableBalance"] = string.IsNullOrEmpty(txtAvailableBalance.Text) ? Nulldecimal : Convert.ToDecimal(txtAvailableBalance.Text);
        dr["LP"] = string.IsNullOrEmpty(txtLP.Text) ? Nulldecimal : Convert.ToDecimal(txtLP.Text);
        dr["DP"] = string.IsNullOrEmpty(txtDP.Text) ? Nulldecimal : Convert.ToDecimal(txtDP.Text);
        dr["MP"] = string.IsNullOrEmpty(txtMP.Text) ? Nulldecimal : Convert.ToDecimal(txtMP.Text);
        dr["APR"] = string.IsNullOrEmpty(txtAPR.Text) ? Nulldecimal : Convert.ToDecimal(txtAPR.Text);
        drs = dr;

    }
}