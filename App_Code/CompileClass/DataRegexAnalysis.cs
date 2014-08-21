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
using System.Text.RegularExpressions;

/// <summary>
///DataRegexAnalysis 的摘要说明
/// </summary>
public class DataRegexAnalysis
{
	public DataRegexAnalysis()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    //对数据串data_str用正则表达式reg_str进行读取，并返回读取结果的一个匹配集合
    public static MatchCollection regex_value(string reg_str, string data_str)
    {
        Regex regex = new Regex(
            @reg_str,
            RegexOptions.IgnoreCase
            | RegexOptions.Multiline
            | RegexOptions.IgnorePatternWhitespace
            | RegexOptions.Compiled
            );
        MatchCollection matches = regex.Matches(data_str);
        return matches;
    }
}
