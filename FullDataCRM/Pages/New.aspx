<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="New" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
                    <td colspan="2" style="text-align: center;">
                        <div class="header"><h6 class="new-event">New Event</h6></div>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="padding: 5px; vertical-align: middle; width: 60px;" ></td>
                    <td style="width: 180px; vertical-align: middle;">
                        <strong> Start:</strong><span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="TextBoxStart" Text="*" ValidationGroup="Add" ForeColor="Red">
                         </asp:RequiredFieldValidator>
                        <asp:TextBox ID="TextBoxStart" CssClass="form-control" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 180px;"> 
                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlTimeFrom" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlTimeFrom" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlTimeFrom" CssClass="form-control" runat="server"></asp:DropDownList> 
                    </td>
                </tr>

                <tr>
                    <td align="right" style="padding: 5px; vertical-align: middle;"></td>
                    <td> <strong>End:</strong><span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="TextBoxEnd" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="TextBoxEnd" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="ddlTimeTo" InitialValue="" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="ddlTimeTo" InitialValue="0" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlTimeTo" CssClass="form-control" runat="server"></asp:DropDownList><asp:Label ID="lblTimeError" runat="server" style="color:red"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" style="padding: 5px; vertical-align: middle;"></td>
                    <td colspan="2">
                         <strong>Name:</strong><span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtEventName" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtEventName" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="right" style="padding: 5px; vertical-align: middle;"></td>
                    <td colspan="2">
                          <strong>Description:</strong><span class="MandatoryValue">* </span>
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtDescription" Text="*" ValidationGroup="Add" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="6" Columns="40">

                        </asp:TextBox></td>
                </tr>

                <tr>
                    <td align="right"></td>
                    <td style="padding-top: 5px";>
                        <asp:Button ID="ButtonOK" runat="server" CssClass="btn btn-primary" OnClick="ButtonOK_Click" Text="OK" ValidationGroup="Add"/>
                        <asp:Button ID="ButtonCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="ButtonCancel_Click" />
                    </td>
                </tr>
            </table>

        </div>

    </form>

</body> 
      
</html>
