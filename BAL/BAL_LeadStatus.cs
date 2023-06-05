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
    public class BAL_LeadStatus : DAL_LeadStatus
    {
        DataTable dt = new DataTable();

        public DataTable LeadStatus_Crud(int OperationId, int? PageNumber = 1,
            int? PageSize = 50, int? LeadStatusID = null, string LeadStatusName = null, bool? IsActive = null, int? UserId = null, string UserIp = null)
        {
            dt = Crud_LeadStatus(OperationId, PageNumber, PageSize, LeadStatusID, LeadStatusName, IsActive, UserId, UserIp);
            return dt;
        }
    }
}
