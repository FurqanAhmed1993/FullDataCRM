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
    public class BAL_Bank : DAL_Bank
    {
        DataTable dt = new DataTable();

        public DataTable Bank_Crud(int OperationId , int? PageNumber = 1,
            int? PageSize = 50, int? BankId = null , string BankName = null, bool? IsActive = null, int? UserId = null, string UserIp = null)
        {
            dt = Crud_Bank(OperationId, PageNumber, PageSize, BankId, BankName ,  IsActive ,UserId , UserIp);
            return dt;
        }

    }
}
