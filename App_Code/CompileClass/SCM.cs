using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
///SCM 的摘要说明
/// </summary>
public class SCM
{
    private string key;
    public SCM left;
    public SCM right;
	public SCM()
	{
        key = "#";
        left = null;
        right = null;
	}
    public SCM(string value)
    {
        this.key = value;
        this.left = null;
        this.right = null;
    }
}
