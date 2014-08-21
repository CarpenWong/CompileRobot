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

//引入支持泛型的collection
using System.Collections.Generic;
using System.Text;
using System.Collections;

/// <summary>
///GenericClass 的摘要说明
/// </summary>
public class GenericClass<T,V>
{
    private T keyfunc;
    private V args;
	public GenericClass()
	{
        keyfunc = default(T);
        args = default(V);
	}
    public GenericClass(T keyfunc_str, V args_str)
    {
        this.args = args_str;
        this.keyfunc = keyfunc_str;
    }
}
