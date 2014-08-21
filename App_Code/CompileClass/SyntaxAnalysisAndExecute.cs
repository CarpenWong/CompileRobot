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
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;

/// <summary>
///SyntaxAnalysisAndExecute 的摘要说明
/// </summary>
public class SyntaxAnalysisAndExecute
{
    private string execute_sentence_str;
    private Stack<string> sta;

    public string ExeResult
    {
        get { return this.execute_sentence_str; }
    }
	public SyntaxAnalysisAndExecute()
	{
        execute_sentence_str = "";
        sta = new Stack<string>();
	}

    //用于判断字符串是否全是由数字字符组成
    private bool StringConsistOfNumber(string str)
    {
        int len = str.Length;
        int i = 0;
        while (i < len)
        {
            if (str[i] >= '0' && str[i] <= '9')
            {
                i++;continue;
            }
            else
            {
                break;
            }
        }
        if (i == len) return true;
        else return false;
    }

    public bool execute_syntax_analysis(string characters_str, int which_one)
    {
        return this.syntax_analysis(characters_str, which_one);
    }
    //语义分析函数，分析该条语句的执行过程
    private bool syntax_analysis(string characters_str, int which_one)
    {
        string reg_str = "(?<char_or_str>\\S+)";
        MatchCollection matches = DataRegexAnalysis.regex_value(reg_str, characters_str);
        foreach (Match match in matches)
        {
            string result_str = match.Result("${char_or_str}");
            if (!result_str.Equals(""))
            {
                if (!result_str.Equals(")"))
                    sta.Push(result_str);
                else
                {
                    string[] temp = new string[sta.Count];//因为不知道所要输入的参数个数，所以动态分配大小最好，
                    //动态大小与栈内的元素个数相同最好，不会浪费空间
                    string temp_str = "";
                    int i = 0;
                    while (sta.Count != 0)
                    {
                        temp[i] = sta.Pop();
                        if (temp[i].Equals("("))
                            break;
                        i++;
                    }
                    if (sta.Count == 1)
                    {
                        temp_str = sta.Pop();
                        //因为有可能输入(()).这样的执行过程，所以要判断最后一个是否是"("
                        if (!temp_str.Equals("->")&&!temp_str.Equals("("))
                        {
                            this.execute_sentence_str = "第" + which_one.ToString() + "个语句的运算符输入有误：" + temp_str;
                            goto loop_false;
                        }
                    }
                    if (i != 0)
                    {
                        KeyWordToFunction kwtf = new KeyWordToFunction();
                        KeyWordsTable kwt = new KeyWordsTable();
                        int count_args = kwt.key_word_args(temp[i - 1]);
                        if (count_args == 0 && i == 1)
                        {
                            this.execute_sentence_str += kwtf.execute_sentence(temp[0], 0);

                        }
                        else if (count_args == 1 && i == 2)
                        {
                            if (this.StringConsistOfNumber(temp[0]))
                            {
                                this.execute_sentence_str += kwtf.execute_sentence(temp[1], Int32.Parse(temp[0]));
                            }
                            else
                            {
                                this.execute_sentence_str = "第" + which_one.ToString() + "条语句输入有错误，本版本还不支持自定义变量，请重新输入该值:" + temp[0];
                                goto loop_false;
                            }
                        }
                        else
                        {
                            this.execute_sentence_str = "第" + which_one.ToString() + "条语句输入有错误,所给参数个数与关键字函数" + temp[i - 1] + "所支持的参数个数不符!";
                            goto loop_false;
                        }
                    }
                    else
                    {
                        this.execute_sentence_str = "第" + which_one.ToString() + "条语句输入有错误,其中含有空的括号运算符,没有可执行的关键字函数！";
                        goto loop_false;
                    }
                }
            }
        }
        return true;
    loop_false:
        return false;
    }
}
