<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="User_Help.aspx.cs" Inherits="User_Help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Image ID="Image2" runat="server" Height="399px" ImageUrl="~/img/大头娃娃.jpg" 
        Width="210px" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:Panel ID="Panel1" runat="server" Height="383px">
    
    <asp:TextBox ID="TextBox1" runat="server" Font-Size="Large" Height="343px" 
        ReadOnly="True" TextMode="MultiLine" Width="519px">在当今世界电脑普及的时刻，
        社会需要大量的熟练掌握编程技术的人员，在掌握编程技术前，需要熟练掌握计算机语言。
        在初学计算机语言期间，是一个“艰难的”过渡时期。我们将采用寓教于乐的方式，在玩游戏的同时，以计算机思维方式考虑问题、解决问题，会将用户的思维逐渐过渡到计算机思维。
   输入语句格式	格式说明	语句动作
      （start)             开始游戏
      (godown  count)	    (godown  2)     向下前进两步
      (goup  count)	      (goup  3)	      向上前进三步
      (goleft count)      (goleft 2)      向左前进两步
      (goright count)     (goright 2)     向右前进两步
      (turn)		                         翻转棋子
      (next)            进入下一关

以上语句还可连用，并用“->”连接动作。且动作执行顺序从里向外执行。
例如：(turn(godown 3)) -> (goleft 3).    
      执行动作为：先向下走三步，翻转棋子，然后向左走三步。


    </asp:TextBox>
    <br />
    <br />
        <asp:LinkButton ID="LinkButton1" runat="server" Font-Size="X-Large" 
            PostBackUrl="~/CompileProcess.aspx">语句测试</asp:LinkButton>
    </asp:Panel>
</asp:Content>
