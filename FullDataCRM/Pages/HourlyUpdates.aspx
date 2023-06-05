<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="HourlyUpdates.aspx.cs" Inherits="Pages_HourlyUpdates" %>

<%@ Register Src="~/CustomControls/Shared/InProgress.ascx" TagPrefix="uc" TagName="InProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
        <ProgressTemplate>
            <uc:InProgress runat="server" ID="InProgress" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <%-- <div class="row heading-bg">
        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
            <h5 class="txt-dark"></h5>
        </div>
    </div>--%>
    <asp:UpdatePanel ID="upData" runat="server">
        <ContentTemplate>
            <input type="hidden" runat="server" id="IsAdd" value="0" />
            <input type="hidden" runat="server" id="IsView" value="0" />
            <input type="hidden" runat="server" id="IsEdit" value="0" />
            <input type="hidden" runat="server" id="IsDelete" value="0" />
            <input type="hidden" runat="server" id="hfTabNoActive" value="1" class="hfTabNoActive" />
            <div id="orderdetailp">
                <div class="panel panel-default card-view">
                    <div class="panel-wrapper collapse in">
                        <div class="panel-heading">
                            <h5 class="txt-light">Hourly Update / Break</h5>
                            <div runat="server" id="Div_ToggleButton">
                                <a href="#" id="show" style="color: white; float: right; margin-top: -20px"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="panel-body Div_Search">
                            <div class="row">

                                <div class="col-md-2 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">From Date</label>
                                        <asp:TextBox ID="txtFromDate" runat="server" oncut="return false" oncopy="return false" onpast="return false" CssClass="form-control datetime txtFromDateSearch" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-2 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">To Date</label>
                                        <asp:TextBox ID="txtToDate" runat="server" oncut="return false" oncopy="return false" onpast="return false" CssClass="form-control datetime txtToDateSearch" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-2 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">Company</label>
                                        <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-2 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">User</label>
                                        <asp:DropDownList runat="server" ID="ddlUser" CssClass="form-control select2"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-12" style="margin-top: 10px">
                                    <div class="button-list text-right">
                                        <asp:Button ID="btnSearch" CssClass="btn btn-success btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnCancel" CssClass="btn btn-default" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="tabs1" class="col-lg-12">
                    <ul class=" parent nav nav-pills ul1" id="tabs" style="background-color: rgba(26, 179, 148, 0.08);">
                        <li id="li1" class="liSecA active"><a href="#tabs-1" data-toggle="tab">Hourly Update</a></li>
                        <li id="li2" class="liSecB  "><a href="#tabs-2" data-toggle="tab">Break</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tabs-1" class="liSecA tab-pane active">

                            <div class="col-md-12 col-sm-12">
                                <div class="text-right">
                                    <asp:Button ID="Btn_Add" runat="server" Text="Add my update" CssClass="btn btn-success Btn_Add" OnClick="Btn_Add_Click" />
                                </div>
                            </div>

                            <asp:DataList ID="DLIST_Parent" runat="server" Width="100%" OnItemDataBound="DLIST_ItemDataBound">
                                <ItemTemplate>
                                    <div class="col-lg-12 heading-div">
                                        <input type="hidden" runat="server" id="hfDate" class="hfDate" value='<%# Eval("Date") %>' />
                                        <%# Convert.ToString(Eval("Date")) == "" ? "" :  Convert.ToDateTime(Eval("Date")).ToString(Utilities.GenericConstants.DateTimeFormat2) %>
                                    </div>
                                    <div class="col-lg-12 ">
                                        <asp:DataList ID="DLIST_Child" runat="server" Width="100%">
                                            <ItemTemplate>
                                                <div class="timeline-centered">
                                                    <article class="timeline-entry">
                                                        <div class="timeline-entry-inner">
                                                            <time class="timeline-time" datetime="2014-01-10T03:45">
                                                                <span><%# Eval("TimeInterval") %></span>
                                                            </time>
                                                            <div class="timeline-icon bg-secondary">
                                                                <i class="entypo-feather"></i>
                                                            </div>

                                                            <div class="timeline-label">
                                                                <p style="white-space: pre-line;">
                                                                    <%# Eval("Description") %>
                                                                </p>
                                                                <h4 class="d-flex"><span><%# Eval("Name") %></span>
                                                                    <span><%# Convert.ToString(Eval("CreatedDate")) == "" ? "" :  Convert.ToDateTime(Eval("CreatedDate")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %></span>
                                                                </h4>
                                                            </div>
                                                        </div>
                                                    </article>
                                                </div>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div id="tabs-2" class="liSecB tab-pane">
                            <div class="panel panel-default border-panel card-view">
                                <div class="panel-wrapper collapse in">

                                    <div class="panel-body">
                                        <div class="text-right mb-15">
                                            <asp:Button ID="btnAddBreak" runat="server" Text="Start My Break" CssClass="btn btn-success btnAddBreak" OnClick="btnAddBreak_Click" />
                                        </div>

                                        <div class="table-wrap">
                                            <div class="table-responsive">
                                                <table class="paper-table responsive table table-paper table-striped table-sortable table-bordered RptTable">
                                                    <thead>
                                                        <tr>
                                                            <th class="AllignLeft">S.No</th>
                                                            <th class="AllignLeft">Break Type</th>
                                                            <th class="AllignLeft">Description </th>
                                                            <th class="AllignLeft">Start Time</th>
                                                            <th class="AllignLeft">End Time</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="rptBreak" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td class="AllignLeft">
                                                                        <input type="hidden" runat="server" id="hfBreakId" class="hfBreakId" value='<%# Eval("BreakId") %>' />
                                                                        <input type="hidden" runat="server" id="hfBreakTypeId" class="hfBreakTypeId" value='<%# Eval("BreakTypeId") %>' />
                                                                        <%#(((RepeaterItem)Container).ItemIndex+1).ToString()%>
                                                                    </td>
                                                                    <td class="AllignLeft">
                                                                        <%# Eval("BreakType") %>
                                                                    </td>
                                                                    <td class="AllignLeft">
                                                                        <%# Eval("DescriptionStart") %>
                                                                    </td>
                                                                    <td class="AllignLeft">
                                                                        <%# Convert.ToString(Eval("Starttime")) == "" ? "" :  Convert.ToDateTime(Eval("Starttime")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %>
                                                                    </td>
                                                                    <td class="AllignLeft">
                                                                        <asp:Label ID="lblEndTIme" runat="server" Visible='<%# string.IsNullOrEmpty(Convert.ToString(Eval("Endtime")))? false:true %>'>
                                                                             <%# Convert.ToString(Eval("Endtime")) == "" ? "" :  Convert.ToDateTime(Eval("Endtime")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %>
                                                                        </asp:Label>
                                                                        <asp:Button runat="server" ID="lbEnd" CssClass="btn btn-success" Text="End Break" Visible='<%# string.IsNullOrEmpty(Convert.ToString(Eval("Endtime")))? true:false %>' OnClick="lbEnd_Click" />
                                                                    </td>

                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>


                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>


    <%-- Modal Start--%>
    <input type="button" data-toggle="modal" data-target="#AddEditModal" class="openmodal" style="display: none;" />
    <div class="modal fade in inmodal " id="AddEditModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated">
                <div class="modal-header" style="padding-bottom: 9px; padding-top: 9px; text-align: center">
                    <h5 class="modal-title">Add Hourly Update</h5>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <input type="hidden" id="hfId" runat="server" class="hfId" value="0" />
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label class="mb-5">Time Interval</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlTimeInterval" InitialValue="" Text="*" ValidationGroup="Save" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlTimeInterval" InitialValue="0" Text="*" ValidationGroup="Save" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList runat="server" ID="ddlTimeInterval" CssClass="form-control ddlRole clsDropDown"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12">
                                    <div class="form-group">
                                        <label class="mb-5">Description</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtDescription" InitialValue="" Text="*" ValidationGroup="Save" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control" TextMode="MultiLine" Style="resize: none;" Rows="5"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Save" CssClass="btn btn-primary" ID="btnSave" ValidationGroup="Save" runat="server" OnClick="btnSave_Click" />
                            <asp:Button Text="Cancel" ID="btnCancelEdit" runat="server" CssClass="btnCancelEdit btn btn-default" data-dismiss="modal" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <%-- Modal End--%>

    <%-- Modal Start--%>
    <input type="button" data-toggle="modal" data-target="#AddBreakModal" class="openmodal1 AddBreakModal" style="display: none;" />
    <div class="modal fade in inmodal " id="AddBreakModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated">
                <div class="modal-header" style="padding-bottom: 9px; padding-top: 9px; text-align: center">
                    <h5 class="modal-title">Break </h5>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <input type="hidden" id="Hidden1" runat="server" class="hfId" value="0" />
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label class="mb-5">Break Type</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="ddlBreakType" InitialValue="" Text="*" ValidationGroup="SaveBreak" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="ddlBreakType" InitialValue="0" Text="*" ValidationGroup="SaveBreak" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList runat="server" ID="ddlBreakType" CssClass="form-control ddlBreakType clsDropDown"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12">
                                    <div class="form-group">
                                        <label class="mb-5">Description</label>
                                        <asp:TextBox runat="server" ID="txtBreakDescription" CssClass="form-control" TextMode="MultiLine" Style="resize: none;" Rows="5"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Start Break" CssClass="btn btn-primary" ID="btnSaveBreak" ValidationGroup="SaveBreak" runat="server" OnClick="btnSaveBreak_Click" />
                            <asp:Button Text="Cancel" ID="btnCancelBreak" runat="server" CssClass="btnCancelBreak btn btn-default" data-dismiss="modal" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <%-- Modal End--%>

    <script type="text/javascript">
        function pageLoad() {
            $(".select2").select2();

            TabNoActive();
            $('.btnSearch').click(function (e) {
                var fromdate = $('.txtFromDateSearch').val();
                var Todate = $('.txtToDateSearch').val();
                if (fromdate != "" && Todate != "") {
                    if (new Date(fromdate) > new Date(Todate)) {
                        AlertBox("Error", "Start date must be earlier than end date", "error");
                        return false;
                    }
                }
                return true;


            });
            //$("#show").click(function () {
            //    $(".Div_Search").toggle(500);
            //    return false;
            //});


            $('.datetime').datepicker({
                forceParse: false,
                calendarWeeks: true,
                autoclose: true,
                format: 'dd-M-yyyy',
            });
            $('.datetime').keydown(function () {
                return false;
            });

            $(".integers").on("keypress", function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            });


            $(".decimals").on("keypress", function (evt) {
                var $txtBox = $(this);
                var charCode = (evt.which) ? evt.which : evt.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                    return false;
                else {
                    var len = $txtBox.val().length;
                    var index = $txtBox.val().indexOf('.');
                    if (index > 0 && charCode == 46) {
                        return false;
                    }
                    if (index > 0) {
                        var charAfterdot = (len + 1) - index;
                        if (charAfterdot > 3) {
                            return false;
                        }
                    }
                }
                return $txtBox; //for chaining
            });
        }

        function AlertBox(title, Message, type) {
            swal(title, Message, type);
            TabNoActive();
        }
        function ClosePopup() {
            $('.hfId').val("0");
            $('.clsTextBox').val("");
            $('.clsDropDown').val("0");
            $('.btnCancelEdit').click();
            TabNoActive();
        }

        function OpenPopup() {
            $('.openmodal').click();
            $('.hfTabNoActive').val('1');
            TabNoActive();
        }
        function OpenPopupBreak() {
            $('.AddBreakModal').click();
            $('.hfTabNoActive').val('2');
            TabNoActive();

        }
        function ClosePopupBreak() {
            $('.btnCancelBreak').click();
            TabNoActive();
        }

        function TabNoActive() {
            if ($('.hfTabNoActive').val() == '1') {
                $('.liSecB').removeClass('active');
                $('.liSecA').addClass('active');
            }
            else if ($('.hfTabNoActive').val() == '2') {
                $('.liSecA').removeClass('active');
                $('.liSecB').addClass('active');
            }
        }
    </script>
</asp:Content>

