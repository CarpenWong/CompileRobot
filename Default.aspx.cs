using System;
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

public partial class _Default : System.Web.UI.Page 
{
    private SentenceAnalysis sa;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(_Default));
        this.btn_Execute.Attributes["onclick"] = "javascript:click_execute();";
        if (!this.IsPostBack)
        {
            this.Label1.Text = "第一次加载！";
        }
    }
    [AjaxPro.AjaxMethod]
    public string Execute_Result()
    {
        //this.btn_Execute.Enabled = false;
        return Session["resultTojs"].ToString();
        //return "godown";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (execute())
        {
            //int len = sa.ReusltTotalSentenceExecute.Length;
            Session["resultTojs"] = sa.ReusltTotalSentenceExecute;
            this.Label2.Text = "执行完毕!";
            this.btn_Execute.Enabled = true;

        }
        else
        {
            Session["resultTojs"] = "";
        }
    }
    private bool execute()
    {
        this.btn_Execute.Enabled = false;
        bool is_success = false;
        this.Label1.Text = "";
        this.Label2.Text = "";
        sa = new SentenceAnalysis();
        string scm_code_str = "";
        scm_code_str = this.txt_Terminal.Text.Trim().ToLower();
        int len = scm_code_str.Length;
        if (!scm_code_str.Equals(""))
        {
            if (scm_code_str[len - 1] == '.')
            {
                if (sa.sentenceAnalysisCheck(scm_code_str))
                {
                    this.Label1.Text = sa.ResultSentenceAnalysis;
                    //this.Label2.Text = sa.ReusltTotalSentenceExecute;
                    is_success = true;
                }
                else
                {
                    this.Label1.Text = sa.ResultSentenceAnalysis;
                }
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
        return is_success;
    }
}
