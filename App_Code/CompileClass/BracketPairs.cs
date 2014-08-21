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
///BracketPairs 的摘要说明
/// </summary>
public class BracketPairs
{
    private string bracketpairs;

    public string Result_bracketpairs
    {
        get { return bracketpairs; }
    }

	public BracketPairs()
	{
        bracketpairs = "";
	}

    public bool bracket_pairs_check(string sentence_str, int which_one)
    {
        return bracket_pairs(sentence_str, which_one);
    }
    //判断每一条语句的括号对数是否相等，如果某一条语句的对数不等，则停止编译过程并给出是第几条语句
    //的括号对数不等；如果某一条语句没有括号，则也停止编译过程并给出第几条语句的语法出现错误;
    //每一条语句的划分是以句点划分的，也就是每一个语句的结束标志是句点;
    private bool bracket_pairs(string sentence_str, int which_one)
    {
        int len = sentence_str.Length;
        int i = 0;
        int left_bracket = 0, right_bracket = 0;
        while (i < len)
        {
            if (sentence_str[i] == '(')
                left_bracket++;
            else
                if (sentence_str[i] == ')')
                    right_bracket++;
            i++;
        }
        if (left_bracket == 0 && right_bracket == 0)
        {
            this.bracketpairs = "第" + which_one.ToString() + "个语句的语法不正确！缺少括号运算符!";
            goto loop_false;
            //return false;
        }
        else if (left_bracket > right_bracket)
        {
            this.bracketpairs = "第" + which_one.ToString() + "个语句的括号不匹配,左括号的个数多于右括号！";
            goto loop_false;
            //return false;
        }
        else if (left_bracket < right_bracket)
        {
            this.bracketpairs = "第" + which_one.ToString() + "个语句的括号不匹配,右括号的个数多于左括号！";
            goto loop_false;
            //return false;
        }
        CharactersAnalysis ca = new CharactersAnalysis();
        if (!ca.CharacterAnalysisCheck(sentence_str, which_one))
        {
            this.bracketpairs = ca.ResultOfCharacterAnalysis;
            goto loop_false;
            //return false;
        }
        else
        {
            this.bracketpairs = ca.ResultOfCharacterAnalysis;
            //return true;
        }
        return true;
    loop_false:
        return false;
    }
}
