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
    public class BAL_Notifications : DAL_Notifications
    {
        DataTable dt = new DataTable();

        public DataTable Notification_Crud(int OperationTypeId = (int)OperationTypes.Select, int? PageNumber = 1, int? PageSize = 50, int? LoginUserId = null,
             string UserIp = null, int? NotificationId = null, string NotificationTitle = null, int? NotificationTypeId = null, string NotificationMessage = null,
             string NotificationDateTime = null , DateTime? NotifyDate = null , DateTime? FromNotifyDate = null , DateTime? ToNotifyDate = null)
        {
            dt = Crud_Notification(OperationTypeId, PageNumber,PageSize,LoginUserId, UserIp, NotificationId, NotificationTitle, NotificationTypeId, NotificationMessage
                , NotificationDateTime, NotifyDate, FromNotifyDate , ToNotifyDate);
            return dt;
        }
       
       
    }
}
