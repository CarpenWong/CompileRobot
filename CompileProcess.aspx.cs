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

public partial class CompileProcess : System.Web.UI.Page
{
    private SentenceAnalysis sa;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_execute_Click(object sender, EventArgs e)
    {
        this.Label1.Text = "";
        this.Label2.Text = "";
        sa = new SentenceAnalysis();
        string scm_code_str = "";
        scm_code_str = this.TextBox1.Text.Trim().ToLower();
        int len = scm_code_str.Length;
        if (!scm_code_str.Equals(""))
        {
            if (scm_code_str[len - 1] == '.')
            {
                if (sa.sentenceAnalysisCheck(scm_code_str))
                {
                    this.Label1.Text = sa.ResultSentenceAnalysis;
                    this.Label2.Text = sa.ReusltTotalSentenceExecute;
                }
                else
                    this.Label1.Text = sa.ResultSentenceAnalysis;
            }
            else
            {
                this.Label1.Text = "语句没有正常结束！";
            }
        }
        else
        {
            this.Label1.Text = "没有可执行的语句重新输入！";
        }
    }
}
