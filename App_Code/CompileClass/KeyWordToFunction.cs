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
///KeyWordToFunction 的摘要说明
/// </summary>
public class KeyWordToFunction
{
    public string execute_str;
    private string total_execute_str;
	public KeyWordToFunction()
	{
        execute_str = "";
        total_execute_str = "";
	}
    public string execute_sentence(string sentence,int step)
    {
        switch (sentence)
        {
            case "go": scm_go(step); break;
            case "jump": scm_jump(step); break;
            case "back": scm_back(step); break;
            case "turn": scm_turn(); break;
            case "push": scm_push(); break;
            case "put": scm_put(); break;
            case "pick": scm_pick(); break;
            case "godown": scm_godown(step); break;
            case "goleft": scm_goleft(step); break;
            case "goright": scm_goright(step); break;
            case "goup": scm_goup(step); break;
            case "start": scm_start(); break;
            case "next": scm_next(); break;
        }
        return this.total_execute_str;
    }
    private void scm_godown(int step)
    {
        execute_str += "机器人向下移动了" + step.ToString() + "步，";
        this.total_execute_str += "godown:" + step.ToString()+",";
    }
    private void scm_goleft(int step)
    {
        execute_str += "机器人向左移动了" + step.ToString() + "步，";
        this.total_execute_str += "goleft:" + step.ToString() + ",";
    }
    private void scm_goright(int step)
    {
        execute_str += "机器人向右移动了" + step.ToString() + "步，";
        this.total_execute_str += "goright:" + step.ToString() + ",";
    }
    private void scm_goup(int step)
    {
        execute_str += "机器人向上移动了" + step.ToString() + "步，";
        this.total_execute_str += "goup:" + step.ToString() + ",";
    }
    private void scm_start()
    {
        execute_str += "游戏开始：";
        this.total_execute_str += "start:1,";
    }
    private void scm_next()
    {
        execute_str += "进入下一关游戏，";
        this.total_execute_str += "next:1,";
    }
    private void scm_go(int step)
    {
        execute_str += "机器人向前移动了"+step.ToString()+"步，";
    }
    private void scm_jump(int step)
    {
        execute_str += "机器人向上方跳了" + step.ToString() + "步,";
    }
    private void scm_back(int step)
    {
        execute_str += "机器人向后退了" + step.ToString() + "步,";
    }
    private void scm_turn()
    {
        execute_str += "机器人转了个方向，";
        this.total_execute_str += "turn:1,";
    }
    private void scm_push()
    {
        execute_str += "机器人向前推了一块冰块,";
    }
    private void scm_put()
    {
        execute_str += "机器人向自己的斜下方放了一块冰块,";
    }
    private void scm_pick()
    {
        execute_str += "机器人消解了一块自己斜下方的冰块,";
    }
}