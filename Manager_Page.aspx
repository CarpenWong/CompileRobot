<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Manager_Page.aspx.cs" Inherits="Manager_Page" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Image ID="Image2" runat="server" ImageUrl="~/img/10.jpg" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <p align="center" style="font-family: 华文琥珀; font-size: x-large; color: #0066CC">
        增删查改用户信息</p>
    <p align="center" style="font-family: 华文琥珀; font-size: x-large; color: #0066CC">
        用户信息列表<asp:ScriptManager ID="ScriptManager2" runat="server">
        </asp:ScriptManager>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            DeleteMethod="DeletePlayer" InsertMethod="RegisterPlayer" SelectMethod="GetPlayerInfos" 
            TypeName="Player_InfoBLL" UpdateMethod="ModifyPlayer">
            <DeleteParameters>
                <asp:Parameter Name="Player_ID" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Player_Password" Type="String" />
                <asp:Parameter Name="Player_Score" Type="Int32" />
                <asp:Parameter Name="Player_Round" Type="Int32" />
                <asp:Parameter Name="Player_ID" Type="String" />
                <asp:Parameter Name="Player_Email" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Player_ID" Type="String" />
                <asp:Parameter Name="Player_Password" Type="String" />
                <asp:Parameter Name="Player_Score" Type="Int32" />
                <asp:Parameter Name="Player_Round" Type="Int32" />
                <asp:Parameter Name="Player_Email" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </p>
       
    
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" DataKeyNames="Player_ID" DataSourceID="ObjectDataSource1" 
                ForeColor="Black" GridLines="None" AllowPaging="True" PageSize="5">
                <FooterStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:CommandField HeaderText="编辑删除" ShowDeleteButton="True" 
                        ShowEditButton="True" />
                    <asp:BoundField DataField="Player_ID" HeaderText="Player_ID" ReadOnly="True" 
                        SortExpression="Player_ID" />
                    <asp:BoundField DataField="Player_Password" HeaderText="Player_Password" 
                        SortExpression="Player_Password" />
                    <asp:BoundField DataField="Player_Score" HeaderText="Player_Score" 
                        SortExpression="Player_Score" />
                    <asp:BoundField DataField="Player_Round" HeaderText="Player_Round" 
                        SortExpression="Player_Round" />
                    <asp:BoundField DataField="Player_Email" HeaderText="Player_Email" 
                        SortExpression="Player_Email" />
                </Columns>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
        </ContentTemplate>
    
    </asp:UpdatePanel>
    <br />
       <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
    <asp:Panel ID="Panel1" runat="server" Font-Size="Large">
       &nbsp;
       
        
        <p align="center" 
            style="font-family: 华文琥珀; font-size: x-large; color: #0099FF">
            &nbsp;&nbsp; 添加用户信息 
        </p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label1" runat="server" Text="用户名：" 
            Font-Names="华文琥珀" Font-Size="Large" ForeColor="#0099FF"></asp:Label>
        <asp:TextBox ID="txt_PlayerID" runat="server" BorderColor="Lime" 
            BorderStyle="Dashed"></asp:TextBox>
        <br />
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <asp:Label ID="Label2" runat="server" Text="密码：" 
            Font-Names="华文琥珀" Font-Size="Large" ForeColor="#0099FF"></asp:Label>
             &nbsp;&nbsp; 
        <asp:TextBox ID="txt_PlayerPassword" runat="server" BorderColor="Lime" 
            BorderStyle="Dashed"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <asp:Label ID="Label3" runat="server" Text="分数：" 
            Font-Names="华文琥珀" Font-Size="Large" ForeColor="#0099FF"></asp:Label>
             &nbsp;&nbsp; 
        <asp:TextBox ID="txt_Score" runat="server" BorderColor="Lime" 
            BorderStyle="Dashed"></asp:TextBox>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <asp:Label ID="Label4" runat="server" Text="关卡：" 
            Font-Names="华文琥珀" Font-Size="Large" ForeColor="#0099FF"></asp:Label>  &nbsp;&nbsp; 
        <asp:TextBox ID="txt_Round" runat="server" BorderColor="Lime" 
            BorderStyle="Dashed" ></asp:TextBox>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <asp:Label ID="Label5" runat="server" Text="Email：" 
            Font-Names="华文琥珀" Font-Size="Large" ForeColor="#0099FF"></asp:Label>
         
        &nbsp;
         
        <asp:TextBox ID="txt_Email" runat="server" BorderColor="Lime" 
            BorderStyle="Dashed"></asp:TextBox>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="btn_Add" runat="server" 
            BorderStyle="Groove" Font-Bold="True" Font-Names="幼圆" Font-Size="Large" 
            ForeColor="#0099FF" Text="添加" onclick="btn_Add_Click" />
            </asp:Panel>
   </ContentTemplate>
    </asp:UpdatePanel>
   
</asp:Content>

