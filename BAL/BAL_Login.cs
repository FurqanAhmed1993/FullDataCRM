using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DAL;

namespace BAL
{
    public class BAL_Login : DAL_Login
    {
        DataTable dt = new DataTable();
        public DataTable Get_UserByLoginId(int OperationTypeId,string LoginId,bool? IsLogin=null)
        {
            dt = usp_UserLogin_Get_UserByLoginId(OperationTypeId,LoginId, IsLogin);
            return dt;
        }
        public DataTable Insert_UserLoginHistory(int UserId, bool IsSuccess, string UserIp)
        {
            dt = usp_UserLoginHistory_Insert(UserId, IsSuccess, UserIp);
            return dt;
        }
        public DataTable UpdatePassword(int UserId, string OldPassword, string NewPassword, string UserIp)
        {
            dt = usp_UserLogin_UpdatePassword(UserId, OldPassword, NewPassword, UserIp);
            return dt;
        }
    }
}
