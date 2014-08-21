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

/// <summary>
///KeyWordsTable 的摘要说明
/// </summary>
public class KeyWordsTable
{
    private Hashtable key_words_set;
	public KeyWordsTable()
	{
        key_words_set = new Hashtable();
        key_words_set_build();
	}

    //建立符号表，表中主要存储的是每一个关键字及其该关键字的参数个数
    private void key_words_set_build()
    {
        //key_words_set.Add("put", "0");
        //key_words_set.Add("jump", "1");
        //key_words_set.Add("go", "1");
        key_words_set.Add("turn", "0");
        //key_words_set.Add("pick", "0");
        //key_words_set.Add("push", "0");
        //key_words_set.Add("back", "1");
        key_words_set.Add("godown", "1");
        key_words_set.Add("goleft", "1");
        key_words_set.Add("goright", "1");
        key_words_set.Add("goup", "1");
        key_words_set.Add("start", "0");
        key_words_set.Add("next", "0");
    }

    //搜寻关键字，查看所执行的命令里是否有该关键字；
    //这些关键字存储在一个哈希表中，这样的话对于以后往里加入关键字很方便；
    //有一定的扩展性
    public bool search_key_word(string key_word)
    {
        if (!key_words_set.ContainsKey(key_word))
        {
            return false;
        }
        return true;
    }
    public int key_word_args(string key_word)
    {
        if (key_words_set.ContainsKey(key_word))
            return Int32.Parse((string)key_words_set[key_word]);
        else
            return -1;
    }
}
