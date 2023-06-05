<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttachmentControl.ascx.cs" Inherits="CustomControls_AttachmentControl" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <style>
            .downloadImg {
                height: 24px;
            }
        </style>
        <div style="border: 1px solid; margin-bottom: 2px">
            <div class="panel-heading">
                Attachments
           
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="form-group">
                            <div runat="server" id="Div_Add">
                                <div class="col-md-4 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">Document Type</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="ddlDocType" InitialValue="" Text="*" ErrorMessage="Doc Type" ValidationGroup="SaveAttachment" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="ddlDocType" InitialValue="0" Text="*" ErrorMessage="Doc Type" ValidationGroup="SaveAttachment" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:DropDownList ID="ddlDocType" runat="server" CssClass="form-control select2" AutoCompleteType="Disabled"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">Document</label>
                                        <span class="MandatoryValue">* </span>
                                        <asp:FileUpload ID="fuAttachments" runat="server" CssClass="form-control " AutoCompleteType="Disabled"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-12">
                                    <div class="form-group">
                                        <label class="mb-5">Description</label>
                                        <%--<span class="MandatoryValue">* </span>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtFileDescription" ErrorMessage="Description" Text="*" ValidationGroup="SaveAttachment" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                        <asp:TextBox ID="txtFileDescription" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default border-panel card-view">
                                <div class="panel-wrapper collapse in">
                                    <div class="panel-body">
                                        <div class="text-right mb-15">
                                            <asp:Button ID="Btn_Add_Attachments" runat="server" ValidationGroup="SaveAttachment" Text="Add Attachments" CssClass="btn btn-success Btn_Add_Attachments" OnClick="Btn_Add_Attachments_Click" />
                                        </div>
                                        <div class="table-wrap">
                                            <div class="table-responsive">
                                                <table class="table table-striped display pb-30">
                                                    <thead>
                                                        <tr>
                                                            <th>S.No</th>
                                                            <th class="">Document Type</th>
                                                            <th class="AllignCenter">File Name</th>
                                                            <th class="AllignCenter">Description</th>
                                                            <th class="AllignCenter">Download</th>
                                                            <th class="AllignCenter">Delete</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="rptAttachments" runat="server" OnItemDataBound="rptAttachments_ItemDataBound">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <input type="hidden" runat="server" id="hfTableTypeId" class="hfTableTypeId" value='<%# Eval("TableTypeId") %>' />
                                                                    <input type="hidden" runat="server" id="hfDocTypeId" class="hfDocTypeId" value='<%# Eval("DocTypeId") %>' />
                                                                    <input type="hidden" runat="server" id="hfFileName" class="hfAttachmentId" value='<%# Eval("FileName") %>' />
                                                                    <input type="hidden" runat="server" id="hfFileName_Random" class="hfFileName_Random" value='<%# Eval("FileName_Random") %>' />
                                                                    <input type="hidden" runat="server" id="hfDescription" class="hfDescription" value='<%# Eval("Description") %>' />
                                                                    <input type="hidden" runat="server" id="hfFilePath" class="hfFilePath" value='<%# Eval("FilePath") %>' />
                                                                    <input type="hidden" runat="server" id="hfRowNum" class="hfRowNum" value='<%# Eval("RowNum") %>' />
                                                                    <td class="">
                                                                        <%# Eval("RowNum") %>
                                                                    </td>
                                                                    <td class="">
                                                                        <%# Eval("DocType") %>
                                                                    </td>
                                                                    <td class="AllignCenter">
                                                                        <%# Eval("FileName") %>
                                                                    </td>
                                                                    <td class="AllignCenter">
                                                                        <%# Eval("Description") %>
                                                                    </td>
                                                                    <td class="AllignCenter">
                                                                        <a href="/Uploads/<%# Eval("FileName_Random").ToString()%>" download>
                                                                            <asp:Image runat="server" CssClass="downloadImg" ImageUrl="~/Assets/img/downloadIcon.png" />
                                                                        </a>
                                                                    </td>
                                                                    <td class="AllignCenter">
                                                                        <asp:ImageButton ID="lbDelete" OnClientClick="return confirm('Are you sure you want to delete?')"  ImageUrl="~/Assets/Images/delete-icon.png" runat="server" Text="Delete" ToolTip="Delete" OnClick="lbDelete_Click" />
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
        </div>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="Btn_Add_Attachments" />
    </Triggers>
</asp:UpdatePanel>

