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
///WordsAnalysis 的摘要说明
/// </summary>
public class WordsAnalysis
{
    private string wordsanalysis_str;

    //在执行语句分析之前,将所有的关键字加入符号表(哈希表)中；
    //该符号表服务于整个过程
    private KeyWordsTable keyWT;

    public string ResultWordAnalysis
    {
        get { return this.wordsanalysis_str; }
    }

	public WordsAnalysis()
	{
        this.wordsanalysis_str = "";
        keyWT = new KeyWordsTable();
	}

    public bool wordsAnalysisCheck(string characters_str, int which_one)
    {
        return this.words_analysis(characters_str, which_one);
    }

    //词法分析过程，查看语法的所有关键字是否是系统已经给定的关键字，
    //因为还不支持自定义函数，所以所有的关键字都是系统已经给定的；
    //如果所有关键字都是正确的，那么生成单词流进行语法分析
    private bool words_analysis(string characters_str, int which_one)
    {
        int count = 0;
        string reg_str = "(?<key_word>\\(\\w+)";
        MatchCollection matches = DataRegexAnalysis.regex_value(reg_str, characters_str);
        foreach (Match match in matches)
        {
            string word_str = match.Result("${key_word}");
            if (!word_str.Equals(""))
            {
                string key_word = word_str.Substring(1);
                if (!keyWT.search_key_word(key_word))
                {
                    this.wordsanalysis_str = "第" + which_one.ToString() + "个语句错误，没有" + key_word + "关键字!";
                    break;
                }
                count++;
            }
        }
        if (count != matches.Count)
        {
            goto loop_false;
            //return false;
        }
        else
        {
            int len = characters_str.Length;
            for (int i = 0; i < len; i++)
            {
                if (characters_str[i].Equals('(') || characters_str[i].Equals(')'))
                {
                    string sub1 = characters_str.Substring(0, i);
                    string sub2 = characters_str.Substring(i + 1, len - i - 1);
                    if (characters_str[i].Equals('('))
                        characters_str = sub1 + " " + "(" + " " + sub2;
                    else
                        characters_str = sub1 + " " + ")" + " " + sub2;
                    i++;
                    len += 2;
                }
            }

            //进行操作符分析，检查其中的操作符是否有不符合要求的操作符
            OperatorsCheck opc = new OperatorsCheck();
            if (!opc.Op_Check(characters_str, which_one))
            {
                this.wordsanalysis_str = opc.Result_OpCheck;
                goto loop_false;
                //return false;
            }
            else
            {
                //进行语义分析，使用语义分析类，返回结果值为false和true，
                //执行后的结果存储在语义分析类的ExeResult字符串中，可读取出来.
                SyntaxAnalysisAndExecute saae = new SyntaxAnalysisAndExecute();
                if (saae.execute_syntax_analysis(characters_str, which_one))
                {
                    this.wordsanalysis_str = saae.ExeResult;
                    //return true;
                }
                else
                {
                    this.wordsanalysis_str = saae.ExeResult;
                    goto loop_false;
                    //return false;
                }
            }
        }
        return true;
    loop_false:
        return false;
    }
}
