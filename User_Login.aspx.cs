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


public partial class User_Login : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string Id = this.txtUserID.Text;
        string Password = this.txtUserPassword.Text;
        if (this.DropDownList1.SelectedValue.Equals("玩家"))
        {
            Player_InfoBLL Player = new Player_InfoBLL();
            bool check = Player.CheckPlayerIDAndPasswd(Id, Password);

            if (check)
            {
                Response.Redirect("Default.aspx");
            }
            else
                Response.Redirect("User_Register.aspx");
        }
        else
        {
            Manager_InfoBLL Manager = new Manager_InfoBLL();
            bool check = Manager.CheckManagerIDMatchPasswd(Id, Password);
            if (check)
            {
                Response.Redirect("Manager_Page.aspx");
            }
            else
            {

            }
        }
    }

    
}

