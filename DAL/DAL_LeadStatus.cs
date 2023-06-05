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
    public class DAL_LeadStatus : DAL
    {
        public DataTable Crud_LeadStatus(int OperationId, int? PageNumber, int? PageSize, int? LeadStatusID, string LeadStatusName, bool? IsActive, int? UserId, string UserIp)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_LeadStatus"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationId", SqlDbType.Int).Value = OperationId;
                    cmd.Parameters.Add("@LeadStatusId", SqlDbType.Int).Value = LeadStatusID;
                    cmd.Parameters.Add("@LeadStatusName", SqlDbType.VarChar).Value = LeadStatusName;
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
                throw new Exception(string.Format("Error occured during Crud_Bank : {0}", ex.Message), ex);
            }
            return dt;
        }
    }
}
