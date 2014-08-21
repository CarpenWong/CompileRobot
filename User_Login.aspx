<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="User_Login.aspx.cs" Inherits="User_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Image ID="Image2" runat="server" ImageUrl="~/img/娃娃.gif" 
        Width="233px" Height="308px" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            &nbsp;<asp:Label ID="Label1" runat="server" Text="用户ID：" Font-Names="华文琥珀" 
        Font-Size="Large" ForeColor="#3399FF"></asp:Label>
            &nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtUserID"  runat="server" BorderColor="#3399FF" 
        BorderStyle="Dashed" Font-Size="Large" Width="205px" AutoPostBack="True" 
               ></asp:TextBox>
    <asp:Label ID="lblValidate1" runat="server"></asp:Label>
    <br />
<br />
<br />
<asp:Label ID="Label2" runat="server" Text="密    码 ：" Font-Names="华文琥珀" 
        Font-Size="Large" ForeColor="#3399FF"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtUserPassword" runat="server" TextMode="Password" 
        BorderColor="#3399FF" BorderStyle="Dashed" Font-Size="Large" Width="205px"></asp:TextBox>
    <asp:Label ID="lblValidate2" runat="server"></asp:Label>
    <br />
    <br />
            <asp:Label ID="Label3" runat="server" Text="身份选择：" Font-Names="华文琥珀" 
                Font-Size="Large" ForeColor="#3399FF"></asp:Label>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <asp:DropDownList ID="DropDownList1" runat="server" BackColor="#FFCCCC" 
                Font-Bold="True" Font-Names="方正姚体" Font-Size="Large" ForeColor="#33CCFF" 
      
                >
                <asp:ListItem>管理员</asp:ListItem>
                <asp:ListItem>玩家</asp:ListItem>
            </asp:DropDownList>
            <br />
    <br />
    <a href="User_Register.aspx" style="font-family: 华文琥珀; font-size: large; font-style: inherit; color: #FF33CC">
            我还没注册！</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
    <asp:Button ID="btnLogin" runat="server" BorderColor="#3399FF" 
        BorderStyle="Outset" Font-Names="华文琥珀" Font-Size="Large" ForeColor="Fuchsia" 
        Text="登录" Width="66px" onclick="btnLogin_Click"  />
    
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
    
    <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content>
