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
///Player_InfoBLL 的摘要说明
/// </summary>
/// 
[System.ComponentModel.DataObject]
public class Player_InfoBLL
{
    private Player_InfoTableAdapter _playerinfoAdapter = null;
    protected Player_InfoTableAdapter Adapter
    {
        get
        {
            if (this._playerinfoAdapter == null)
                this._playerinfoAdapter = new Player_InfoTableAdapter();
            return this._playerinfoAdapter;
        }
    }
    private Game_InfoTableAdapter _gameinfoAdapter = null;
    protected Game_InfoTableAdapter gameAdapter
    {
        get
        {
            if (this._gameinfoAdapter == null)
                this._gameinfoAdapter = new Game_InfoTableAdapter();
            return this._gameinfoAdapter;
        }
    }

    //默认的select方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
    public RobotDataSet.Player_InfoDataTable GetPlayerInfos()
    {
        return Adapter.GetData();
    }
    //带参数的select方法
    //查询用户名和密码是否匹配
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
    public bool CheckPlayerIDAndPasswd(string Player_ID, string Player_Password)
    {
        if (Player_ID.Equals("") || Player_Password.Equals(""))
        {
            return false;
        }
        else
        {
            RobotDataSet.Player_InfoDataTable playerinfos;
            playerinfos = Adapter.CheckPlayerAndPasswd(Player_ID, Player_Password);
            if (playerinfos.Count != 0)
                return true;
            else
                return false;
        }
    }

    //带参数的select方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
    public RobotDataSet.Player_InfoDataTable GetPlayerInfoByID(string Player_ID)
    {
        RobotDataSet.Player_InfoDataTable playerinfos;
        playerinfos = Adapter.GetPlayerInfoByID(Player_ID);
        if (playerinfos.Count == 0)
        {
            return null;
        }
        else
        {
            return playerinfos;
        }
    }

    //insert
    //参数中带？表示该参数可以为空
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
    public bool RegisterPlayer(string Player_ID, string Player_Password, int Player_Score, int Player_Round,String Player_Email)
    {
        RobotDataSet.Player_InfoDataTable playerinfos = new RobotDataSet.Player_InfoDataTable();
        RobotDataSet.Player_InfoRow playerinfo = playerinfos.NewPlayer_InfoRow();

        if (Player_ID.Equals("") || Player_Password.Equals("") || Player_Round.Equals(0))
        {
            return false;
        }
        else
        {
            //查看游戏表中是否含有插入的该关信息
           
            RobotDataSet.Game_InfoDataTable gameinfos = gameAdapter.GetGameInfoByRound(Player_Round);

            if (gameinfos.Count == 0)
            {
                return false;
           }
            else
            {
                RobotDataSet.Player_InfoDataTable is_playerinfos;
                is_playerinfos = Adapter.GetPlayerInfoByID(Player_ID);
                if (is_playerinfos.Count == 0)
               {
                    playerinfo.Player_ID = Player_ID;
                    playerinfo.Player_Password = Player_Password;
                    playerinfo.Player_Score = Player_Score;
                    playerinfo.Player_Round = Player_Round;

                    playerinfo.Player_Email = Player_Email;

                   //添加新用户
                    playerinfos.AddPlayer_InfoRow(playerinfo);

                    int rowsAffected = Adapter.Update(playerinfos);

                    return rowsAffected == 1;
                }
                else
                {
                    return false;
                }
            }
        }
    }

    //delete方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
    public bool DeletePlayer(string Player_ID)
    {
       /* if (Player_ID.Equals(""))
        {
            return false;
        }
        else
        {
            RobotDataSet.Player_InfoDataTable playerinfos;
            playerinfos = Adapter.GetPlayerInfoByID(Player_ID);
            if (playerinfos.Count == 0)
            {
                return false;
            }
            else
            {*/
                int rowsAffected = Adapter.Delete(Player_ID);
                return rowsAffected == 1;
         //   }
       // }
    }

    //update方法
    [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
    public bool ModifyPlayer(string Player_Password, int Player_Score, int Player_Round, string Player_ID, string Player_Email)
    {
        /* if (Player_ID.Equals("") || Player_Password.Equals("") || Player_Round.Equals(0))
         {
             return false;
         }
         else
         {*/
        //  RobotDataSet.Game_InfoDataTable gameinfos = this.gameAdapter.GetGameInfoByRound(Player_Round);

        /*     if (gameinfos.Count == 0)
             {
                 return false;
             }
             else
             {*/
        RobotDataSet.Player_InfoDataTable playerinfos;
        playerinfos = Adapter.GetPlayerInfoByID(Player_ID);
        if (playerinfos.Count == 0)
        {
            return false;
        }
        else
        {
            RobotDataSet.Player_InfoRow playerinfo = playerinfos[0];

            playerinfo.Player_Password = Player_Password;
            playerinfo.Player_Score = Player_Score;
            playerinfo.Player_Round = Player_Round;
            playerinfo.Player_Email = Player_Email;


            int rowsAffected = Adapter.Update(playerinfo);
            return rowsAffected == 1;
        }
    }
          //  }
     //   }
   // }
	public Player_InfoBLL()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
}
