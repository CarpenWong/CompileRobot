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
///CharactersAnalysis 的摘要说明
/// </summary>
public class CharactersAnalysis
{
    private string characteranalysis;
    public string ResultOfCharacterAnalysis
    {
        get { return this.characteranalysis; }
    }

	public CharactersAnalysis()
	{
        this.characteranalysis = "";
	}

    public bool CharacterAnalysisCheck(string sentence_str, int which_one)
    {
        return this.characters_analysis(sentence_str, which_one);
    }

    //字节流解析过程，用于判断句点之前是否出现非法的字符串，
    //并生成字节流，用于词法分析过程;其中生成的字节流已经将
    //空格和回车换行符去除
    //
    private bool characters_analysis(string sentence_str, int which_one)
    {
        string characters_str = "";
        int len = 0;

        string reg_str = "(?<words>\\S+)";
        MatchCollection matches = DataRegexAnalysis.regex_value(reg_str, sentence_str);

        foreach (Match match in matches)
        {
            string result_str = match.Result("${words}");
            if (!result_str.Equals(""))
            {
                characters_str += result_str;
            }
        }

        len = characters_str.Length;

        if (!characters_str[0].Equals('('))
        {
            string temp = "";
            int j = 0;
            while (!characters_str[j].Equals('('))
            {
                temp += characters_str[j];
                j++;
            }
            this.characteranalysis = "第" + which_one.ToString() + "个语句的语法不正确！" + "不知道的语法过程" + temp;
            goto loop_false;
            //return false;
        }
        else if (!characters_str[len - 2].Equals(')'))
        {
            string temp = "";
            int j = len - 1;
            while (!characters_str[j].Equals(')'))
            {
                j--;
            }
            while (j < len - 2)
            {
                temp += characters_str[j + 1];
                j++;
            }
            this.characteranalysis = "第" + which_one.ToString() + "个语句的语法不正确！" + "不知道的语法过程" + temp;
            goto loop_false;
            //return false;
        }
        else
        {
            len = 0;
            characters_str = "";
            foreach (Match match in matches)
            {
                len = characters_str.Length;
                string result_str = match.Result("${words}");
                if (!result_str.Equals(""))
                {
                    int result_len = result_str.Length;
                    if (result_len >= 2)
                    {
                        int result_i = 0;
                        while (result_i < result_len - 1)
                        {
                            if (!result_str[result_i].Equals('(') && result_str[result_i + 1].Equals('('))
                            {
                                string result_substring1 = result_str.Substring(0, result_i + 1);
                                string result_substring2 = result_str.Substring(result_i + 1, result_len - result_i - 1);
                                result_str = result_substring1 + " " + result_substring2;
                                result_i++; result_len++;
                            }
                            if (result_str[result_i].Equals(')') && (!result_str[result_i + 1].Equals(')') && !result_str[result_i + 1].Equals('.')))
                            {
                                string result_substring1 = result_str.Substring(0, result_i + 1);
                                string result_substring2 = result_str.Substring(result_i + 1, result_len - result_i - 1);
                                result_str = result_substring1 + " " + result_substring2;
                                result_i++; result_len++;
                            }
                            result_i++;
                        }
                    }
                    if (characters_str.Equals("") || characters_str[len - 1].Equals('(') || result_str.Equals(")") || result_str.Equals("."))
                        characters_str += result_str;
                    else
                    {
                        if (characters_str[characters_str.Length - 1].Equals(')') && result_str[0].Equals(')'))
                        {
                            characters_str += result_str;
                        }
                        else
                        {
                            characters_str += " " + result_str;
                        }
                    }
                }
            }
            WordsAnalysis wa = new WordsAnalysis();
            if (!wa.wordsAnalysisCheck(characters_str, which_one))//词法分析过程
            {
                this.characteranalysis = wa.ResultWordAnalysis;
                goto loop_false;
                //return false;
            }
            else
            {
                this.characteranalysis = wa.ResultWordAnalysis;
                //return true;
            }
        }
        return true;
    loop_false:
        return false;
    }
}
