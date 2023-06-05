<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="NotificationsCalender.aspx.cs" Inherits="Pages_NotificationsCalender" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="../Scripts/modal.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
    <link href="../Assets/dist/css/main.css" type="text/css" rel="stylesheet" />
    <link href="../Themes/calendar_white.css" type="text/css" rel="stylesheet" />
    <link href="../Themes/scheduler_white.css" type="text/css" rel="stylesheet" />
    <link href="../Themes/month_white.css" type="text/css" rel="stylesheet" />
    <link href="../Themes/navigator_white.css" type="text/css" rel="stylesheet" />
    <link href="/Assets/dist/css/style.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

   <style type="text/css">
    #toolbar 
    {
    	margin-bottom: 10px;
    }
    
    #toolbar a 
    {
    	display: inline-block;
    	height: 20px;
    	text-decoration: none;
    	padding: 12px 10px;
        color: #fff;
        font-size: 12px;
        border: 1px solid #1a7cc3;
        line-height: 0.2;
	    background: #1a7cc3;
	    filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr="#fafafa", endColorStr="#e2e2e2");    	
    }

   .loaded .null{
        top: 200px !important;
        height: auto !important;
        z-index: 999 !important;
    } 

</style>

      <div class="row heading-bg">
         <div class="col-lg-12 col-md-12 col-sm-12">
              <h5 class="txt-dark">Notifications Calendar</h5>
          </div>
      </div>
  <div class="panel panel-default border-panel card-view">
    <div class="panel-body"> 
    <div style="float:left; width: 220px">
<%--<DayPilot:DayPilotNavigator 
            ID="DayPilotNavigator1"
            runat="server" 
            ShowMonths="3"
            SkiptMonth="3"
            ClientObjectName="dp_navigator"
        />--%>

    <DayPilot:DayPilotNavigator 
  ID="DayPilotNavigator1"
  runat="server" 
  ClientObjectName="dp_navigator"
/>

</div>
<div id="tabs" style="margin-left:220px">
    <div id="toolbar">
    <a href="#" id="toolbar_day">Day</a>
    <a href="#" id="toolbar_week">Week</a>
    <a href="#" id="toolbar_month">Month</a>
    </div>

    <div>
        <DayPilot:DayPilotCalendar 
        ID="DayPilotCalendarDay" 
        runat="server" 
        DataEndField="eventend"
        DataStartField="eventstart" 
        DataTextField="name" 
        DataIdField="CalendarEventId" 
        ViewType="Day"
        ClientObjectName="dp_day"
        OnCommand="DayPilotCalendarDay_Command"
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="create(start, end);"
        EventClickHandling="JavaScript"
        EventClickJavaScript="edit(e.id())"
        />

        <DayPilot:DayPilotCalendar 
        ID="DayPilotCalendarWeek" 
        runat="server" 
        DataEndField="eventend"
        DataStartField="eventstart" 
        DataTextField="name" 
        DataIdField="CalendarEventId" 
        ViewType="Week"
        ClientObjectName="dp_week"
        OnCommand="DayPilotCalendarWeek_Command"
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="create(start, end);"
        EventClickHandling="JavaScript"
        EventClickJavaScript="edit(e.id())"
        />

    <DayPilot:DayPilotMonth 
        ID="DayPilotMonth1" 
        runat="server" 
        DataEndField="eventend"
        DataStartField="eventstart" 
        DataTextField="name" 
        DataIdField="CalendarEventId" 
        ClientObjectName="dp_month"
        EventHeight="25"
        OnCommand="DayPilotMonth1_Command"
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="create(start, end);"
        EventClickHandling="JavaScript"
        EventClickJavaScript="edit(e.id())"
        />
    </div>
</div>
   </div>
        </div> 

<script type="text/javascript">
    var switcher = null;

    function edit(id) {
        var modal = new DayPilot.Modal();
        modal.closed = function () {
            if (this.result == "OK") {
                switcher.active.control.commandCallBack('refresh');
            }
        };
        modal.showUrl("Edit.aspx?id=" + id);
    }

    function create(start, end) {
        var modal = new DayPilot.Modal();
        modal.closed = function () {
            if (this.result == "OK") {
                switcher.active.control.commandCallBack('refresh');
            }
            switcher.active.control.clearSelection();
        };
        modal.showUrl("New.aspx?start=" + start + "&end=" + end);
    }

    $(document).ready(function () {
        switcher = new DayPilot.Switcher();

        switcher.addButton("toolbar_day", dp_day);
        switcher.addButton("toolbar_week", dp_week);
        switcher.addButton("toolbar_month", dp_month);

        switcher.addNavigator(dp_navigator);

        switcher.show(dp_day);
    });

</script>

</asp:Content>

