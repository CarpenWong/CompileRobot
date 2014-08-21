<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="User_Register.aspx.cs" Inherits="User_Register" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:Image ID="Image2" runat="server" ImageUrl="~/img/HappyDay.jpg" 
    Width="222px" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:Label ID="Label1" runat="server" Text="用户ID：" Font-Bold="True" 
        Font-Names="华文琥珀" Font-Size="Large" ForeColor="#009933"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtUserID_Register" runat="server" BorderColor="#009933" 
        BorderStyle="Dashed" Font-Bold="True" Font-Size="Large" Width="205px"></asp:TextBox>
<br />
<br />
<br />
<asp:Label ID="Label2" runat="server" Text="用户密码：" Font-Bold="True" 
        Font-Names="华文琥珀" Font-Size="Large" ForeColor="#009933"></asp:Label>
<asp:TextBox ID="txtPassword_Register" runat="server" BorderColor="#009933" 
        BorderStyle="Dashed" Font-Size="Large" Width="205px" TextMode="Password"></asp:TextBox>
<br />
<br />
    <br />
    <asp:Label ID="Label3" runat="server" Text="确认密码：" Font-Bold="True" 
        Font-Names="华文琥珀" Font-Size="Large" ForeColor="#009933"></asp:Label>
    <asp:TextBox ID="txtUserPasswordAgain" runat="server" TextMode="Password" 
        BorderColor="#009933" BorderStyle="Dashed" Font-Size="Large" 
    Width="205px"></asp:TextBox>  
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <asp:CompareValidator ID="CompareValidator1" runat="server" 
        ControlToCompare="txtPassword_Register" 
        ControlToValidate="txtUserPasswordAgain" ErrorMessage="CompareValidator">密码与确认密码不一致！</asp:CompareValidator>
<br />
<br />
    <br />
    &nbsp;<asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Impact" 
        Font-Size="Large" ForeColor="#009933" Text="Email ："></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:TextBox ID="txtUserEmail" runat="server" BorderColor="#009900" 
        BorderStyle="Dashed" Font-Size="Large" Width="205px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
    ErrorMessage="RegularExpressionValidator" 
    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
        ControlToValidate="txtUserEmail">Email格式不正确！</asp:RegularExpressionValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
<asp:Button ID="btnOk" runat="server" Text="注册" Font-Bold="True" Font-Size="Large" 
        ForeColor="#009900" BorderStyle="Outset" onclick="btnOK" />
<br />
</asp:Content>
