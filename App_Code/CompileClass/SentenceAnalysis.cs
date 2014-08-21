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
///SentenceAnalysis 的摘要说明
/// </summary>
public class SentenceAnalysis
{
    private string sentenceanalysis_str;
    private string total_sentence_execute;
    private BracketPairs bkp;

    public string ResultSentenceAnalysis
    {
        get { return this.sentenceanalysis_str; }
    }

    public string ReusltTotalSentenceExecute
    {
        //get { return "总的执行结果是："+this.total_sentence_execute + "执行结束。"; }
        get { return this.total_sentence_execute; }
    }

	public SentenceAnalysis()
	{
        this.sentenceanalysis_str = "";
        this.total_sentence_execute = "";
        this.bkp = new BracketPairs();
	}

    public bool sentenceAnalysisCheck(string sentence_str)
    {
        return this.sentence_analysis(sentence_str);
    }

    //该函数用于对所输入的每一条语句进行解析，首先用正则表达式取出每一条语句，然后进行字节码解析，
    //词法解析解析，语法解析和语义解析；如果中间有哪一个解析不能通过就返回一个false，解析终止；
    //并给出一个出错提示，同时给出是哪一个语句出的错
    //
    private bool sentence_analysis(string sentence_str)
    {
        int execute_done_count = 0;//已经执行过的语句的个数

        string reg_str = "(?<sentence>[^\\.]*\\.)";//匹配所输入的每一条语句
        MatchCollection matches = DataRegexAnalysis.regex_value(reg_str, sentence_str);

        foreach (Match match in matches)
        {
            string each_sentence = match.Result("${sentence}");
            if (!each_sentence.Equals(""))
            {
                if (!bkp.bracket_pairs_check(each_sentence, execute_done_count + 1))//判断括号是否匹配
                {
                    this.sentenceanalysis_str = bkp.Result_bracketpairs;
                    goto loop_false;
                    //break;
                }
                else
                {
                    this.sentenceanalysis_str += "第" + (execute_done_count + 1).ToString() + "条语句的执行结果是：" + bkp.Result_bracketpairs+"执行结束。";
                    this.total_sentence_execute += bkp.Result_bracketpairs;
                }
                execute_done_count++;
            }
        }
        //if (execute_done_count == matches.Count)//如果已经执行过的语句与所读取出的语句的个数相同；
        //    return true;                        //那么表示所有的语句已经成功执行完毕
        //else
        //    return false;
        return true;
    loop_false:
        return false;
    }
}
