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
using RobotDataSetTableAdapters;

/// <summary>
///Manager_InfoBLL 的摘要说明
/// </summary>
/// 
[System.ComponentModel.DataObject]
public class Manager_InfoBLL
{
    private Manager_InfoTableAdapter _managerinfoAdapter = null;
    protected Manager_InfoTableAdapter Adapter
    {
        get
        {
            if (this._managerinfoAdapter == null)
                this._managerinfoAdapter = new Manager_InfoTableAdapter();
            return this._managerinfoAdapter;
        }
    }

    //查询所有管理员的详细信息
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public RobotDataSet.Manager_InfoDataTable GetManagerInfo()
    {
        return this.Adapter.GetManagerInfo();
    }

    //查询管理员的用户名密码是否匹配
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
    public bool CheckManagerIDMatchPasswd(string Manager_ID, string Manager_Password)
    {
        if (Manager_ID.Equals("") || Manager_Password.Equals(""))
            return false;
        else
        {
            RobotDataSet.Manager_InfoDataTable managerinfos;
            managerinfos = Adapter.CheckManagerIDAndPasswd(Manager_ID, Manager_Password);
            if (managerinfos.Count != 0)
                return true;
            else
                return false;
        }
    }
    //添加管理员
    //insert方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public bool AddManager(string Manager_ID, string Manager_Password)
    {
        RobotDataSet.Manager_InfoDataTable managerinfos = new RobotDataSet.Manager_InfoDataTable();
        RobotDataSet.Manager_InfoRow managerinfo = managerinfos.NewManager_InfoRow();

        if (Manager_ID.Equals("") || Manager_Password.Equals(""))
            return false;
        else
        {
            RobotDataSet.Manager_InfoDataTable is_managerinfos;
            is_managerinfos = this.Adapter.GetManagerInfoByID(Manager_ID);
            if (is_managerinfos.Count == 0)
            {
                managerinfo.Manager_ID = Manager_ID;
                managerinfo.Manager_Password = Manager_Password;
                managerinfos.AddManager_InfoRow(managerinfo);
                int rowsAffected = Adapter.Update(managerinfos);
                return rowsAffected == 1;
            }
            else
            {
                return false;
            }
        }
    }

    //delete方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
    public bool DeleteManager(string Manager_ID)
    {
        if (Manager_ID.Equals(""))
        {
            return false;
        }
        else
        {
            RobotDataSet.Manager_InfoDataTable managerinfos;
            managerinfos = this.Adapter.GetManagerInfoByID(Manager_ID);
            if (managerinfos.Count == 0)
                return false;
            else
            {
                int rowsAffected = this.Adapter.Delete(Manager_ID);
                return rowsAffected == 1;
            }
        }
    }
    //update方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public bool ModifyManagerInfo(string Manager_Password, string Manager_ID)
    {
        if (Manager_ID.Equals("") || Manager_Password.Equals(""))
            return false;
        else
        {
            RobotDataSet.Manager_InfoDataTable managerinfos = this.Adapter.GetManagerInfoByID(Manager_ID);
            if (managerinfos.Count == 0)
                return false;
            else
            {
                RobotDataSet.Manager_InfoRow managerinfo = managerinfos[0];
                managerinfo.Manager_Password = Manager_Password;
                int rowsAffected = Adapter.Update(managerinfo);
                return rowsAffected == 1;
            }
        }
    }
	public Manager_InfoBLL()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
}
