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
    public class BAL_Accounts : DAL_Accounts
    {
        DataTable dt = new DataTable();

        public DataTable Accounts_Crud(int OperationId, int? PageNumber = 1,
            int? PageSize = 50, int? AccountId = null, string AccountName = null, bool? IsActive = null, int? UserId = null, string UserIp = null)
        {
            dt = Crud_Accounts(OperationId, PageNumber, PageSize, AccountId, AccountName, IsActive, UserId, UserIp);
            return dt;
        }

    }
}
