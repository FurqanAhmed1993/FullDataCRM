<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="SetTimer.aspx.cs" Inherits="Pages_SetTimer" %>

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
            <h5 class="txt-dark">Timer</h5>
        </div>
         

    </div>
    <asp:UpdatePanel ID="upData" runat="server">
        <ContentTemplate>
            <input type="hidden" runat="server" id="IsAdd" value="0" />
            <input type="hidden" runat="server" id="IsView" value="0" />
            <input type="hidden" runat="server" id="IsEdit" value="0" />
            <input type="hidden" runat="server" id="IsDelete" value="0" />
             

            <div class="panel panel-default border-panel card-view">
                <div class="panel-wrapper collapse in">
                    <div class="panel-body">
                          <div class="row"> 
                            <div class="col-sm-6 col-md-8 col-lg-10 col-lg-offset-3 col-sm-offset-3" style="margin-top: 15px; margin-bottom: 30px"> 
                                <div class="row" style="display: flex; align-items: center; text-align: center;">
                                     <div class="col-sm-12 col-4 col-lg-2">
                                         <label class="label-timer">Set Timer</label> 
                                      </div>

                                     <div class="col-sm-12 col-4 col-lg-2">
                                        <asp:Button ID="btnTimer" class="btn btn-timer" runat="server" Text="Start Timer" OnClick="btnTimer_Click"/>
                                     </div>

                                     <div class="col-sm-12 col-4 col-lg-4"> 
                                       <asp:Label runat="server" ID="lblStartTime" Text="Time" class="label-timer"></asp:Label>
                                     </div>

                                </div>

                                
                            </div>
                        </div>

                            <div class="row"> 
                                 <div class="col-sm-12 col-md-12 col-lg-12">
                                     <div class="table-wrap">
                                <div class="table-responsive">
                                    <table class="table table-striped display pb-30">
                                        <thead>
                                            <tr>
                                                <th>S.No</th>
                                                <th >Start Time</th>
                                                <th >End Time </th> 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rpt" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%# Eval("SerialNo") %>

                                                        </td>

                                                        <td>

                                                            <%# Eval("StartTimer") %>
                                                        </td>

                                                           <td>

                                                            <%# Eval("EndTimer") %>
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
            </div>
            </div>
       
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>



    <script type="text/javascript">
        function pageLoad() {

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

