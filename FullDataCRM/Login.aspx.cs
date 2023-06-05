using System;
using System.Data;
using System.Web.UI;
using BAL;
using Utilities;

public partial class Login : Base
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session.Abandon();
            new Base().ExpireCookie();
            lblYear.Text = Convert.ToString(DateTime.Now.Year);
            //if (UserId > 0 && RoleId > 0)
            //{
            //    string Redirect = GenericConstants.GetDefaultPage;
            //    Response.Redirect(Redirect);
            //}
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        bool IsAuthenticate = false;
        try
        {
            string LoginId = txtUserName.Text.Trim();
            if (LoginId != "")
            {
                string Password = txtPassword.Text.Trim();
                if (Password != "")
                {
                    Password = CommonObjects.GetHash(txtPassword.Text.Trim());
                    DataTable dt = new BAL_Login().Get_UserByLoginId(Setup_MasterDetail.OperationType_Select,LoginId);
                    if (dt.Rows.Count > 0)
                    {
                        int _UserId = Convert.ToInt32(dt.Rows[0]["UserId"].ToString());
                        if (_UserId > 0)
                        {
                            if (dt.Rows[0]["UserPassword"].ToString() == Password)
                            {
                               int _RoleId = Convert.ToInt32(dt.Rows[0]["RoleId"].ToString());
                              
                               Base baseClass = new Base();
                               baseClass.UserId = _UserId;
                               baseClass.FullName = Convert.ToString(dt.Rows[0]["Name"].ToString());                                    
                               baseClass.RoleId = _RoleId;                                  
                               baseClass.LoginId = Convert.ToString(dt.Rows[0]["LoginId"].ToString()); ;
                                string Redirect = Convert.ToString(dt.Rows[0]["DefaultPage_URL"]) == "" ? GenericConstants.GetDefaultPage : Convert.ToString(dt.Rows[0]["DefaultPage_URL"]);
                               IsAuthenticate = true;
                               InsertUserLoginHistory(_UserId, true);
                                DataTable dts = new BAL_Login().Get_UserByLoginId(Setup_MasterDetail.OperationType_Update, LoginId,true);
                                Response.Redirect(Redirect, false);
                                
                            }
                            else
                            {
                                lblValidation.Text = "Invalid Password";
                                InsertUserLoginHistory(_UserId, false);
                            }
                        }
                    }
                    else
                    {
                        lblValidation.Text = "Invalid Login Id";
                    }
                }
                else
                {
                    lblValidation.Text = "Please enter the Password";
                }
            }
            else
            {
                lblValidation.Text = "Please enter the Login Id";
            }
        }
        catch (Exception ex)
        {
            if (IsAuthenticate == false)
            {
                Logger.WriteErrorLog("Login.aspx", "btnLogin_Click", ex.Message);
            }
        }
    }
    protected void btnForgetPassword_Click(object sender, EventArgs e)
    {

    }
    public void ClosePopup()
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopup()", "ClosePopup();", true);
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
    private void InsertUserLoginHistory(int UserId, bool IsSuccess)
    {
        new BAL_Login().Insert_UserLoginHistory(UserId, IsSuccess, UserIP);
    }


}