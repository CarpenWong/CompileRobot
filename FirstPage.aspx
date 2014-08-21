<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FirstPage.aspx.cs" Inherits="FirstPage" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        
        <MARQUEE id=a onmouseover=a.stop() style="FONT-SIZE: 9pt;
                COLOR: white; width: 226px;" onmouseout=a.start() 
                scrollAmount=4 direction=left  height=150>
              <DIV align=left style="font-size: xx-large; font-family: 华文仿宋; color: #66FF33; height: 343px">欢迎进入自控编程世界</DIV></MARQUEE>
        
  



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:Image ID="Image2" runat="server" Height="328px" ImageUrl="~/img/背景1.gif" 
        style="margin-left: 0px" Width="516px" />
</asp:Content>
