<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="EventCalender.aspx.cs" Inherits="Pages_EventCalender" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js'></script>
    <script type="text/javascript">

        var EventId = 0;
        var NotificationId = 0;

        document.addEventListener('DOMContentLoaded', function () {
            var AllEvents = [];

            $.ajax({
                type: "POST",
                url: "EventCalender.aspx/GetAllData",
                data: JSON.stringify({ start: null, end: null }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var result = jQuery.parseJSON(msg.d);
                    debugger
                    if (result.includes("Error")) {
                        $("#event-modal").modal("show");
                    }
                    else {
                        result.forEach(x => {
                            AllEvents.push({
                                EventDetails: x,
                                title: x.Name,
                                start: x.EventStart,
                                end: x.EventEnd
                            })
                        })

                        var calendarEl = document.getElementById('calendar');

                        var today = new Date();
                        var dd = today.getDate();

                        var mm = today.getMonth() + 1;
                        var yyyy = today.getFullYear();
                        if (dd < 10) {
                            dd = '0' + dd;
                        }

                        if (mm < 10) {
                            mm = '0' + mm;
                        }
                        today = yyyy + '-' + mm + '-' + dd;

                        var calendar = new FullCalendar.Calendar(calendarEl, {

                            headerToolbar: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'dayGridMonth,timeGridWeek,timeGridDay'
                            },
                            initialView: 'timeGridDay',
                            initialDate: today,
                            navLinks: true, // can click day/week names to navigate views
                            selectable: true,
                            selectMirror: true,
                            select: function (arg) {
                                //var title = prompt('Event Title:');
                                debugger
                                $("#DeleteBtn").hide();
                               /* document.getElementById('DeleteBtn').style.display = 'none';*/
                                document.getElementById("lblHeading").innerText = "Add New Event";
                                EventId = 0;
                                NotificationId = 0;
                                $("#event-modal").modal("show");
                                document.getElementById("ContentPlaceHolder1_txtEventName").value = "";
                                document.getElementById("ContentPlaceHolder1_txtDescription").value = "";

                                var day, hours, minutes, seconds;
                                var Start_date = new Date(arg.start),
                                    Start_mnth = ("0" + (Start_date.getMonth() + 1)).slice(-2),
                                    Start_day = ("0" + Start_date.getDate()).slice(-2);
                                Start_hours = ("0" + Start_date.getHours()).slice(-2);
                                Start_minutes = ("0" + Start_date.getMinutes()).slice(-2);

                                var End_date = new Date(arg.end),
                                    End_mnth = ("0" + (End_date.getMonth() + 1)).slice(-2),
                                    End_day = ("0" + End_date.getDate()).slice(-2);
                                End_hours = ("0" + End_date.getHours()).slice(-2);
                                End_minutes = ("0" + End_date.getMinutes()).slice(-2);

                                var StartDate = [Start_date.getFullYear(), Start_mnth, Start_day].join("-");
                                var EndDate = [End_date.getFullYear(), End_mnth, End_day].join("-");

                                document.getElementById("ContentPlaceHolder1_TextBoxStart").value = StartDate;
                                document.getElementById("ContentPlaceHolder1_TextBoxEnd").value = EndDate;

                                var StartTime = [Start_hours, Start_minutes].join(":");
                                var EndTime = [End_hours, End_minutes].join(":");

                                var TimeStart = document.getElementById("ContentPlaceHolder1_ddlTimeFrom");
                                for (var i = 0; i < TimeStart.options.length; i++) {
                                    if (TimeStart.options[i].value == StartTime) {
                                        TimeStart.options[i].selected = true;
                                        isFound = true;
                                    }
                                }
                                var TimeEnd = document.getElementById("ContentPlaceHolder1_ddlTimeTo");
                                for (var i = 0; i < TimeEnd.options.length; i++) {
                                    if (TimeEnd.options[i].value == EndTime) {
                                        TimeEnd.options[i].selected = true;
                                        isFound = true;
                                    }
                                }
                                calendar.unselect()
                            },
                            eventClick: function (arg) {
                                debugger
                                $("#DeleteBtn").show();
                               /* document.getElementById('DeleteBtn').style.display = 'block';*/
                                EventId = arg.event._def.extendedProps.EventDetails.CalendarEventId;
                                NotificationId = arg.event._def.extendedProps.EventDetails.NotificationId;
                                var EvantName = arg.event._def.extendedProps.EventDetails.Name;
                                var Description = arg.event._def.extendedProps.EventDetails.Description;
                                let arrEventStart = arg.event._def.extendedProps.EventDetails.EventStart.split('T');
                                let arrEventEnd = arg.event._def.extendedProps.EventDetails.EventEnd.split('T');

                                document.getElementById("ContentPlaceHolder1_txtEventName").value = EvantName;
                                document.getElementById("ContentPlaceHolder1_txtDescription").value = Description;
                                document.getElementById("ContentPlaceHolder1_TextBoxStart").value = arrEventStart[0];
                                document.getElementById("ContentPlaceHolder1_TextBoxEnd").value = arrEventEnd[0];

                                debugger
                                var TimeStart = document.getElementById("ContentPlaceHolder1_ddlTimeFrom");
                                for (var i = 0; i < TimeStart.options.length; i++) {
                                    if (TimeStart.options[i].value == arrEventStart[1].substring(0, 5)) {
                                        TimeStart.options[i].selected = true;
                                        isFound = true;
                                    }
                                }
                                var TimeEnd = document.getElementById("ContentPlaceHolder1_ddlTimeTo");
                                for (var i = 0; i < TimeEnd.options.length; i++) {
                                    if (TimeEnd.options[i].value == arrEventEnd[1].substring(0, 5)) {
                                        TimeEnd.options[i].selected = true;
                                        isFound = true;
                                    }
                                }
                                document.getElementById("lblHeading").innerText = "Edit Event";
                                $("#event-modal").modal("show");
                            },
                            editable: true,
                            dayMaxEvents: true, // allow "more" link when too many events
                            events: AllEvents
                        });

                        calendar.render();
                    }
                },
                error: function (msg) {
                    var result = jQuery.parseJSON(msg.d);
                    alert(result);
                    $("#event-modal").modal("show");
                }
            });

        });

        function AddEvent(val) {

            debugger;
            var EventName = document.getElementById("ContentPlaceHolder1_txtEventName").value;
            var Description = document.getElementById("ContentPlaceHolder1_txtDescription").value;
            var title = document.getElementById("ContentPlaceHolder1_txtEventName").value;
            var StartDate = document.getElementById("ContentPlaceHolder1_TextBoxStart").value;
            var EndDate = document.getElementById("ContentPlaceHolder1_TextBoxEnd").value
            var TimeFrom = document.getElementById("ContentPlaceHolder1_ddlTimeFrom").value;
            var TimeTo = document.getElementById("ContentPlaceHolder1_ddlTimeTo").value;

            if (EventName == "" || Description == "") {

                AlertBox("Warning", "Event Name and Description can not be empty", 'warning');
                return;
            }
            else if (StartDate == "" || EndDate == "") {
                AlertBox("Warning", "Please Select Event Dates", 'warning');
                return;
            }
            else if (TimeFrom == "0" || TimeTo == "0") {
                AlertBox("Warning", "Please Select Event Time", 'warning');
                return;
            }

            $.ajax({
                type: "POST",
                url: "EventCalender.aspx/Insert",
                data: JSON.stringify({ StartDate: StartDate, EndDate: EndDate, FromTime: TimeFrom, ToTime: TimeTo, EventName: EventName, Description: Description, EventId: EventId, NotificationId: NotificationId, OperationType: val }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    var result = jQuery.parseJSON(msg.d);
                    debugger
                    document.getElementById("ContentPlaceHolder1_txtEventName").value = "";
                    document.getElementById("ContentPlaceHolder1_txtDescription").value = "";

                    if (result.code == 400) {
                        AlertBox("Error", result.message, 'error');
                        $("#event-modal").modal("show");
                    }
                    else {

                        var Events = [];
                        var resultData = jQuery.parseJSON(result.data)
                        resultData.forEach(x => {
                            Events.push({
                                EventDetails: x,
                                title: x.Name,
                                start: x.EventStart,
                                end: x.EventEnd
                            })
                        })

                        var calendarEl = document.getElementById('calendar');

                        var calendar = new FullCalendar.Calendar(calendarEl, {
                            headerToolbar: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'dayGridMonth,timeGridWeek,timeGridDay'
                            },
                            initialView: 'timeGridDay',
                            initialDate: StartDate,
                            navLinks: true, // can click day/week names to navigate views
                            selectable: true,
                            select: function (arg) {
                                //var title = prompt('Event Title:');
                                debugger
                                $("#DeleteBtn").hide();
                               /* document.getElementById('DeleteBtn').style.display = 'none';*/
                                document.getElementById("lblHeading").innerText = "Add New Event";
                                EventId = 0;
                                NotificationId = 0;

                                $("#event-modal").modal("show");

                                var day, hours, minutes, seconds;

                                var Start_date = new Date(arg.start),
                                    Start_mnth = ("0" + (Start_date.getMonth() + 1)).slice(-2),
                                    Start_day = ("0" + Start_date.getDate()).slice(-2);
                                Start_hours = ("0" + Start_date.getHours()).slice(-2);
                                Start_minutes = ("0" + Start_date.getMinutes()).slice(-2);

                                var End_date = new Date(arg.end),
                                    End_mnth = ("0" + (End_date.getMonth() + 1)).slice(-2),
                                    End_day = ("0" + End_date.getDate()).slice(-2);
                                End_hours = ("0" + End_date.getHours()).slice(-2);
                                End_minutes = ("0" + End_date.getMinutes()).slice(-2);

                                var StartDate = [Start_date.getFullYear(), Start_mnth, Start_day].join("-");
                                var EndDate = [End_date.getFullYear(), End_mnth, End_day].join("-");

                                document.getElementById("ContentPlaceHolder1_TextBoxStart").value = StartDate;
                                document.getElementById("ContentPlaceHolder1_TextBoxEnd").value = EndDate;

                                document.getElementById("ContentPlaceHolder1_txtEventName").value = "";
                                document.getElementById("ContentPlaceHolder1_txtDescription").value = "";

                                var StartTime = [Start_hours, Start_minutes].join(":");
                                var EndTime = [End_hours, End_minutes].join(":");

                                var TimeStart = document.getElementById("ContentPlaceHolder1_ddlTimeFrom");
                                for (var i = 0; i < TimeStart.options.length; i++) {
                                    if (TimeStart.options[i].value == StartTime) {
                                        TimeStart.options[i].selected = true;
                                        isFound = true;
                                    }
                                }

                                var TimeEnd = document.getElementById("ContentPlaceHolder1_ddlTimeTo");
                                for (var i = 0; i < TimeEnd.options.length; i++) {
                                    if (TimeEnd.options[i].value == EndTime) {
                                        TimeEnd.options[i].selected = true;
                                        isFound = true;
                                    }
                                }

                                calendar.unselect()
                            },
                            selectMirror: true,
                            eventClick: function (arg) {
                                debugger
                                $("#DeleteBtn").show();
                               /* document.getElementById('DeleteBtn').style.display = 'block';*/
                                EventId = arg.event._def.extendedProps.EventDetails.CalendarEventId;
                                NotificationId = arg.event._def.extendedProps.EventDetails.NotificationId;
                                var EvantName = arg.event._def.extendedProps.EventDetails.Name;
                                var Description = arg.event._def.extendedProps.EventDetails.Description;
                                let arrEventStart = arg.event._def.extendedProps.EventDetails.EventStart.split('T');
                                let arrEventEnd = arg.event._def.extendedProps.EventDetails.EventEnd.split('T');

                                document.getElementById("ContentPlaceHolder1_txtEventName").value = EvantName;
                                document.getElementById("ContentPlaceHolder1_txtDescription").value = Description;
                                document.getElementById("ContentPlaceHolder1_TextBoxStart").value = arrEventStart[0];
                                document.getElementById("ContentPlaceHolder1_TextBoxEnd").value = arrEventEnd[0];

                                debugger
                                var TimeStart = document.getElementById("ContentPlaceHolder1_ddlTimeFrom");
                                for (var i = 0; i < TimeStart.options.length; i++) {
                                    if (TimeStart.options[i].value == arrEventStart[1].substring(0, 5)) {
                                        TimeStart.options[i].selected = true;
                                        isFound = true;
                                    }
                                }

                                var TimeEnd = document.getElementById("ContentPlaceHolder1_ddlTimeTo");
                                for (var i = 0; i < TimeEnd.options.length; i++) {
                                    if (TimeEnd.options[i].value == arrEventEnd[1].substring(0, 5)) {
                                        TimeEnd.options[i].selected = true;
                                        isFound = true;
                                    }
                                }


                                //if (confirm('Are you sure you want to delete this event?')) {
                                //    arg.event.remove()
                                //}
                                document.getElementById("lblHeading").innerText = "Edit Event";
                                $("#event-modal").modal("show");
                            },
                            editable: true,
                            dayMaxEvents: true,
                            events: Events
                        })

                        if (result.code == 204)
                            AlertBox("Event Deleted!", result.message, 'error');
                        else if (result.code == 202)
                            AlertBox("Event Updated!", result.message, 'success');
                        if (result.code == 200)
                            AlertBox("Event Added!", result.message, 'success');

                        calendar.render();
                        $("#event-modal").modal("hide");
                    }
                },
                error: function (msg) {
                    var result = jQuery.parseJSON(msg.d);
                    alert(result);
                    $("#event-modal").modal("show");
                }
            });
        }

        function AlertBox(title, Message, type) {
            swal(title, Message, type);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id='calendar'></div>

    <div class="modal fade" id="event-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <asp:Label class="modal-title" ID="lblHeading">Add New Event</asp:Label>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label>Event Start Date</label><span class="MandatoryValue">* </span>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="TextBoxStart" Text="*" ValidationGroup="Add" ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:TextBox ID="TextBoxStart" CssClass="form-control date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label>Event Start Time</label><span class="MandatoryValue">* </span>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlTimeFrom" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlTimeFrom" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="ddlTimeFrom" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label>Event End Date</label><span class="MandatoryValue">* </span>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="TextBoxEnd" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="TextBoxEnd" CssClass="form-control date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label>Event End Time</label><span class="MandatoryValue">* </span>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="ddlTimeTo" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="ddlTimeTo" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="ddlTimeTo" CssClass="form-control" runat="server"></asp:DropDownList><asp:Label ID="lblTimeError" runat="server" Style="color: red"></asp:Label>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <label>Event Name</label><span class="MandatoryValue">* </span>
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtEventName" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br>
                        <asp:TextBox ID="txtEventName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Description</label><span class="MandatoryValue">* </span>
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtDescription" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="6" Columns="40" />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-primary" value="Save" id="saveBtn" onclick="AddEvent('Insert_Update')" />
                    
                    <%--<asp:Button ID="ButtonOK" runat="server" CssClass="btn btn-primary" Text="OK" ValidationGroup="Add" />--%>
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Close"></input>
                    <input type="button" class="btn btn-danger btn-sm" value="Delete" id="DeleteBtn" onclick="AddEvent('delete')" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <script type="text/javascript">
        function pageLoad() {

            $(".date").mask("9999-99-99");

            $('.date').datepicker({
                forceParse: false,
                calendarWeeks: true,
                autoclose: true,
                format: 'yyyy-mm-dd',
            });
        }

    </script>

</asp:Content>

