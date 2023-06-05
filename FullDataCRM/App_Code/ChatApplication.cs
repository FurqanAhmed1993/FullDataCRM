using BAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using Utilities;

/// <summary>
/// Summary description for ChatApplication
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ChatApplication : System.Web.Services.WebService
{

    SqlCommand cmd;
    SqlDataAdapter sdr;
    DataTable selectedTable;

    [WebMethod]
    public string GetAllMessagesOnselecteduser(int ConnectedUserID, int ToUserID, string typemessage)
    {
        StartSqlDependency();

        DataSet ds = sp_chatbot(ToUserID, ConnectedUserID, "", typemessage, "GetAllMessagesOnselecteduser", "", "", 0, ToUserID, "");

        List<Dictionary<string, object>> ListRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                ListRow.Add(childRow);
            }
        }
        var json = jsSerializer.Serialize(ListRow);
        return json;
    }

    [WebMethod]
    public string GetAllMessagesOnselectedGroup(int ToUserID, int FromUserID, int GroupID, string typemessage)
    {
        StartSqlDependency();

        DataSet ds = sp_chatbot(ToUserID, FromUserID, "", typemessage, "GetAllMessagesOnselectedGroup", "", "", 0, GroupID, "");

        List<Dictionary<string, object>> ListRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                ListRow.Add(childRow);
            }
        }
        var json = jsSerializer.Serialize(ListRow);


        List<Dictionary<string, object>> ListRowallusers1 = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRowallusers1;
        JavaScriptSerializer jsSerializerallusers1 = new JavaScriptSerializer();
        if (ds.Tables[1].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[1].Rows)
            {
                childRowallusers1 = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[1].Columns)
                {
                    childRowallusers1.Add(col.ColumnName, row[col]);
                }
                ListRowallusers1.Add(childRowallusers1);
            }
        }
        var jsonallusers1 = jsSerializer.Serialize(ListRowallusers1);

        return json + "---" + jsonallusers1;
    }

    [WebMethod]
    public string CreateGroup(int GroupID, string GroupName, List<int> GroupMembers, int GroupCreatedBy, int GroupAdmin, int isActive)
    {
        DataSet ds = null;
        List<Group> Group = new List<Group>();
        DataTable dt_type = new DataTable();
        dt_type.Columns.Add("GroupID");
        dt_type.Columns.Add("GroupName");
        dt_type.Columns.Add("GroupMembers");
        dt_type.Columns.Add("GroupCreatedBy");
        dt_type.Columns.Add("GroupAdmin");
        dt_type.Columns.Add("GroupModifiedBy");
        dt_type.Columns.Add("isActive");
        dt_type.Rows.Clear();
        if (GroupAdmin != 1 && GroupAdmin != 0)
        {
            for (int i = 0; i < GroupMembers.Count; i++)
            {
                dt_type.Rows.Add(GroupID, GroupName, GroupMembers[i], GroupCreatedBy, GroupAdmin, 0, Convert.ToBoolean(isActive));
            }
            ds = sp_chatbot(0, 0, "", "", "CreateGroup", "", "", GroupCreatedBy, GroupID, GroupName, dt_type);
        }
        if (GroupAdmin == 1 || GroupAdmin == 0)
        {
            if (GroupAdmin == 1)
            {
                for (int i = 0; i < GroupMembers.Count; i++)
                {
                    dt_type.Rows.Add(GroupID, GroupName, GroupMembers[i], GroupCreatedBy, GroupMembers[i], 0, Convert.ToBoolean(isActive));
                }
            }
            else
            {
                for (int i = 0; i < GroupMembers.Count; i++)
                {
                    dt_type.Rows.Add(GroupID, GroupName, GroupMembers[i], GroupCreatedBy, GroupAdmin, 0, Convert.ToBoolean(isActive));
                }
            }
            ds = sp_chatbot(0, 0, "", "", "CreateGroup", "", "", GroupCreatedBy, GroupID, GroupName, dt_type);
        }

        List<Dictionary<string, object>> ListRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                ListRow.Add(childRow);
            }
        }
        var json = jsSerializer.Serialize(ListRow);
        return json;
    }
    [WebMethod]
    public string DeleteGroup(int GroupID, string GroupName, int GroupMembers)
    {
        DataSet ds = sp_chatbot(0, GroupMembers, "", "", "DeleteGroup", "", "", 0, GroupID, GroupName);
        List<Dictionary<string, object>> ListRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                ListRow.Add(childRow);
            }
        }
        var json = jsSerializer.Serialize(ListRow);

        List<Dictionary<string, object>> ListRowallusers = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRowallusers;
        JavaScriptSerializer jsSerializerallusers = new JavaScriptSerializer();
        if (ds.Tables[1].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[1].Rows)
            {
                childRowallusers = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[1].Columns)
                {
                    childRowallusers.Add(col.ColumnName, row[col]);
                }
                ListRowallusers.Add(childRowallusers);
            }
        }
        var jsonallusers = jsSerializer.Serialize(ListRowallusers);

        List<Dictionary<string, object>> ListRowallusers1 = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRowallusers1;
        JavaScriptSerializer jsSerializerallusers1 = new JavaScriptSerializer();
        if (ds.Tables[2].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[2].Rows)
            {
                childRowallusers1 = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[2].Columns)
                {
                    childRowallusers1.Add(col.ColumnName, row[col]);
                }
                ListRowallusers1.Add(childRowallusers1);
            }
        }
        var jsonallusers1 = jsSerializer.Serialize(ListRowallusers1);

        return json + "---" + jsonallusers + "---" + jsonallusers1;
    }

    [WebMethod]
    public string GetAllMembersofGroup(int GroupID, int CurrentUser)
    {
        StartSqlDependency();

        DataSet ds = sp_chatbot(0, CurrentUser, "", "", "GetAllMembersofGroup", "", "", 0, GroupID, "");

        List<Dictionary<string, object>> ListRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                ListRow.Add(childRow);
            }
        }
        var json = jsSerializer.Serialize(ListRow);

        List<Dictionary<string, object>> ListRowallusers = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRowallusers;
        JavaScriptSerializer jsSerializerallusers = new JavaScriptSerializer();
        if (ds.Tables[1].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[1].Rows)
            {
                childRowallusers = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[1].Columns)
                {
                    childRowallusers.Add(col.ColumnName, row[col]);
                }
                ListRowallusers.Add(childRowallusers);
            }
        }
        var jsonallusers = jsSerializer.Serialize(ListRowallusers);



        return json + "---" + jsonallusers;
    }

    [WebMethod]
    public string GetAdmiin(int GroupID, int CurrentUser)
    {
        StartSqlDependency();

        DataSet ds = sp_chatbot(0, CurrentUser, "", "", "GetAdmiin", "", "", 0, GroupID, "");

        List<Dictionary<string, object>> ListRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                ListRow.Add(childRow);
            }
        }
        var json = jsSerializer.Serialize(ListRow);

        return json;
    }
    public DataSet sp_chatbot(int touserid, int fromuserid, string chatmessage, string messagetype, string action, string chatdatetime = "", string file_path = "", int GroupCreatedby = 0, int GroupID = 0, string GroupName = "", DataTable tbl_chat_messages_group = null)
    {
        DataSet ds = new BAL_Chat().chatbotGroup(touserid, fromuserid, chatmessage, messagetype, action, chatdatetime, file_path, GroupCreatedby, GroupID, GroupName, tbl_chat_messages_group);
        return ds;
    }

    private void StartSqlDependency()
    {
        SqlDependency dependency;
        string dbConnectionString = ConfigurationManager.ConnectionStrings[GenericConstants.ConnectionStringKey].ConnectionString;
        using (SqlConnection con = new SqlConnection(dbConnectionString))
        {
            string sqlCommand = @"Select [Chat_ID],[To_User_ID],[From_User_ID],[Chat_Messages],[Chat_DateTime],[typemessage],[file_path],[GroupUserID],[GroupID],[GroupName] From [dbo].[tbl_chat_messages]";
            cmd = new SqlCommand(sqlCommand, con);

            cmd.Notification = null;
            dependency = new SqlDependency(cmd);
            dependency.OnChange += new OnChangeEventHandler(dependency_OnChange);

            if (con.State != ConnectionState.Open)
                con.Open();
            cmd.ExecuteReader().Dispose();
        }
    }
    private void dependency_OnChange(object sender, SqlNotificationEventArgs e)
    {
        if (e.Type == SqlNotificationType.Change)
        {
            ChatHub.Show();
        }
    }
}
