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
///Game_InfoBLL 的摘要说明
/// </summary>
/// 
[System.ComponentModel.DataObject]//通过属性可以设置为是dataobject的类
public class Game_InfoBLL
{
    private Game_InfoTableAdapter _gameinfoTableAdapter = null;
    protected Game_InfoTableAdapter Adapter
    {
        get
        {
            if (_gameinfoTableAdapter == null)
                this._gameinfoTableAdapter = new Game_InfoTableAdapter();
            return this._gameinfoTableAdapter;
        }
    }

    //select方法
    //为true的话是缺省的选择的方法
    //打包方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public RobotDataSet.Game_InfoDataTable GetGameInfo()
    {
        return Adapter.GetGameInfo();
    }

    //带参数的select方法
    //只能有一个缺省的所以这个需要设置成false
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
    public RobotDataSet.Game_InfoDataTable GetGameInfoByRound(string round)
    {
        if (Game_InfoCatchException.StringIsNumber(round))
        {
            return this.Adapter.GetGameInfoByRound(Int32.Parse(round));
        }
        else
        {
            return null;
        }
    }
    //insert
    //参数中带？表示该参数可以为空
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public bool AddGame(int Game_Round, int Row, int Columns, string Brick_Pos, string Ice_Pos, string Player_Pos)
    {
        // Create a new Game_InfoRow instance
        RobotDataSet.Game_InfoDataTable gameinfos = new RobotDataSet.Game_InfoDataTable();
        RobotDataSet.Game_InfoRow gameinfo = gameinfos.NewGame_InfoRow();

        //字段赋值，string，bool类型直接赋值，其他数值类型赋值 .value
        // 允许为空的字段要先判断后赋值
        if (Game_Round == 0 || Row == 0 || Columns == 0 || Brick_Pos.Equals("") || Ice_Pos.Equals("") || Player_Pos.Equals(""))
        {
            return false;
        }
        else
        {
            RobotDataSet.Game_InfoDataTable is_gameinfos;
            is_gameinfos = Adapter.GetGameInfoByRound(Game_Round);
            if (is_gameinfos.Count == 0)
            {
                gameinfo.Game_Round = Game_Round;
                gameinfo.Row = Row;
                gameinfo.Columns = Columns;
                gameinfo.Brick_Pos = Brick_Pos;
                gameinfo.Ice_Pos = Ice_Pos;
                gameinfo.Player_Pos = Player_Pos;
                gameinfos.AddGame_InfoRow(gameinfo);
                int rowsAffected = Adapter.Update(gameinfos);
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
    public bool DeleteGame(int Game_Round)
    {
        if (Game_Round.Equals(0))
        {
            return false;
        }
        else
        {
            RobotDataSet.Game_InfoDataTable gameinfos;
            gameinfos = Adapter.GetGameInfoByRound(Game_Round);
            if (gameinfos.Count == 0)
            {
                return false;
            }
            else
            {
                int rowsAffected = Adapter.Delete(Game_Round);
                // Return true if precisely one row was deleted,
                // otherwise false
                return rowsAffected == 1;
            }
        }
    }


    //update方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public bool UpdateGame(int Row, int Columns, string Brick_Pos, string Ice_Pos, string Player_Pos, int Game_Round)
    {
        if (Row.Equals(0) || Columns.Equals(0) || Brick_Pos.Equals("") || Ice_Pos.Equals("") || Player_Pos.Equals("") || Game_Round.Equals(0))
        {
            return false;
        }
        else
        {
            RobotDataSet.Game_InfoDataTable gameinfos = Adapter.GetGameInfoByRound(Game_Round);
            if (gameinfos.Count == 0)
                return false;
            else
            {
                RobotDataSet.Game_InfoRow gameinfo = gameinfos[0];
                gameinfo.Row = Row;
                gameinfo.Columns = Columns;
                gameinfo.Brick_Pos = Brick_Pos;
                gameinfo.Ice_Pos = Ice_Pos;
                gameinfo.Player_Pos = Player_Pos;
                int rowsAffected = Adapter.Update(gameinfo);
                return rowsAffected == 1;
            }
        }
    }
	public Game_InfoBLL()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
}
