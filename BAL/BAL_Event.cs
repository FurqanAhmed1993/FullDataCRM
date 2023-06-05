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
    public class BAL_Event : DAL_Event
    {
        DataTable dt = new DataTable();

        public DataTable Event_Crud(int OperationId, int? PageNumber = 1,
            int? PageSize = 50, int? EventId = null, int? NotificationId = null, DateTime? EventStartDate = null, DateTime? EventEndDate = null , 
            string Name = null, string Description = null, bool? IsActive = null, int? UserId = null, string UserIp = null)
        {
            dt = Crud_Event(OperationId, PageNumber, PageSize, EventId, NotificationId, EventStartDate , EventEndDate , Name, Description, IsActive, UserId, UserIp);
            return dt;
        }
    }
}
