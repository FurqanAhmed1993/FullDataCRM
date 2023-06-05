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
    public class DAL_Event : DAL
    {

        public DataTable Crud_Event(int OperationId, int? PageNumber, int? PageSize, int? EventId, int? NotificationId , DateTime? EventStartDate, 
            DateTime? EventEndDate, string Name,  string Description, bool? IsActive , int? UserId , string UserIp)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_Calendar_Event"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationTypeId", SqlDbType.Int).Value = OperationId;
                    cmd.Parameters.Add("@CalendarEventId", SqlDbType.Int).Value = EventId;
                    cmd.Parameters.Add("@NotificationId", SqlDbType.Int).Value = NotificationId;
                    cmd.Parameters.Add("@EventStartDate", SqlDbType.DateTime).Value = EventStartDate;
                    cmd.Parameters.Add("@EventEndDate", SqlDbType.DateTime).Value = EventEndDate;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = Name;
                    cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = Description;
                    cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = IsActive;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIp;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = UserId;
                    cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = PageNumber;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = PageSize;
                    dt = GetData(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during Crud_Event : {0}", ex.Message), ex);
            }
            return dt;
        }

    }
}
