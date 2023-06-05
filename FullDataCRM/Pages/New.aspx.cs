
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;


public partial class New : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblTimeError.Text = "";
            TextBoxStart.Text = Convert.ToDateTime(Request.QueryString["start"]).ToString("M/d/yyyy HH:mm");
            TextBoxEnd.Text = Convert.ToDateTime(Request.QueryString["end"]).ToString("M/d/yyyy HH:mm");
          //   BindTime();
           BindTimeToDDL();

            string[] arrFrom = TextBoxStart.Text.Split();
            string[] arrTo = TextBoxEnd.Text.Split();

            TextBoxStart.Text = arrFrom[0];
            TextBoxEnd.Text = arrTo[0];

            ddlTimeFrom.SelectedValue = arrFrom[1];
            ddlTimeTo.SelectedValue = arrTo[1];
        }
    }

    private void BindTime()
    {
        // Set the start time (00:00 means 12:00 AM)
     //   DateTime StartTime = DateTime.ParseExact("00:00", "HH:mm", null);
        // Set the end time (23:55 means 11:55 PM)
      //  DateTime EndTime = DateTime.ParseExact("23:55", "HH:mm", null);

        DateTime StartTime = DateTime.ParseExact("2009-05-08 00:00", "yyyy-MM-dd HH:mm", System.Globalization.CultureInfo.InvariantCulture);
        DateTime EndTime = DateTime.ParseExact("2009-05-08 23:55", "yyyy-MM-dd HH:mm", System.Globalization.CultureInfo.InvariantCulture);
        //Set 5 minutes interval
        TimeSpan Interval = new TimeSpan(0, 5, 0);
        //To set 1 hour interval
        //TimeSpan Interval = new TimeSpan(1, 0, 0);           
        ddlTimeFrom.Items.Clear();
        ddlTimeTo.Items.Clear();
        while (StartTime <= EndTime)
        {
            ddlTimeFrom.Items.Add(StartTime.ToShortTimeString());
            ddlTimeTo.Items.Add(StartTime.ToShortTimeString());
            StartTime = StartTime.Add(Interval);
        }
        ddlTimeFrom.Items.Insert(0, new ListItem("--Select--", "0"));
        ddlTimeTo.Items.Insert(0, new ListItem("--Select--", "0"));
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

    protected void ButtonOK_Click(object sender, EventArgs e)
    {
        if (System.TimeSpan.Parse(ddlTimeFrom.SelectedValue) >= System.TimeSpan.Parse(ddlTimeTo.SelectedValue))
        {
            lblTimeError.Text = "To Time Should be Greater than From Time";
            return;
        }

        DateTime start = Convert.ToDateTime(TextBoxStart.Text+" "+ddlTimeFrom.SelectedValue);
        DateTime end = Convert.ToDateTime(TextBoxEnd.Text + " " + ddlTimeTo.SelectedValue);

        dbInsertEvent(start, end, txtEventName.Text, txtDescription.Text);
        Modal.Close(this, "OK");
    }

    private void dbInsertEvent(DateTime start, DateTime end, string name, string description)
    {

        int UserId = Convert.ToInt32(Session["UserId"].ToString());
        string UserIP = Session["UserIp"].ToString();

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

    protected void ButtonCancel_Click(object sender, EventArgs e)
    {
        Modal.Close(this);
    }
}
