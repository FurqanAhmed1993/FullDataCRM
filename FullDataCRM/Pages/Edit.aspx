<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Edit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New event</title>
    <link href='css/main.css' type="text/css" rel="stylesheet" /> 
    <link href="/Assets/dist/css/style.css" rel="stylesheet" type="text/css" />

</head>
<body class="dialog">
    <form id="form1" runat="server">
    <div>
        <table class="table-calendar" border="0" cellspacing="4" cellpadding="0">
            <tr>
                <td align="right"></td>
                <td style="padding-top: 2px; padding-bottom: 2px;  text-align: center;" colspan="2">
                    <div class="header"><h6 class="new-event"> Edit Event</h6></div>
               
                </td>
            </tr>
            <tr>
                <td align="right" style="padding: 5px; width: 60px;"></td>
                <td style="width: 180px;">
                    <strong>Start:</strong>
                    <span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="TextBoxStart" Text="*" ValidationGroup="Add" ForeColor="Red">
                         </asp:RequiredFieldValidator><br />
                    <asp:TextBox ID="TextBoxStart" CssClass="form-control" runat="server"></asp:TextBox>
                </td>
                <td style="width: 180px;">
                   
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlTimeFrom" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlTimeFrom" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:DropDownList ID="ddlTimeFrom" CssClass="form-control" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" style="padding: 5px;"></td>
                <td>
                    <strong>End:</strong>
                    <span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="TextBoxEnd" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                    <asp:TextBox ID="TextBoxEnd" runat="server" CssClass="form-control" style="width: 180px;"></asp:TextBox></td>
                <td>
                     <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="ddlTimeTo" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="ddlTimeTo" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:DropDownList ID="ddlTimeTo" runat="server" CssClass="form-control" style="width: 180px;"></asp:DropDownList><asp:Label ID="lblTimeError" runat="server" style="color:red"></asp:Label></td>
            </tr>
            <tr>
                <td align="right" style="padding: 5px;"></td>
                <td colspan="2">
                    <strong>Name:</strong>
                    <span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="TextBoxName" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                    <asp:TextBox ID="TextBoxName" runat="server" class="form-control"></asp:TextBox></td>
            </tr>
                <tr>
                    <td align="right" style="padding: 5px;"></td>
                    <td colspan="2">
                        <strong>Description:</strong>
                        <span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtDescription" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="6" Columns="40"></asp:TextBox></td>
                </tr>
            <tr>
                <td align="right"></td>
                <td style="padding-top: 5px"; colspan="2">
                    <asp:Button ID="ButtonOK" runat="server" CssClass="btn btn-primary" OnClick="ButtonOK_Click" Text="  OK  "  ValidationGroup="Add"/>
                     <asp:LinkButton ID="LinkButtonDelete" CssClass="btn btn-danger btn-sm" runat="server" OnClick="LinkButtonDelete_Click">Delete</asp:LinkButton>
               
                    <asp:Button ID="ButtonCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="ButtonCancel_Click" />
                </td>
                <td>
                        
                </td>
            </tr>
        </table>
        
        </div>
    </form>
</body>
</html>
