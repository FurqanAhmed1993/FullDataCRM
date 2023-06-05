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
    public class BAL_Timer : DAL_Timer
    {
        DataTable dt = new DataTable();

        public DataTable TimerDetails_Crud(int OperationId,  int? Id , DateTime? StartTimer , DateTime? EndTimer , bool? IsActive ,
            int? UserId , string UserIp ,int? PageNumber = 1, int? PageSize = 50)
        {
            dt = Crud_TimerDetails(OperationId, Id, StartTimer, EndTimer, IsActive, UserId, UserIp, PageNumber, PageSize);
            return dt;
        }
    }
}
