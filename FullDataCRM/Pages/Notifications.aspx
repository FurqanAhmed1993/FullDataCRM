<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="Notifications.aspx.cs" Inherits="Pages_Notifications" %>

<%@ Register Src="~/CustomControls/Shared/InProgress.ascx" TagPrefix="uc" TagName="InProgress" %>
<%@ Register Src="~/CustomControls/Shared/PagingAndSorting.ascx" TagPrefix="uc" TagName="PagingAndSorting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .chkChoice label {
            margin-left: 3px;
        }

        .chkChoice input {
            margin-left: 10px;
        }

        .chkChoice td {
            padding-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
        <ProgressTemplate>
            <uc:InProgress runat="server" ID="InProgress" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div class="row heading-bg">
        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
            <h5 class="txt-dark">Notification</h5>
        </div>



    </div>
    <asp:UpdatePanel ID="upData" runat="server">
        <ContentTemplate>
            <input type="hidden" runat="server" id="IsAdd" value="0" />
            <input type="hidden" runat="server" id="IsView" value="0" />
            <input type="hidden" runat="server" id="IsEdit" value="0" />
            <input type="hidden" runat="server" id="IsDelete" value="0" />

            <div class="panel panel-default card-view">
                <div class="panel-wrapper collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6 col-md-3 col-lg-2">
                                <div class="form-group">
                                    <label>Title</label>
                                    <asp:TextBox ID="txtTitleSearch" runat="server" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3 col-lg-2">
                                <div class="form-group">
                                    <label>Notification Type</label>
                                    <asp:DropDownList runat="server" ID="ddlNotificationTypeSearch" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-6 col-md-3 col-lg-2">
                                <div class="form-group">
                                    <label>Notify Date From</label>
                                    <asp:TextBox ID="txtNotifyDateSearch" runat="server" CssClass="form-control datetime1" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>

                             <div class="col-sm-6 col-md-3 col-lg-2">
                                <div class="form-group">
                                    <label>Notify Date To</label>
                                   <asp:TextBox ID="txtNotifyDateTo" runat="server" CssClass="form-control datetime1" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>


                      
                            <div class="col-sm-12 col-md-3 col-lg-4 text-right" style="margin-top: 10px">
                                <div class="button-list">
                                    <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnCancel" CssClass="btn btn-default" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default border-panel card-view">
                <div class="panel-wrapper collapse in">
                    <div class="panel-body">
                        <div class="text-right mb-15">
                            <asp:Button ID="Btn_Add" runat="server" Visible="false" Text="Add" CssClass="btn btn-primary Btn_Add" OnClick="Btn_Add_Click" />
                        </div>
                        <div class="table-wrap">
                            <div class="table-responsive">
                                <table class="table table-striped display pb-30">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th class="AllignCenter">Title</th>
                                            <th class="AllignCenter">Notification Type</th>
                                            <th class="AllignCenter">Message</th>
                                            <th class="AllignCenter">Date Time</th>
                                            <th class="AllignCenter">Notify Date</th>
                                            <th class="AllignCenter">Created By </th>
                                            <th class="AllignCenter">Last Modified By</th>
                                            <%--<th class="AllignCenter">Action</th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rpt" runat="server" OnItemDataBound="rpt_ItemDataBound">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <input type="hidden" runat="server" id="hfNotificationId" class="hfNotificationId" value='<%# Eval("NotificationId") %>' />
                                                        <input type="hidden" runat="server" id="hfNotificationTitle" class="hfNotificationTitle" value='<%# Eval("NotificationTitle") %>' />
                                                        <input type="hidden" runat="server" id="hfNotificationTypeId" class="hfNotificationTypeId" value='<%# Eval("NotificationTypeId") %>' />
                                                        <input type="hidden" runat="server" id="hfNotificationMessage" class="hfNotificationMessage" value='<%# Eval("NotificationMessage") %>' />

                                                        <input type="hidden" runat="server" id="hfNotificationDateTime" class="hfNotificationDateTime" value='<%# Eval("NotificationDateTime") %>' />
                                                        <%# Eval("SerialNo") %>
                                                    </td>

                                                    <td class="AllignCenter">
                                                        <%# Eval("NotificationTitle") %>
                                                    </td>
                                                    <td class="AllignCenter">
                                                        <%# Eval("NotificationTypeName") %>
                                                    </td>
                                                    <td class="AllignCenter">
                                                        <%# Eval("NotificationMessage") %>
                                                    </td>
                                                    <td class="AllignCenter">
                                                        <%# Eval("NotificationDateTime") %>
                                                    </td>
                                                    <td class="AllignCenter">
                                                        <%# Eval("NotifyDate") %>
                                                    </td>

                                                    <td class="AllignCenter">
                                                        <%# Convert.ToString( Eval("CreatedByName")) == "" ? ""  : (Eval("CreatedByName") + " <br /> <strong>On</strong> <br />")  %>

                                                        <%# Convert.ToString(Eval("CreatedDate")) == "" ? "" :  Convert.ToDateTime(Eval("CreatedDate")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %>
                                                    </td>
                                                    <td class="AllignCenter">
                                                        <%# Convert.ToString( Eval("ModifiedByName")) == "" ? ""  : (Eval("ModifiedByName") + " <br /> <strong>On</strong> <br />")  %>
                                                        <%# Convert.ToString(Eval("ModifiedDate")) == "" ? "" :  Convert.ToDateTime(Eval("ModifiedDate")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %>
                                                    </td>
                                                    <%-- <td class="AllignCenter">
                                                        <asp:ImageButton ID="lbEdit" Visible="false" ImageUrl="~/Assets/Images/edit-icon.png" runat="server" Text="Edit" ToolTip="Edit" OnClick="lbEdit_Click" />
                                                        &nbsp
                                                       
                                                        <asp:ImageButton ID="lbDelete" Visible="false" ImageUrl="~/Assets/Images/delete-icon.png" runat="server" Text="Remove" ToolTip="Delete" OnClick="lbDelete_Click" />
                                                    </td>--%>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>

                                <uc:PagingAndSorting runat="server" ID="PagingAndSorting" />
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
                    <h5 class="modal-title">Add / Update Notification</h5>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <input type="hidden" id="hfId" runat="server" class="hfId" value="0" />
                            <div class="row">
                                <div class="col-sm-12 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Title</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtTitle" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtTitle" CssClass="form-control txtTitle"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-sm-12 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Notification Type</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlNotificationType" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlNotificationType" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList runat="server" ID="ddlNotificationType" CssClass="form-control ddlNotificationType clsDropDown"></asp:DropDownList>
                                    </div>
                                </div>

                       
                                <div class="col-sm-12 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Select Notify Date</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtNotifyDate" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="txtNotifyDate" runat="server" CssClass="form-control datetime1" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>
                                   </div>
                            <div class="row">  
                                   <div class="col-sm-12 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Select From Time</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="ddlTimeFrom" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="ddlTimeFrom" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList ID="ddlTimeFrom"  CssClass="form-control" runat="server"></asp:DropDownList>
                                        <asp:Label ID="lblTimeError" runat="server" style="color:red"></asp:Label>
                                    </div>
                                </div>
                                 

                                   <div class="col-sm-12 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Select To Time</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="ddlTimeTo" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="ddlTimeTo" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList ID="ddlTimeTo"  CssClass="form-control" runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                          </div>


                          

                            <div class="row">
                                <div class="col-sm-12 col-md-12 col-lg-12">
                                    <div class="form-group">
                                        <label>Message</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtNotificationMessage" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtNotificationMessage" TextMode="MultiLine" CssClass="form-control txtNotificationMessage"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%--<div class="row">
                            <div class="col-md-12 col-sm-12 col-lg-12">
                                <div class="form-group">
                                    <label>DateTime</label>
                                    <span class="MandatoryValue">* </span>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtDateTime" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <asp:TextBox runat="server" ID="txtDateTime"  CssClass="form-control txtDateTime datetime"></asp:TextBox>
                                </div>
                            </div>
                            </div>--%>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Save" CssClass="btn btn-primary" ID="btnAdd" ValidationGroup="Add" runat="server" OnClick="btnAdd_Click" />
                            <asp:Button Text="Cancel" ID="btnCancelEdit" runat="server" CssClass="btnCancelEdit btn btn-default" data-dismiss="modal" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <%-- Modal End--%>





    <script type="text/javascript">
        function pageLoad() {
            $('.datetime').datepicker({
                forceParse: false,
                calendarWeeks: true,
                autoclose: true,
                format: 'dd-M-yyyy h:m:s',
            });
            $('.datetime').keydown(function () {
                return false;
            });

            $('.datetime1').datepicker({
                forceParse: false,
                calendarWeeks: true,
                autoclose: true,
                format: 'dd-M-yyyy',
            });
            $('.datetime1').keydown(function () {
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
        }

        function ClosePopup() {
            $('.hfId').val("0");
            $('.clsTextBox').val("");
            $('.clsDropDown').val("0");
            $('.btnCancelEdit').click();
        }

        function OpenPopup() {
            $('.openmodal').click();
        }

        function OpenModalDeleteModal() {
            $('.OpenDeleteModal').click();
        }
        function CloseDeleteModal() {
            $('.hfmodalDeleteId').val("0");
            $('.btnCancelDelete').click();
        }


    </script>
</asp:Content>



