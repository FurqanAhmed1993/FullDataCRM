using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DAL_Chat : DAL
    {
        public DataSet sp_chatbot (int touserid, int fromuserid, string chatmessage, string messagetype, string action, string chatdatetime = "", string file_path = "", int GroupCreatedby = 0, int GroupID = 0, string GroupName = "")
        {
            DataSet ds = new DataSet();

            try
            {
                using (SqlCommand cmd = new SqlCommand("sp_chatbot"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@touserid", SqlDbType.Int).Value = touserid;
                    cmd.Parameters.Add("@fromuserid", SqlDbType.Int).Value = fromuserid;
                    cmd.Parameters.Add("@chatmessage", SqlDbType.VarChar).Value = chatmessage;
                    cmd.Parameters.Add("@chatdatetime", SqlDbType.VarChar).Value = chatdatetime;
                    cmd.Parameters.Add("@messagetype", SqlDbType.VarChar).Value = messagetype;
                    cmd.Parameters.Add("@action", SqlDbType.VarChar).Value = action;
                    cmd.Parameters.Add("@file_path", SqlDbType.VarChar).Value = file_path;
                    cmd.Parameters.Add("@GroupCreatedby", SqlDbType.Int).Value = GroupCreatedby;
                    cmd.Parameters.Add("@GroupID", SqlDbType.Int).Value = GroupID;
                    cmd.Parameters.Add("@GroupName", SqlDbType.VarChar).Value = GroupName;
                    ds = GetDataSet(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during sp_chatbot : {0}", ex.Message), ex);
            }

            return ds;
        }

        public DataSet sp_chatbotGroup(int touserid, int fromuserid, string chatmessage, string messagetype, string action, string chatdatetime = "", string file_path = "", int GroupCreatedby = 0, int GroupID = 0, string GroupName = "", DataTable tbl_chat_messages_group = null)
        {
            DataSet ds = new DataSet();

            try
            {
                using (SqlCommand cmd = new SqlCommand("sp_chatbot"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@touserid", SqlDbType.Int).Value = touserid;
                    cmd.Parameters.Add("@fromuserid", SqlDbType.Int).Value = fromuserid;
                    cmd.Parameters.Add("@chatmessage", SqlDbType.VarChar).Value = chatmessage;
                    cmd.Parameters.Add("@chatdatetime", SqlDbType.VarChar).Value = chatdatetime;
                    cmd.Parameters.Add("@messagetype", SqlDbType.VarChar).Value = messagetype;
                    cmd.Parameters.Add("@action", SqlDbType.VarChar).Value = action;
                    cmd.Parameters.Add("@file_path", SqlDbType.VarChar).Value = file_path;
                    cmd.Parameters.Add("@GroupCreatedby", SqlDbType.Int).Value = GroupCreatedby;
                    cmd.Parameters.Add("@GroupID", SqlDbType.Int).Value = GroupID;
                    cmd.Parameters.Add("@GroupName", SqlDbType.VarChar).Value = GroupName;
                    cmd.Parameters.Add("@tbltype_tbl_chat_messages_group", SqlDbType.Structured).Value = tbl_chat_messages_group;
                    ds = GetDataSet(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during sp_chatbotgroup : {0}", ex.Message), ex);
            }

            return ds;
        }
    }
}
