<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="LeadsDetail.aspx.cs" Inherits="Pages_LeadsDetail" %>

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
            <input type="hidden" runat="server" id="hfLeadId" value="0" />
            <input type="hidden" runat="server" id="IsAdd" value="0" />
            <input type="hidden" runat="server" id="IsView" value="0" />
            <input type="hidden" runat="server" id="IsEdit" value="0" />
            <input type="hidden" runat="server" id="IsDelete" value="0" />
            <input type="hidden" runat="server" id="IsEditFinancial" value="0" />
            <input type="hidden" runat="server" id="IsDeleteFinancial" value="0" />
            <input type="hidden" runat="server" id="hfTabNoActive" value="1" class="hfTabNoActive" />
            <input type="hidden" runat="server" id="hfMasterLeadId" value="0" class="hfMasterLeadId" />
            <div id="orderdetailp">

                <div class="row heading-bg">
                    <div class="col-lg-3 col-md-4 col-sm-4">
                        <h5 class="txt-dark">Leads Details</h5>
                    </div>
                </div>
                <div runat="server">
                    <a style="color: white; float: right; margin-top: -20px"></a>
                </div>



                <div class="row">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <asp:ValidationSummary ID="validationSummary1" runat="server" EnableClientScript="true" ForeColor="Red"
                            Enabled="true" ValidationGroup="SaveLead" DisplayMode="BulletList" ShowSummary="true"
                            HeaderText="Required Fields" CssClass='validationSummary panel-body' />
                    </div>
                </div>


                <div class="row">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <div id="tabs1">
                            <ul class="parent nav nav-pills ul1" id="tabs" style="background-color: rgba(26, 179, 148, 0.08);">
                                <li id="li1" class="liSecA active"><a href="#tabs-1" data-toggle="tab">Edit Leads</a></li>
                                <li id="li2" class="liSecB"><a href="#tabs-2" data-toggle="tab">Financial Profile</a></li>
                                <li id="li3" class="liSecC"><a href="#tabs-3" data-toggle="tab">History</a></li>
                                <%--<li id="li3" class="liSecC  "><a href="#tabs-3" data-toggle="tab">Summary</a></li>--%>
                            </ul>
                            <div class="tab-content">
                                <div id="tabs-1" class="liSecA tab-pane active">
                                    <div class="panel panel-default card-view">
                                        <div class="panel-wrapper collapse in">
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>First Name</label>
                                                            <span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtFirstName" ErrorMessage="First Name" Text="*" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Middle Name</label>
                                                            <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Last Name</label>
                                                            <span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtLastName" ErrorMessage="Last Name" Text="*" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Address</label>
                                                            <span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtAddress" ErrorMessage="Address" Text="*" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>City</label>
                                                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>State</label>
                                                            <asp:TextBox ID="txtState" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Zip</label>
                                                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>


                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Phone Number</label>
                                                            <%--<span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number" Text="*" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            --%><asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Email</label>
                                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>SSN</label>
                                                            <asp:TextBox ID="txtSSN" runat="server" CssClass="form-control SSN" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>MMN</label>
                                                            <asp:TextBox ID="txtMMN" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Date Of Birth</label>
                                                            <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control datetime" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Confirm Number</label>
                                                            <asp:TextBox ID="txtConfirmNumber" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Fee</label>
                                                            <asp:TextBox ID="txtFee" runat="server" CssClass="form-control decimals" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>QA Number</label>
                                                            <asp:TextBox ID="txtQANumber" runat="server" CssClass="form-control " AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Payment Notes</label>
                                                            <asp:TextBox ID="txtPaymentNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Columns="5" Rows="5" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Time Stamp</label>
                                                            <asp:TextBox ID="txtTimeStamp" runat="server" CssClass="form-control " AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Agent</label>
                                                            <%--<asp:TextBox ID="txtAgent" runat="server" CssClass="form-control " AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>--%>

                                                            <asp:DropDownList runat="server" ID="ddlAgent" CssClass="form-control select2"></asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Closer</label>
                                                            <%--<asp:TextBox ID="txtCloser" runat="server" CssClass="form-control " AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>--%>
                                                            <asp:DropDownList runat="server" ID="ddlCloser" CssClass="form-control select2"></asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Status</label>
                                                            <span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="ddlStatus" InitialValue="" Text="*" ErrorMessage="Status" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="ddlStatus" InitialValue="0" Text="*" ErrorMessage="Status" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>

                                                            <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control select2"></asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Disposition of Call Placement</label>
                                                            <span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator23" ControlToValidate="ddlDisposition" InitialValue="" Text="*" ErrorMessage="Disposition" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator24" ControlToValidate="ddlDisposition" InitialValue="0" Text="*" ErrorMessage="Disposition" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:DropDownList runat="server" ID="ddlDisposition" CssClass="form-control select2" AutoCompleteType="Disabled"></asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Additional Number</label>
                                                            <%--<span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator25" ControlToValidate="txtTollFree" ErrorMessage="Toll Free Number" Text="*" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                           --%> <asp:TextBox ID="txtTollFree" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>


                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Comments/Notes</label>
                                                            <span class="MandatoryValue">* </span>

                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator26" ControlToValidate="txtComments" Text="*" ErrorMessage="Comments" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:TextBox ID="txtComments" runat="server" Height="100px" TextMode="MultiLine" Width="954px" AutoCompleteType="Disabled"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="row">
                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <h5 class="txt-secondary" style="margin-top: 8px;">Advisers</h5>
                                                        <div runat="server">
                                                            <a style="color: white; float: right; margin-top: -20px"></a>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Advisers</label>
                                                            <span class="MandatoryValue">* </span>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="ddlAdvisers" InitialValue="" Text="*" ErrorMessage="Advisers" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="ddlAdvisers" InitialValue="0" Text="*" ErrorMessage="Advisers" ValidationGroup="SaveLead" ForeColor="Red"></asp:RequiredFieldValidator>

                                                            <asp:DropDownList runat="server" ID="ddlAdvisers" CssClass="form-control select2"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="row">
                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <h5 class="txt-secondary" style="margin-top: 8px;">Financial Profile</h5>
                                                        <div runat="server">
                                                            <a style="color: white; float: right; margin-top: -20px"></a>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Total Debt</label>
                                                            <asp:TextBox ID="txtTotalDebt" runat="server" CssClass="form-control decimals" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Savings</label>
                                                            <asp:TextBox ID="txtSavings" runat="server" CssClass="form-control decimals" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 col-md-3 col-lg-2">
                                                        <div class="form-group">
                                                            <label>Deal</label>
                                                            <asp:TextBox ID="txtDeal" runat="server" CssClass="form-control decimals" AutoCompleteType="Disabled" autocomplete="off" MaxLength="200"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="tabs-2" class="liSecB tab-pane">
                                    <div class="panel panel-default border-panel card-view">
                                        <div class="panel-wrapper collapse in">
                                            <div class="panel-body">
                                                <div class="text-right mb-15">
                                                    <asp:Button ID="btnAddFinancial" runat="server" Visible="false" Text="Add Financial" CssClass="btn btn-primary btnAddFinancial" OnClick="btnAddFinancial_Click" />
                                                </div>
                                                <div class="table-wrap">
                                                    <div class="table-responsive">
                                                        <table class="table table-striped display pb-30">
                                                            <thead>
                                                                <tr>
                                                                    <th>Select</th>
                                                                    <th class="AllignCenter">Accounts</th>
                                                                    <th class="AllignCenter">Bank Name</th>
                                                                    <%--<th class="AllignCenter">Service Number</th>
                                                                    <th class="AllignCenter">CC</th>
                                                                    <th class="AllignCenter">Exp</th>
                                                                    <th class="AllignCenter">CVC </th>
                                                                    <th class="AllignCenter">Owe</th>--%>
                                                                    <th class="AllignCenter">Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <asp:Repeater ID="rptFinancial" runat="server" OnItemDataBound="rptFinancial_ItemDataBound">
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>

                                                                                <input type="hidden" runat="server" id="hfRowNum" class="hfRowNum" value='<%# Eval("RowNum") %>' />
                                                                                <input type="hidden" runat="server" id="hfLeadFinancialId" class="hfLeadFinancialId" value='<%# Eval("LeadFinancialId") %>' />
                                                                                <input type="hidden" runat="server" id="hfAccountsId" class="hfAccountsId" value='<%# Eval("AccountsId") %>' />
                                                                                <input type="hidden" runat="server" id="hfBankName" class="hfBankName" value='<%# Eval("BankName") %>' />
                                                                                <input type="hidden" runat="server" id="hfServiceNumber" class="hfServiceNumber" value='<%# Eval("ServiceNumber") %>' />
                                                                                <input type="hidden" runat="server" id="hfCC" class="hfCC" value='<%# Eval("CC") %>' />
                                                                                <input type="hidden" runat="server" id="hfExp" class="hfExp" value='<%# Eval("Exp") %>' />
                                                                                <input type="hidden" runat="server" id="hfCVC" class="hfCVC" value='<%# Eval("CVC") %>' />
                                                                                <input type="hidden" runat="server" id="hfOwe" class="hfOwe" value='<%# Eval("Owe") %>' />
                                                                                <input type="hidden" runat="server" id="hfAvailableBalance" class="hfOwe" value='<%# Eval("AvailableBalance") %>' />
                                                                                <input type="hidden" runat="server" id="hfLP" class="hfOwe" value='<%# Eval("LP") %>' />
                                                                                <input type="hidden" runat="server" id="hfDP" class="hfOwe" value='<%# Eval("DP") %>' />
                                                                                <input type="hidden" runat="server" id="hfMP" class="hfOwe" value='<%# Eval("MP") %>' />
                                                                                <input type="hidden" runat="server" id="hfAPR" class="hfOwe" value='<%# Eval("APR") %>' />
                                                                                <input type="hidden" runat="server" id="hfIsSelected" class="hfIsSelected" value='<%# Eval("IsSelected") %>' />

                                                                                <asp:RadioButton ID="rdIsSelected" CssClass="rdIsSelected" runat="server" Checked='<%# Eval("IsSelected").ToString()=="True"?true:false %>' OnCheckedChanged="rdIsSelected_CheckedChanged" AutoPostBack="true" />
                                                                            </td>

                                                                            <td class="AllignCenter">
                                                                                <%# Eval("AccountName") %>
                                                                            </td>
                                                                            <td class="AllignCenter">
                                                                                <%# Eval("BankName") %>
                                                                            </td>
                                                                           <%-- <td class="AllignCenter">
                                                                                <%# Eval("ServiceNumber") %>
                                                                            </td>
                                                                            <td class="AllignCenter">
                                                                                <%# Eval("CC") %>
                                                                            </td>
                                                                            <td class="AllignCenter">
                                                                                <%# Eval("Exp") %>
                                                                            </td>
                                                                            <td class="AllignCenter">
                                                                                <%# Eval("CVC") %>
                                                                            </td>
                                                                            <td class="AllignCenter">
                                                                                <%# Eval("Owe") %>
                                                                            </td>--%>

                                                                            <%--<td class="AllignCenter">
                                                                            <%# Convert.ToString( Eval("CreatedByName")) == "" ? ""  : (Eval("CreatedByName") + " <br /> <strong>On</strong> <br />")  %>

                                                                            <%# Convert.ToString(Eval("CreatedDate")) == "" ? "" :  Convert.ToDateTime(Eval("CreatedDate")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %>
                                                                        </td>
                                                                        <td class="AllignCenter">
                                                                            <%# Convert.ToString( Eval("ModifiedByName")) == "" ? ""  : (Eval("ModifiedByName") + " <br /> <strong>On</strong> <br />")  %>
                                                                            <%# Convert.ToString(Eval("ModifiedDate")) == "" ? "" :  Convert.ToDateTime(Eval("ModifiedDate")).ToString(Utilities.GenericConstants.DateTimeFormat1_) %>
                                                                        </td>--%>
                                                                            <td class="AllignCenter">
                                                                                <asp:ImageButton ID="lbEditFinancial" ImageUrl="~/Assets/Images/edit-icon.png" runat="server" Text="Edit" Visible="false" ToolTip="Edit" OnClick="lbEditFinancial_Click" />
                                                                                &nbsp 
                                                                            <asp:ImageButton ID="lbDeleteFinancial" ImageUrl="~/Assets/Images/delete-icon.png" runat="server" Text="Remove" Visible="false" ToolTip="Delete" OnClick="lbDeleteFinancial_Click" />
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

                                <div id="tabs-3" class="liSecC tab-pane">
                                    <div class="panel panel-default border-panel card-view">
                                        <div class="panel-wrapper collapse in">
                                            <div class="panel-body">

                                                <div class="table-wrap">
                                                    <div class="table-responsive">
                                                        <table class="table table-striped display pb-30">
                                                            <thead>
                                                                <tr>
                                                                  
                                                                    
                                                                    <th class="AllignLeft">Comments</th>
                                                                    <th class="AllignLeft">Added By</th>
                                                                  

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <asp:Repeater ID="Repeater1" runat="server">
                                                                    <ItemTemplate>
                                                                        <tr>

                                                                       
                                                                            <td class="AllignLeft">
                                                                                <%# Eval("Comments") %>
                                                                            </td>

                                                                            <td class="AllignLeft">
                                                                                <%# Convert.ToString( Eval("CreatedByName")) == "" ? ""  : (Eval("CreatedByName") + " <br /> <strong>On</strong> <br />")  %>

                                                                                <%# Convert.ToString(Eval("CreatedDate")) == "" ? "" :  Convert.ToDateTime(Eval("CreatedDate")).ToString() %>
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

                                <%--<div id="tabs-3" class="liSecC tab-pane">
                            </div>--%>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12">
                                        <div class=" text-right" style="margin-bottom: 10px">
                                            <asp:Button ID="btnSave" CssClass="btn btn-primary btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="SaveLead" />
                                            <asp:Button ID="btnCancel" CssClass="btn btn-default btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
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
    <input type="button" data-toggle="modal" data-target="#AddEditFinancialModal" class="openFinancialmodal" style="display: none;" />
    <div class="modal fade in inmodal " id="AddEditFinancialModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated">
                <div class="modal-header" style="padding-bottom: 9px; padding-top: 9px; text-align: center">
                    <h5 class="modal-title">Add / Update Financial</h5>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <input type="hidden" id="hfId" runat="server" class="hfId" value="0" />
                            <input type="hidden" id="hfRowNumber" runat="server" class="hfRowNumber" value="0" />
                            <input type="hidden" id="hfIsSelect" runat="server" class="hfIsSelect" value="False" />
                            <div class="form-group row">
                                <asp:ValidationSummary ID="validationSummary2" runat="server" EnableClientScript="true" ForeColor="Red"
                                    Enabled="true" ValidationGroup="AddFinancial" DisplayMode="BulletList" ShowSummary="true"
                                    HeaderText="Required Fields" CssClass='validationSummary panel-body' />
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Accounts</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlAccounts" InitialValue="" Text="*" ValidationGroup="AddFinancial" ErrorMessage="Account" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlAccounts" InitialValue="0" Text="*" ValidationGroup="AddFinancial" ErrorMessage="Account" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList runat="server" ID="ddlAccounts" CssClass="form-control ddlRole clsDropDown"></asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Bank</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtBankName" Text="*" ErrorMessage="Bank Name" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtBankName" CssClass="form-control txtBankName clsTextBox"></asp:TextBox>

                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Service Number</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="txtServiceNumber" Text="*" ErrorMessage="Service Number" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtServiceNumber" CssClass="form-control txtEmailAddress clsTextBox" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>CC</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator14" ControlToValidate="txtCC" Text="*" ErrorMessage="CC" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtCC" CssClass="form-control txtCC CC clsTextBox" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Exp</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator15" ControlToValidate="txtExp" Text="*" ErrorMessage="Exp" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtExp" CssClass="form-control txtExp Exp clsTextBox" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>CVC</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator16" ControlToValidate="txtCVC" Text="*" ErrorMessage="CVC" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtCVC" CssClass="form-control txtCVC clsTextBox integers" AutoCompleteType="Disabled" autocomplete="off" MaxLength="4"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Owe</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator17" ControlToValidate="txtOwe" Text="*" ErrorMessage="OWE" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtOwe" CssClass="form-control txtOwe clsTextBox decimals" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>


                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>Available Balance</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator18" ControlToValidate="txtAvailableBalance" Text="*" ErrorMessage="Available Balance" ValidationGroup="AddFinancial" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtAvailableBalance" CssClass="form-control txtAvailableBalance clsTextBox decimals" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>


                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>LP</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator19" ControlToValidate="txtLP" Text="*" ValidationGroup="AddFinancial" ErrorMessage="LP" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtLP" CssClass="form-control txtLP clsTextBox decimals" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>DP</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator20" ControlToValidate="txtDP" Text="*" ValidationGroup="AddFinancial" ErrorMessage="DP" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtDP" CssClass="form-control txtDP clsTextBox decimals" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>


                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>MP</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator21" ControlToValidate="txtMP" Text="*" ValidationGroup="AddFinancial" ErrorMessage="MP" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtMP" CssClass="form-control txtMP clsTextBox decimals" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>


                                <div class="col-md-6 col-sm-6 col-lg-6">
                                    <div class="form-group">
                                        <label>APR</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator22" ControlToValidate="txtAPR" Text="*" ValidationGroup="AddFinancial" ErrorMessage="APR" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox runat="server" ID="txtAPR" CssClass="form-control txtAPR clsTextBox decimals" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Save" CssClass="btn btn-primary" ID="btnSaveFinancial" ValidationGroup="AddFinancial" runat="server" OnClick="btnSaveFinancial_Click" />
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

            TabNoActive();
            $(".SSN").mask("999-99-9999");
            $(".CC").mask("9999-9999-9999-9999");
            $(".Exp").mask("99/99");
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

            $('.rdIsSelected input:radio').click(function () {
                $('.rdIsSelected input:radio').each(function () {
                    $(this).prop('checked', false);
                    $(this).closest('.hfIsSelected').val("False");
                });
                $(this).prop('checked', true);
                $(this).closest('.hfIsSelected').val("True");
            });
        }

        function AlertBox(title, Message, type) {
            swal(title, Message, type);
            TabNoActive();
        }

        function ClosePopup() {
            $('.hfId').val("0");
            $('.hfRowNumber').val("0");
            $('.clsTextBox').val("");
            $('.clsDropDown').val("0");
            $('.btnCancelEdit').click();
            TabNoActive();
        }

        function OpenPopup() {
            $('.openFinancialmodal').click();
            $('.hfTabNoActive').val('2');
            TabNoActive();
        }
        //function OpenPopupBreak() {
        //    $('.AddBreakModal').click();
        //    $('.hfTabNoActive').val('2');
        //    TabNoActive();

        //}
        //function ClosePopupBreak() {
        //    $('.btnCancelBreak').click();
        //    TabNoActive();
        //}

        function TabNoActive() {
            if ($('.hfTabNoActive').val() == '1') {
                $('.liSecB').removeClass('active');
                $('.liSecA').addClass('active');
                $('.liSecC').removeClass('active');
            }
            else if ($('.hfTabNoActive').val() == '2') {
                $('.liSecA').removeClass('active');
                $('.liSecC').removeClass('active');
                $('.liSecB').addClass('active');
            }
            else if ($('.hfTabNoActive').val() == '3') {
                $('.liSecA').removeClass('active');
                $('.liSecB').removeClass('active');
                $('.liSecC').addClass('active');
            }
        }

        function AlertBox_Error_Return(title, Message, type, Page) {

            swal({
                title: title,
                text: Message,
                type: type,
                html: true
            },
                function () {
                    var page = '/Pages/LeadsList.aspx';
                    window.location = Page;
                });
        }
    </script>
</asp:Content>

