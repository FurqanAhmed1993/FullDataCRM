<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="LeadsList.aspx.cs" Inherits="Pages_LeadsList" %>

<%@ Register Src="~/CustomControls/Shared/InProgress.ascx" TagPrefix="uc" TagName="InProgress" %>
<%@ Register Src="~/CustomControls/Shared/PagingAndSorting.ascx" TagPrefix="uc" TagName="PagingAndSorting" %>


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
            <h5 class="txt-dark">Project</h5>
        </div>
    </div>--%>
    <asp:UpdatePanel ID="upData" runat="server">
        <ContentTemplate>
            <input type="hidden" runat="server" id="IsAdd" value="0" />
            <input type="hidden" runat="server" id="IsView" value="0" />
            <input type="hidden" runat="server" id="IsEdit" value="0" />
            <input type="hidden" runat="server" id="IsDelete" value="0" />
            <input type="hidden" runat="server" id="IsUploadRecording" value="0" />
            <input type="hidden" runat="server" id="IsUploadSnapShot" value="0" />
            <div id="orderdetailp">
                <div class="row heading-bg">
                    <div class="col-lg-3 col-md-4 col-sm-4">
                        <h5 class="txt-dark">Leads</h5>
                    </div>
                </div>
                <div class="panel panel-default card-view">
                    <div class="panel-wrapper collapse in">
                        <div class="panel-heading"> 
                            <div runat="server" id="Div_ToggleButton">
                                <a href="#" id="show" style="color: white; float: right; margin-top: -20px; display: none;"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-6 col-md-3 col-lg-2">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3 col-lg-2">
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3 col-lg-2">
                                    <div class="form-group">
                                        <label>Address</label>
                                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3 col-lg-2">
                                    <div class="form-group">
                                        <label>Phone</label>
                                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-sm-6 col-md-3 col-lg-2">
                                    <div class="form-group">
                                        <label>Status</label>
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control select2"></asp:DropDownList>
                                    </div>
                                </div> 

                                <div class="col-sm-6 col-md-3 col-lg-2" style="margin-top: 8px">
                                    <div class="button-list text-right">
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
                                <asp:Button ID="Btn_Add" runat="server" Text="Add" CssClass="btn btn-primary Btn_Add" OnClick="Btn_Add_Click" Visible="false" />
                            </div>
                            <div class="table-wrap">
                                <div class="table-responsive">
                                    <table class="paper-table responsive table table-paper table-striped table-sortable table-bordered RptTable">
                                        <thead>
                                            <tr>
                                                <th>S.No</th>
                                                <th class="AllignLeft">First Name</th>
                                                <th class="AllignLeft">Last Name</th>
                                                <th class="AllignLeft">Address</th>
                                                <th class="AllignLeft">Phone</th>
                                                <th class="AllignLeft">Date</th>
                                                <th class="AllignLeft">Status </th>
                                                <th class="AllignCenter">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rpt" runat="server" OnItemDataBound="rpt_ItemDataBound">
                                                <ItemTemplate>
                                                    <tr>
                                                        <input type="hidden" runat="server" id="hfLeadId" class="hfLeadId" value='<%# Eval("LeadId") %>' />
                                                        <input type="hidden" runat="server" id="hfRecordingFileName" class="hfRecordingFileName" value='<%# Eval("RecordingFileName") %>' />
                                                        <input type="hidden" runat="server" id="hfSnapShotFileName" class="hfSnapShotFileName" value='<%# Eval("SnapShotFileName") %>' />
                                                        <td>
                                                            <%# Eval("SerialNo") %>
                                                        </td>
                                                        <td class="">
                                                            <%# Eval("FirstName") %>
                                                        </td>
                                                        <td class="AllignLeft">
                                                            <%# Eval("LastName") %>
                                                        </td>

                                                        <td class="AllignLeft">
                                                            <%# Eval("Address") %>
                                                        </td>
                                                        <td class="AllignLeft">
                                                            <%# Eval("PhoneNumber") %>
                                                        </td>
                                                        <td class="AllignLeft">
                                                            <%# Convert.ToString(Eval("CreatedDate")) == "" ? "" :  Convert.ToDateTime(Eval("CreatedDate")).ToString(Utilities.GenericConstants.DateTimeFormat2) %>
                                                        </td>
                                                        <td class="AllignLeft">
                                                            <%# Eval("LeadStatusName") %>
                                                        </td>

                                                        <td class="AllignCenter" style="width: 80px;">
                                                            <asp:ImageButton ID="lbView" Visible="false" ImageUrl="~/Assets/Images/view_detailed.png" runat="server" Text="View" ToolTip="View" OnClick="lbView_Click" />
                                                            &nbsp
                                                        <asp:ImageButton ID="lbEdit" Visible="false" ImageUrl="~/Assets/Images/edit-icon.png" runat="server" Text="Edit" ToolTip="Edit" OnClick="lbEdit_Click" />
                                                            &nbsp
                                                       
                                                        <asp:ImageButton ID="lbDelete" OnClientClick="return confirm('Are you sure you want to delete?')" Visible="false" ImageUrl="~/Assets/Images/delete-icon.png" runat="server" Text="Delete" ToolTip="Delete" OnClick="lbDelete_Click" />
                                                            <asp:ImageButton ID="lbUploadRecording" Visible="false" ImageUrl="~/Assets/Images/Add.png" runat="server" ToolTip="Upload Recording" OnClick="lbUploadRecording_Click" />
                                                            <asp:ImageButton ID="lbUploadSnapShot" Visible="false" ImageUrl="~/Assets/Images/snapshot.png" runat="server" ToolTip="Upload SnapShot" OnClick="lbUploadSnapShot_Click" />
                                                        </td>
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
    <input type="button" data-toggle="modal" data-target="#UploadRecordingModal" class="openRecordingModal" style="display: none;" />
    <div class="modal fade in inmodal " id="UploadRecordingModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated">
                <div class="modal-header" style="padding-bottom: 9px; padding-top: 9px; text-align: center">
                    <h5 class="modal-title">Upload Recording </h5>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <input type="hidden" id="hfId" runat="server" class="hfId" value="0" />
                            <input type="hidden" id="hfRecordingFileNameModal" runat="server" class="hfRecordingFileNameModal" value="" />

                            <div class="form-group row">
                                <asp:ValidationSummary ID="validationSummary2" runat="server" EnableClientScript="true" ForeColor="Red"
                                    Enabled="true" ValidationGroup="AddRecording" DisplayMode="BulletList" ShowSummary="true"
                                    HeaderText="Required Fields" CssClass='validationSummary panel-body' />
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Recording</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:FileUpload ID="fuRecording" CssClass="form-control" runat="server" />
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-6" style="text-align: center !important;" id="divResumeDownload" runat="server" visible="false">
                                    <label for="exampleInputEmail2">
                                        Download  Resume File
                                    </label>
                                    <br />
                                    <a href='#' id="downloadRecordingFile" runat="server" download>
                                        <asp:Image runat="server" ImageUrl="~/Assets/Images/downld.gif" Style="margin-top: -11px; width: 20px;" />
                                    </a>
                                    <asp:ImageButton ID="imgDeleteRecordingFile" Style="width: 20px;" OnClick="imgDeleteRecordingFile_Click" runat="server" ImageUrl="~/Assets/Images/delete-icon.png" OnClientClick="return confirm('Are you sure you want to delete?')" />
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Save" CssClass="btn btn-primary" ID="btnSaveRecording" ValidationGroup="AddRecording" runat="server" OnClick="btnSaveRecording_Click" />
                            <asp:Button Text="Cancel" ID="btnCancelEdit" runat="server" CssClass="btnCancelEdit btn btn-default" data-dismiss="modal" />
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnSaveRecording" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <%-- Modal End--%>

    <%-- Modal Start--%>
    <input type="button" data-toggle="modal" data-target="#UploadSnapShotModal" class="openSnapShotModal" style="display: none;" />
    <div class="modal fade in inmodal " id="UploadSnapShotModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated">
                <div class="modal-header" style="padding-bottom: 9px; padding-top: 9px; text-align: center">
                    <h5 class="modal-title">Upload Snap Shot </h5>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <input type="hidden" id="hfSnapShotLeadId" runat="server" class="hfId" value="0" />
                            <input type="hidden" id="hfSnapShotFileNameModal" runat="server" class="hfSnapShotFileNameModal" value="" />

                            <div class="form-group row">
                                <asp:ValidationSummary ID="validationSummary1" runat="server" EnableClientScript="true" ForeColor="Red"
                                    Enabled="true" ValidationGroup="AddSnapShot" DisplayMode="BulletList" ShowSummary="true"
                                    HeaderText="Required Fields" CssClass='validationSummary panel-body' />
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Snap Shot</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:FileUpload ID="fuSnapShot" CssClass="form-control" runat="server" />
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-6" style="text-align: center !important;" id="divSnapshotDownload" runat="server" visible="false">
                                    <label for="exampleInputEmail2">
                                        Download  Snap Shot File
                                    </label>
                                    <br />
                                    <a href='#' id="downloadSnapShotFile" runat="server" download>
                                        <asp:Image runat="server" ImageUrl="~/Assets/Images/downld.gif" Style="margin-top: -11px; width: 20px;" />
                                    </a>
                                    <asp:ImageButton ID="imgDeleteSnapShotFile" Style="width: 20px;" OnClick="imgDeleteSnapShotFile_Click" runat="server" ImageUrl="~/Assets/Images/delete-icon.png" OnClientClick="return confirm('Are you sure you want to delete?')" />
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Save" CssClass="btn btn-primary" ID="btnSaveSnapShot" ValidationGroup="AddSnapShot" runat="server" OnClick="btnSaveSnapShot_Click" />
                            <asp:Button Text="Cancel" ID="btnCancelEditSnapShot" runat="server" CssClass="btnCancelEdit btn btn-default" data-dismiss="modal" />
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnSaveSnapShot" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <%-- Modal End--%>

    <script type="text/javascript">
        function pageLoad() {
            $(".select2").select2();
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
        }

        function ClosePopup() {
            $('.hfId').val("0");
            $('.clsTextBox').val("");
            $('.clsDropDown').val("0");
            $('.btnCancelEdit').click();
        }

        function OpenPopup() {
            $('.openRecordingModal').click();
        }
 function OpenSnapShotPopup() {
            $('.openSnapShotModal').click();
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

