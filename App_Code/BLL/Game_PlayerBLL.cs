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
///Game_PlayerBLL 的摘要说明
/// </summary>
/// 
[System.ComponentModel.DataObject]
public class Game_PlayerBLL
{
    private Game_PlayerTableAdapter _gamePlayerTAP = null;
    protected Game_PlayerTableAdapter Adapter
    {
        get
        {
            if (this._gamePlayerTAP == null)
                this._gamePlayerTAP = new Game_PlayerTableAdapter();
            return this._gamePlayerTAP;
        }
    }

    //声明一个游戏表的变量，用于查找游戏某一关Round的外键是否存在
    private Game_InfoTableAdapter _gameinfoTAP = null;
    protected Game_InfoTableAdapter gameAdapter
    {
        get
        {
            if (this._gameinfoTAP == null)
                this._gameinfoTAP = new Game_InfoTableAdapter();
            return this._gameinfoTAP;
        }
    }
    //声明一个玩家表的变量，用于查找玩家ID的外键是否存在
    private Player_InfoTableAdapter _playerinfoTap = null;
    protected Player_InfoTableAdapter playerAdapter
    {
        get
        {
            if (this._playerinfoTap == null)
                this._playerinfoTap = new Player_InfoTableAdapter();
            return this._playerinfoTap;
        }
    }

    //select方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public RobotDataSet.Game_PlayerDataTable GetAllData()
    {
        return this.Adapter.GetData();
    }

    //delete方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
    public bool DeleteGameAndPlayer(string Player_ID)
    {
        if (Player_ID.Equals(""))
            return false;
        else
        {
            RobotDataSet.Game_PlayerDataTable gameplayers;
            gameplayers = Adapter.GetGameAndPlayerByID(Player_ID);
            if (gameplayers.Count == 0)
            {
                return false;
            }
            else
            {
                int rowsAffected = Adapter.Delete(Player_ID);
                return rowsAffected == 1;
            }
        }
    }
    //insert方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public bool ContectGameAndPlayer(string Player_ID,int Game_Round)
    {
        RobotDataSet.Game_PlayerDataTable gameplayers = new RobotDataSet.Game_PlayerDataTable();
        RobotDataSet.Game_PlayerRow gameplayer = gameplayers.NewGame_PlayerRow();
        if (Player_ID.Equals("") || Game_Round.Equals(0))
        {
            return false;
        }
        else
        {
            RobotDataSet.Player_InfoDataTable is_playerinfos;
            is_playerinfos = this.playerAdapter.GetPlayerInfoByID(Player_ID);

            RobotDataSet.Game_InfoDataTable is_gameinfos;
            is_gameinfos = this.gameAdapter.GetGameInfoByRound(Game_Round);

            RobotDataSet.Game_PlayerDataTable is_gameplayers;
            is_gameplayers = this.Adapter.GetGameAndPlayerByID(Player_ID);
            if (is_playerinfos.Count != 0 && is_gameinfos.Count != 0 && is_gameplayers.Count == 0)
            {
                gameplayer.Player_ID = Player_ID;
                gameplayer.Game_Round = Game_Round;
                gameplayers.AddGame_PlayerRow(gameplayer);
                int rowsAffected = Adapter.Update(gameplayers);
                return rowsAffected == 1;

            }
            else
            {
                return false;
            }
        }
    }
    //update方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public bool ModifyGameAndPlayer(int Game_Round, string Player_ID)
    {
        if (Game_Round.Equals(0) || Player_ID.Equals(""))
        {
            return false;
        }
        else
        {
            RobotDataSet.Game_PlayerDataTable gameplayers = Adapter.GetGameAndPlayerByID(Player_ID);
            RobotDataSet.Game_InfoDataTable is_gameinfos = gameAdapter.GetGameInfoByRound(Game_Round);

            if (gameplayers.Count != 0 && is_gameinfos.Count != 0)
            {
                RobotDataSet.Game_PlayerRow gameplayer = gameplayers[0];
                gameplayer.Game_Round = Game_Round;
                int rowsAffected = Adapter.Update(gameplayer);
                return rowsAffected == 1;
            }
            else
            {
                return false;
            }
        }
    }
	public Game_PlayerBLL()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
}
