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
    public class DAL_Timer : DAL
    {
        public DataTable Crud_TimerDetails(int OperationId, int? Id, DateTime? StartTimer, DateTime? EndTimer, bool? IsActive, int? UserId, string UserIp, int? PageNumber, int? PageSize)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand("CRUD_TimerDetails"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationId", SqlDbType.Int).Value = OperationId;
                    cmd.Parameters.Add("@StartTimer", SqlDbType.DateTime).Value = StartTimer;
                    cmd.Parameters.Add("@EndTimer", SqlDbType.DateTime).Value = EndTimer;
                    cmd.Parameters.Add("@IsActive", SqlDbType.VarChar).Value = IsActive;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIp;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = UserId;
                    cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = PageNumber;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = PageSize;
                    dt = GetData(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during CRUD_TimerDetails : {0}", ex.Message), ex);
            }
            return dt;
        }
    }
}
