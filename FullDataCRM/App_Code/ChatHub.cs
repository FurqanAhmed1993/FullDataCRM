using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using BAL;

public class ChatHub : Hub
{
	static List<Users> ConnectedUsers = new List<Users>();
	static List<AllUsers> AllGroupandUserlist = new List<AllUsers>();
	static List<Messages> CurrentMessage = new List<Messages>();

    public DataSet sp_chatbot(int touserid, int fromuserid, string chatmessage, string messagetype, string action, string chatdatetime = "", string file_path = "", int GroupCreatedby = 0, int GroupID = 0, string GroupName = "")
    {
        DataSet ds = new DataSet();
        try
        {
            ds = new BAL_Chat().chatbot(touserid, fromuserid, chatmessage, messagetype, action, chatdatetime, file_path, GroupCreatedby, GroupID, GroupName);
        }
        catch (Exception)
        {
            throw;
        }
        return ds;
    }
    public void Connect(int ConnectionUserId, string ConnectionUserName)
    {
        var id = Context.ConnectionId;
        string DepartmentName = "";

        if (ConnectedUsers.Count(x => x.ConnectionId == id) == 0)
        {
            DataSet ds = new DataSet();
            ds = sp_chatbot(0, ConnectionUserId, "", "", "Connect");
            AllGroupandUserlist.Clear();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                AllGroupandUserlist.Add(new AllUsers { ConnectionId = Convert.ToInt32(ds.Tables[0].Rows[i]["User_Code"]), UserName = ds.Tables[0].Rows[i]["Full_Name"].ToString(), DepartmentName = ds.Tables[0].Rows[i]["DepartmentName"].ToString() });
            }

            // send to caller
            Clients.Caller.onConnected(ConnectionUserId, ConnectionUserName, DepartmentName, AllGroupandUserlist);

            // send to all except caller client
            // Clients.AllExcept(ConnectionUserId).onNewUserConnected(ConnectionUserId, ConnectionUserName, AllGroupandUserlist, CurrentMessage, DateTime.Now);
        }
    }

    public void SendMessageToAll(int TO_UserID, int FROM_USER_ID, string CHAT_MESSAGE, string typemessage, string fileattchment)
    {
        // store messages in DB
        AddMessageinDB(TO_UserID, FROM_USER_ID, CHAT_MESSAGE, typemessage, fileattchment);

        // Broad cast message
        GetMsgfromDB(TO_UserID, FROM_USER_ID, CHAT_MESSAGE, typemessage, fileattchment);
    }

    private void AddMessageinDB(int TO_UserID, int FROM_USER_ID, string CHAT_MESSAGE, string typemessage, string filepath)
    {
        try
        {
            DataSet ds = sp_chatbot(TO_UserID, FROM_USER_ID, CHAT_MESSAGE, typemessage, "AddMessageinDB", "", filepath);
            if (ds.Tables[0].Rows[0][0].ToString() == "0")
            { }
        }
        catch (Exception)
        { }
    }

    public void GetMsgfromDB(int TO_UserID, int FROM_USER_ID, string CHAT_MESSAGE, string typemessage, string filepath)
    {


        DataSet ds = sp_chatbot(TO_UserID, FROM_USER_ID, CHAT_MESSAGE, typemessage, "GetMsgfromDB", "", filepath, 0, TO_UserID);
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            CurrentMessage.Add(new Messages
            {
                TO_UserID = Convert.ToInt32(ds.Tables[0].Rows[i]["To_User_ID"]),
                TO_USER_NAME = ds.Tables[0].Rows[i]["To_User_Name"].ToString(),
                FROM_USER_ID = Convert.ToInt32(ds.Tables[0].Rows[i]["From_User_ID"]),
                FROM_USER_NAME = ds.Tables[0].Rows[i]["From_User_Name"].ToString(),
                CHAT_MESSAGE = ds.Tables[0].Rows[i]["Chat_Messages"].ToString(),
                Time = ds.Tables[0].Rows[i]["Chat_DateTime"].ToString(),
                fileattchment = ds.Tables[0].Rows[i]["file_path"].ToString(),
                GroupID = Convert.ToInt32(ds.Tables[0].Rows[i]["GroupID"]),
                GroupName = ds.Tables[0].Rows[i]["GroupName"].ToString()
            });

            Clients.All.messageReceived(
                ds.Tables[0].Rows[i]["To_User_ID"].ToString(),
                ds.Tables[0].Rows[i]["To_User_Name"].ToString(),
                ds.Tables[0].Rows[i]["From_User_ID"].ToString(),
                ds.Tables[0].Rows[i]["From_User_Name"].ToString(),
                ds.Tables[0].Rows[i]["Chat_Messages"].ToString(),
                ds.Tables[0].Rows[i]["Chat_DateTime"].ToString(),
                ds.Tables[0].Rows[i]["typemessage"].ToString(),
                ds.Tables[0].Rows[i]["file_path"].ToString(),
                ds.Tables[0].Rows[i]["GroupID"].ToString(),
                ds.Tables[0].Rows[i]["GroupName"].ToString()
                );
        }
    }

    public override System.Threading.Tasks.Task OnDisconnected(bool stopCalled)
    {
        var item = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId);
        var id = Context.ConnectionId;

        if (stopCalled)
        {
            // Console.WriteLine(String.Format("Client {0} explicitly closed the connection.", Context.ConnectionId));
            Clients.All.onUserDisconnected("Explicitly closed the connection.", Context.ConnectionId);
        }
        else
        {
            // Console.WriteLine(String.Format("Client {0} timed out .", Context.ConnectionId));
            Clients.All.onUserDisconnected("Timed out .", Context.ConnectionId);
        }

        return base.OnDisconnected(stopCalled);
        //var item = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId);
        //if (item != null)
        //{
        //    ConnectedUsers.Remove(item);

        //    var id = Context.ConnectionId;
        //    Clients.All.onUserDisconnected(id, item.UserName);

        //}
        //return base.OnDisconnected(stopCalled);
    }

    public static void Show()
    {
        IHubContext context = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();
        context.Clients.All.displayStatus();
    }
}

public class Users
{
    public string ConnectionId { get; set; }
    public string UserName { get; set; }
    public string UserImage { get; set; }
    public string LoginTime { get; set; }
}

public class Group
{
    public int groupid { get; set; }
    public string groupname { get; set; }
    public int groupmembers { get; set; }
    public int groupcreatedby { get; set; }
    public int groupadmin { get; set; }
    public int groupmodifiedby { get; set; }
}
public class AllUsers
{
    public int ConnectionId { get; set; }
    public string UserName { get; set; }
    public string DepartmentName { get; set; }
    public string LoginTime { get; set; }
}
public class Messages
{
    public int TO_UserID { get; set; }
    public string TO_USER_NAME { get; set; }
    public int FROM_USER_ID { get; set; }
    public string FROM_USER_NAME { get; set; }
    public string CHAT_MESSAGE { get; set; }
    public string Time { get; set; }
    public string fileattchment { get; set; }
    public int GroupCreatedBy { get; set; }
    public int GroupID { get; set; }
    public string GroupName { get; set; }
}