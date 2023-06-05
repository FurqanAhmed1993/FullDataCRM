using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BAL
{
    public class BAL_Chat : DAL_Chat
    {
        DataSet ds = new DataSet();

        public DataSet chatbot(int touserid, int fromuserid, string chatmessage, string messagetype, string action, string chatdatetime = "", string file_path = "", int GroupCreatedby = 0, int GroupID = 0, string GroupName = "")
        {
            ds = sp_chatbot(touserid, fromuserid, chatmessage, messagetype, action, chatdatetime, file_path, GroupCreatedby, GroupID, GroupName);
            return ds;
        }

        public DataSet chatbotGroup(int touserid, int fromuserid, string chatmessage, string messagetype, string action, string chatdatetime = "", string file_path = "", int GroupCreatedby = 0, int GroupID = 0, string GroupName = "", DataTable tbl_chat_messages_group = null)
        {
            ds = sp_chatbotGroup(touserid, fromuserid, chatmessage, messagetype, action, chatdatetime, file_path, GroupCreatedby, GroupID, GroupName, tbl_chat_messages_group);
            return ds;
        }
    }
}
