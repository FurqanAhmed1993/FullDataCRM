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
    public class DAL_Notifications : DAL
    {
        protected DataTable Crud_Notification(int OperationTypeId=(int)OperationTypes.Select,int? PageNumber=1,int? PageSize=50 , int? LoginUserId=null, 
             string UserIp=null,int ? NotificationId=null,string NotificationTitle=null,int? NotificationTypeId=null,string NotificationMessage=null,
             string NotificationDateTime=null , DateTime? NotifyDate = null , DateTime? FromNotifyDate = null, DateTime? ToNotifyDate = null)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand("CrudNotification"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationTypeId", SqlDbType.Int).Value = OperationTypeId;
                    cmd.Parameters.Add("@NotificationId", SqlDbType.Int).Value = NotificationId;
                    cmd.Parameters.Add("@NotificationTitle", SqlDbType.VarChar).Value = NotificationTitle;
                    cmd.Parameters.Add("@NotificationTypeId", SqlDbType.Int).Value = NotificationTypeId;
                    cmd.Parameters.Add("@NotificationMessage", SqlDbType.NVarChar).Value = NotificationMessage;
                    cmd.Parameters.Add("@NotificationDateTime", SqlDbType.VarChar).Value = NotificationDateTime;
                    cmd.Parameters.Add("@LoginUserId", SqlDbType.Int).Value = LoginUserId;
                    cmd.Parameters.Add("@UserIP", SqlDbType.NVarChar).Value = UserIp;
                    cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = PageNumber;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = PageSize;
                    cmd.Parameters.Add("@NotifyDate", SqlDbType.DateTime).Value = NotifyDate;
                    cmd.Parameters.Add("@FromNotifyDate", SqlDbType.DateTime).Value = FromNotifyDate;
                    cmd.Parameters.Add("@ToNotifyDate", SqlDbType.DateTime).Value = ToNotifyDate;
                    dt = GetData(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during Crud_Notification : {0}", ex.Message), ex);
            }
            return dt;
        }

       

    }
}
