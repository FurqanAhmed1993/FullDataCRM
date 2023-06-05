using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Utilities;
using DAL;

namespace BAL
{
    public class BAL_User : DAL_User
    {
        DataTable dt = new DataTable();

        public DataTable UserLogin_Crud(int OperationId = (int)Setup_MasterDetail.OperationType_Select, int? PageNumber = 1, 
            int? PageSize = 50,
            int? UserId = null, int? RoleId = null,string Name = null, string EmailAddress = null
            , string UserPassword = null, bool? IsLogin = null, bool? IsActive = null, int? CreatedBy = null
            , string UserIp = null)
        {
            dt = Crud_UserLogin(OperationId,PageNumber,PageSize,  UserId, RoleId, Name,EmailAddress,UserPassword,IsLogin,IsActive
                ,CreatedBy,UserIp);
            return dt;
        }
       
        public string ValidateControls(int RoleID)
        {
            string msg = "";
            if (RoleID > 0)
            {
                

            }
            else
            {
                msg = "Please select Role";
            }


            return msg;
        }
        public void ExportToExcel(string FileName, DataTable dt)
        {
            try
            {

                dt.Columns.Remove("DCMId");
                dt.Columns.Remove("UserId");
                dt.Columns.Remove("RoleId");
                dt.Columns.Remove("DistributorId");
                dt.Columns.Remove("IsActive");
                dt.Columns.Remove("UserIP");
                // CommonObjects.ExportToExcel(FileName, dt);
            }
            catch
            {
            }
        }
    }
}
