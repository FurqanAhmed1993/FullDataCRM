using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using Utilities;
using System.Data;


public partial class Edit : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
        {
            DataRow dr = dbGetEvent(Request.QueryString["id"]);

            if (dr == null)
            {
                throw new Exception("The event was not found");
            }

            TextBoxStart.Text = Convert.ToDateTime(dr["EventStart"]).ToString("M/d/yyyy HH:mm");
            TextBoxEnd.Text = Convert.ToDateTime(dr["EventEnd"]).ToString("M/d/yyyy HH:mm");
            TextBoxName.Text = (string)dr["Name"];
            txtDescription.Text = (string)dr["Description"];
            ViewState["NotificationID"] = (int)dr["NotificationId"];

            BindTimeToDDL();

            string[] arrFrom = TextBoxStart.Text.Split();
            string[] arrTo = TextBoxEnd.Text.Split();
            TextBoxStart.Text = arrFrom[0];
            TextBoxEnd.Text = arrTo[0];

            ddlTimeFrom.SelectedValue = arrFrom[1];
            ddlTimeTo.SelectedValue = arrTo[1];

            DateTime EndDate = Convert.ToDateTime(dr["EventEnd"]);
            DateTime CurrentDate = DateTime.Now;

            int result = DateTime.Compare(EndDate.Date, CurrentDate.Date);

            if (result == -1)
            {
                LinkButtonDelete.Enabled = false;
            }
        }
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

        DateTime start = Convert.ToDateTime(TextBoxStart.Text + " " + ddlTimeFrom.SelectedValue);
        DateTime end = Convert.ToDateTime(TextBoxEnd.Text + " " + ddlTimeTo.SelectedValue);
        string name = TextBoxName.Text;
        string id = Request.QueryString["id"];
        string Description = txtDescription.Text;
        int NotificationId = Convert.ToInt32(ViewState["NotificationID"].ToString());

        dbUpdateEvent(id, start, end, name, Description, NotificationId);
        Modal.Close(this, "OK");
    }

    private DataRow dbGetEvent(string id)
    {
        //SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM [event] WHERE id = @id", ConfigurationManager.ConnectionStrings["daypilot"].ConnectionString);
        //da.SelectCommand.Parameters.AddWithValue("id", id);
        //DataTable dt = new DataTable();
        //da.Fill(dt);

        //if (dt.Rows.Count > 0)
        //{
        //    return dt.Rows[0];
        //}

        DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Select, 1, 50, Convert.ToInt32(id));
        if (dt.Rows.Count > 0)
        {
            return dt.Rows[0];
        }

        return null;
    }

    private void dbUpdateEvent(string id, DateTime start, DateTime end, string name, string description, int NotificationId)
    {

        int UserId = Convert.ToInt32(Session["UserId"].ToString());
        string UserIP = Session["UserIp"].ToString();

        DataTable dtNotification = new BAL_Notifications().Notification_Crud((int)OperationTypes.Update, 1, 100, UserId,
    UserIP, NotificationId, name, 11, description, DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"), Convert.ToDateTime(start.Date));

        if (dtNotification != null && dtNotification.Rows.Count > 0)
        {
            if (dtNotification.Rows[0]["HasError"].ToString() == "1")
            {
            }
            else if (dtNotification.Rows[0]["HasError"].ToString() == "0")
            {
                DataTable dt1 = new BAL_Event().Event_Crud((int)OperationTypes.Update
                              , 1, 50, Convert.ToInt32(id), null, start, end, name, description, true, UserId, UserIP);
            }
        }


        DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Update
                             , 1, 50, Convert.ToInt32(id), null, start, end, name, description, true, UserId, UserIP);
    }

    private void dbDeleteEvent(string id)
    {

        DataTable dt = new BAL_Event().Event_Crud((int)OperationTypes.Delete
                            , 1, 50, Convert.ToInt32(id));
    }

    protected void ButtonCancel_Click(object sender, EventArgs e)
    {
        Modal.Close(this);
    }
    protected void LinkButtonDelete_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];
        dbDeleteEvent(id);
        Modal.Close(this, "OK");
    }
}
