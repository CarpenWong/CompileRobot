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
using System.Collections.Generic;
using System.Collections;

/// <summary>
///OperatorsCheck 的摘要说明
/// </summary>
public class OperatorsCheck
{
    private string operator_check_str;
    private Stack<string> sta;
    
    public string Result_OpCheck
    {
        get { return operator_check_str; }
    }

    //构造函数
	public OperatorsCheck()
	{
        operator_check_str = "";
        sta = new Stack<string>();
	}

    //操作符检查
    public bool Op_Check(string sentence_str, int which_one)
    {
        return Op_Analysis(sentence_str, which_one);
    }

    //操作符分析
    private bool Op_Analysis(string sentence_str, int which_one)
    {
        string reg_str = "(?<char_or_str>\\S+)";
        MatchCollection matches = DataRegexAnalysis.regex_value(reg_str, sentence_str);
        foreach (Match match in matches)
        {
            string result_str = match.Result("${char_or_str}");
            if (!result_str.Equals(""))
            {
                if (!result_str.Equals(")"))
                    sta.Push(result_str);
                else
                {
                    string temp_str = "";
                    while (sta.Count != 0)
                    {
                        temp_str = sta.Pop();
                        if (temp_str.Equals("("))
                            break;
                    }
                }
            }
        }
        if (sta.Count != 0)
        {
            bool op_check_bool = false;
            string[] temp = new string[sta.Count];//因为不知道所要输入的参数个数，所以动态分配大小最好，
            //动态大小与栈内的元素个数相同最好，不会浪费空间
            int i = sta.Count - 1; int len = sta.Count;
            while (sta.Count != 0)
            {
                temp[i] = sta.Pop();
                i--;
            }
            this.operator_check_str += "第" + which_one.ToString() + "语句中，操作符：";
            i++;//因为上面出栈完事后，i的值变成了-1.
            //因为最后一个值是“.”，所以自后一个值不用判断，因此要i<len-1
            while (i < len - 1)
            {
                if (!temp[i].Equals("->"))
                {
                    op_check_bool = true;
                    this.operator_check_str += temp[i] + " ,";
                }
                i++;
            }
            if (op_check_bool)
            {
                this.operator_check_str += "所不知道的操作符，请重新输入！";
                goto loop_false;
            }
        }
        //如果没有错误顺序执行就可
        this.operator_check_str = "";
        return true;

        //出现错误则执行该跳转语句
    loop_false:
        return false;
    }
}
