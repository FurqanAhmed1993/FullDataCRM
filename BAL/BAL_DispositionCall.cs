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
    public class BAL_DispositionCall : DAL_DispositionCall
    {
        DataTable dt = new DataTable();

        public DataTable DispositionCall_Crud(int OperationId, int? PageNumber = 1,
            int? PageSize = 50, int? Id = null, string DispositionCallName = null, bool? IsActive = null, int? UserId = null, string UserIp = null)
        {
            dt = Crud_DispositionCall(OperationId, PageNumber, PageSize, Id, DispositionCallName, IsActive, UserId, UserIp);
            return dt;
        }
    }
}
