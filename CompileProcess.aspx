<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompileProcess.aspx.cs" Inherits="CompileProcess" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:TextBox ID="TextBox1" runat="server" BackColor="#C0C5D8" 
            BorderColor="Silver" BorderStyle="Inset" Font-Size="Large" Height="132px" 
            TextMode="MultiLine" Width="545px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btn_execute" runat="server" BackColor="#AEB748" BorderStyle="None" 
            Font-Size="X-Large" Height="30px" Text="执行" 
            Width="64px" onclick="btn_execute_Click" />
&nbsp;&nbsp;&nbsp;<br />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    
        <br />
    
        <br />
        <asp:Label ID="Label2" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
