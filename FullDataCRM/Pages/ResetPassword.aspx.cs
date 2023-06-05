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


public partial class Pages_ResetPassword : Base
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAgents();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtEmail.Text = "";
        txtResetPassword.Text = "";
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            int pageSize = 0;
            int pageNumber = 0;
    

            int skip = pageNumber * pageSize - pageSize;
            DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_ResetUserPassword,
                                                         pageNumber,
                                                         pageSize,
                                                         int.Parse(ddlEmail.SelectedItem.Value),
                                                         0,
                                                         "",
                                                         txtEmail.Text,
                                                         CommonObjects.GetHash(txtResetPassword.Text));
            
            if (dt != null && dt.Rows.Count > 0)
            {
                Success(dt.Rows[0]["Message"].ToString());
                txtEmail.Text = "";
                txtResetPassword.Text = "";
            }

        }

        catch (Exception ex)
        {

        }
    }

    public void GetAgents()
    {
        DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_Select,
                                                            1,
                                                            500,
                                                            0,
                                                            null);
        if (dt != null & dt.Rows.Count > 0)
        {
            CommonObjects.BindDropDown(ddlEmail, dt, "Name", "UserId", true, false);
        }
    }

    protected void ddlEmail_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new BAL_User().UserLogin_Crud(Setup_MasterDetail.OperationType_Select,
                                                            1,
                                                            500,
                                                             int.Parse(ddlEmail.SelectedItem.Value));
        if (dt != null && dt.Rows.Count > 0)
        {
            txtEmail.Text = dt.Rows[0]["EmailAddress"].ToString();
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



}