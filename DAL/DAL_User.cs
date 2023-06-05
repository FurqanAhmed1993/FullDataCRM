using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Utilities;

namespace DAL
{
    public class DAL_User : DAL
    {
        public DataTable Crud_UserLogin(int OperationId=(int)Setup_MasterDetail.OperationType_Select,int? PageNumber=1,int? PageSize=50 , int? UserId=null, int? RoleId=null, 
            string Name=null,string EmailAddress=null,string UserPassword=null,  bool? IsLogin=null, bool? IsActive = null,  int? CreatedBy=null, string UserIp=null)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_UserLogin"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationId", SqlDbType.Int).Value = OperationId;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = UserId;
                    cmd.Parameters.Add("@RoleId", SqlDbType.Int).Value = RoleId;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = Name;
                    cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = EmailAddress;
                    cmd.Parameters.Add("@UserPassword", SqlDbType.VarChar).Value = UserPassword;
                    cmd.Parameters.Add("@IsLogin", SqlDbType.VarChar).Value = IsLogin;
                    cmd.Parameters.Add("@IsActive", SqlDbType.VarChar).Value = IsActive;
                    cmd.Parameters.Add("@CreatedBy", SqlDbType.Int).Value = CreatedBy;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIp;
                    cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = PageNumber;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = PageSize;
                    dt = GetData(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during Crud_UserLogin : {0}", ex.Message), ex);
            }
            return dt;
        }

       

    }
}
