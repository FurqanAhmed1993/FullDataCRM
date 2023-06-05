using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;
using System.Web.Services;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

public partial class Pages_EventCalender : Base
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["UserId"] = UserId;
            Session["UserIp"] = UserIP;
            BindTimeToDDL();
          //  GetData();
        }
    }

    [WebMethod]
    public static string Insert(string StartDate, string EndDate , string FromTime, string ToTime , string EventName ,  string Description , int EventId, int NotificationId , string OperationType)
    {
        try
        {
 
            string msg = "";
            var json = "";
            ResultResponse resultResponse = new ResultResponse();

            DateTime start = Convert.ToDateTime(StartDate + " " + FromTime);
            DateTime end = Convert.ToDateTime(EndDate + " " + ToTime);

            if (start >= end)
            {
                resultResponse.code = 400;
                resultResponse.message = "Error ! To Time should be greater than From Time";
                resultResponse.data = null;
                //msg = "Error ! To Time should be greater than From Time";
                json = JsonConvert.SerializeObject(resultResponse);
                return json;
            }

            int UserId = Convert.ToInt32(HttpContext.Current.Session["UserId"].ToString());
            string UserIP = HttpContext.Current.Session["UserIp"].ToString();

            if (EventId == 0)
            {
                int NotificationType = 11;
                DataTable dtNotification = new BAL_Notifications().Notification_Crud((int)OperationTypes.Insert, 1, 100, UserId,
               UserIP, null, EventName, NotificationType,
               Description, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"), Convert.ToDateTime(start.Date));

                if (dtNotification != null && dtNotification.Rows.Count > 0)
                {
                    if (dtNotification.Rows[0]["HasError"].ToString() == "1")
                    {
                    }
                    else if (dtNotification.Rows[0]["HasError"].ToString() == "0")
                    {
                        int NotificationID = Convert.ToInt32(dtNotification.Rows[0]["LastNotificationId"].ToString());
                        DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Insert
                                       , 1, 50, null, NotificationID, start, end, EventName, Description, true, UserId, UserIP);

                        resultResponse.code = 200;
                        resultResponse.message = "Event Added Successfully";
                       
                    }
                }
            }

            else
            {
                int OperationTypeId = (int)OperationTypes.Update;
                if (OperationType == "delete")
                {
                    OperationTypeId = (int)OperationTypes.Delete;
                    resultResponse.code = 204;
                    resultResponse.message = "Event Deleted Successfully";
                   
                }
                else
                {
                    resultResponse.code = 202;
                    resultResponse.message = "Event Updated Successfully";
                   
                }

                int NotificationType = 11;
                DataTable dtNotification = new BAL_Notifications().Notification_Crud(OperationTypeId, 1, 100, UserId,
               UserIP, NotificationId, EventName, NotificationType,
               Description, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"), Convert.ToDateTime(start.Date));

                if (dtNotification != null && dtNotification.Rows.Count > 0)
                {
                    if (dtNotification.Rows[0]["HasError"].ToString() == "1")
                    {
                    }
                    else if (dtNotification.Rows[0]["HasError"].ToString() == "0")
                    {
                       
                        DataTable dt = new BAL_Event().Event_Crud(OperationTypeId
                                       , 1, 50, EventId, NotificationId, start, end, EventName, Description, true, UserId, UserIP);
                    }
                }
            }

            DataTable dtFinalData = GetData(null, null);
            json = JsonConvert.SerializeObject(dtFinalData);
            //resultResponse.code = 200;
            //resultResponse.message = "Success";
            resultResponse.data = json;
            return JsonConvert.SerializeObject(resultResponse);

        }

        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    private void dbInsertEvent(DateTime start, DateTime end, string name, string description)
    {

        int NotificationType = 11;
        DataTable dtNotification = new BAL_Notifications().Notification_Crud((int)OperationTypes.Insert, 1, 100, UserId,
       UserIP, null, name, NotificationType,
       description, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"), Convert.ToDateTime(start.Date));

        if (dtNotification != null && dtNotification.Rows.Count > 0)
        {
            if (dtNotification.Rows[0]["HasError"].ToString() == "1")
            {
            }
            else if (dtNotification.Rows[0]["HasError"].ToString() == "0")
            {
                int NotificationId = Convert.ToInt32(dtNotification.Rows[0]["LastNotificationId"].ToString());
                DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Insert
                               , 1, 50, null, NotificationId, start, end, name, description, true, UserId, UserIP);
            }
        }

    }

    private static DataTable GetData(DateTime? start, DateTime? end)
    {
        DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Select, 1, 100, null, null, start, end);
        return dt;
    }

    [WebMethod]
    public static string GetAllData(DateTime? start, DateTime? end)
    {
        DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Select, 1, 100, null, null, start, end);
        string json = JsonConvert.SerializeObject(dt);
        return json;
    }


    public void BindTimeToDDL()
    {
        List<string> time24hr = new List<string>();
        DateTime myDate = DateTime.ParseExact("2009-05-08 00:00", "yyyy-MM-dd HH:mm", System.Globalization.CultureInfo.InvariantCulture);


        int min = 0;
        for (int i = 0; i <= 48; i++)
        {

            string strtime = FormatearHoraA24(myDate.AddMinutes(min));
            time24hr.Add(strtime);
            min = min + 30;
        }
        ddlTimeFrom.DataSource = time24hr.ToList();
        ddlTimeFrom.DataBind();

        ddlTimeTo.DataSource = time24hr.ToList();
        ddlTimeTo.DataBind();

        ddlTimeFrom.Items.Insert(0, new ListItem("-- Select From Time --", "0"));
        ddlTimeTo.Items.Insert(0, new ListItem("-- Select To Time --", "0"));
    }

    public static string FormatearHoraA24(DateTime fechaHora)
    {
        return fechaHora.ToString("HH:mm");
    }
}