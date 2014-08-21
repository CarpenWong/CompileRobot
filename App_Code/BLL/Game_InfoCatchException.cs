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
///Game_InfoCatchException 的摘要说明
/// </summary>
public class Game_InfoCatchException
{
	public Game_InfoCatchException()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public static bool StringIsNumber(string str)
    {
        int len = str.Length;
        int i = 0;
        while (i < len)
        {
            if (str[i] >= '0' && str[i] <= '9')
            {
                continue;
            }
            else
            {
                goto loop_false;
            }
        }
        return true;
    loop_false:
        return false;
    }
}
