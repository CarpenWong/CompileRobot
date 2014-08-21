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

public partial class User_Register : System.Web.UI.Page
{

   
    
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }
    protected void btnOK(object sender, EventArgs e)
    {
        Player_InfoBLL Player = new Player_InfoBLL();
        String UserId = this.txtUserID_Register.Text;
        String UserPassword = this.txtUserPasswordAgain.Text;
        String Email = this.txtUserEmail.Text;

        Player.RegisterPlayer(UserId, UserPassword, 0, 1,Email);

        Response.Redirect("Default.aspx");

    }
}
