using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Manager_Page : System.Web.UI.Page
{
    Player_InfoBLL Player = new Player_InfoBLL();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_Add_Click(object sender, EventArgs e)
    {
        string ID = this.txt_PlayerID.Text;
        string Password = this.txt_PlayerPassword.Text;
        int Score = Convert.ToInt16(this.txt_Score.Text);
        int Round = Convert.ToInt32(this.txt_Round.Text);
        string Email = this.txt_Email.Text;

        
        Player.RegisterPlayer(ID, Password, Score, Round, Email);

        GridView1.DataBind();

         this.txt_PlayerID.Text="";
         this.txt_PlayerPassword.Text = "";
         this.txt_Score.Text = "";
         this.txt_Round.Text = "";
         this.txt_Email.Text = "";

    }
}
