<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>编程自控机器人</title>
 <script type="text/javascript">
 var keywords = new Array();
 var argsofkeywords = new Array();
 var value = "";
 var count = 0;
 var m_count = 0;
 var iID = null;
 var iID1 = null;
 var iID2 = null;
 
 var cycle_counts = 0;
 var cycle_value = "";
     function thisMovie(movieName) {
         if (navigator.appName.indexOf("Microsoft") != -1) {
             return window[movieName];
         } else {
             return document[movieName];
         }
     }
     function analysis_keywords()
     {
        var temp_str = "";  
        var keywords_len = value.length;
        //alert(keywords_len);
        for(var i = 0, j = 0;i < keywords_len;i++)
        {
           if(value[i] != ',')
           {
           //alert(value[i]);
              temp_str += value[i];
           }
           else
           {
              analysis_result(temp_str,j,temp_str.length);
              j++;
              temp_str = "";
           }  
           
        }
     }
     function analysis_result(result_one,n,temp_len)
     {
        var temp_keyword = "";
        var temp_argsofkeyword = ""; 
        var flag = 1;
        for(var k =0;k < temp_len; k++)
        {
           if(result_one[k] != ':' && flag == 1)
           {
              temp_keyword += result_one[k];
           }
           else
           {
              flag = -1;
              if(result_one[k] != ':')
              {
                temp_argsofkeyword += result_one[k];
              }
           }
        }
        count = n;
        keywords[n] = temp_keyword;
        argsofkeywords[n] = temp_argsofkeyword;
        //alert(n);
        //alert(keywords[n]);
        //alert(argsofkeywords[n]);
     }
     function get_value(res)
     {
        //alert(res.value);
        value = res.value;
        //alert(value);
        //alert(value.length);
        if(value.length != 0)
        {
            //alert("OK");
            //alert(value[0]);
            analysis_keywords();
            //alert(count);
            //alert(keywords[0]);
            //alert(argsofkeywords[0]);
            m_count = -1;
            tempcontrolRobot();
            
        }
     }
     function click_execute(){
       _Default.Execute_Result(get_value);
     }
     function tempcontrolRobot()
     {
        m_count++;
        if(m_count <= count)
        {
        //for(var m = 0; m <= count; m++)
          //  {
                cycle_counts = Number.parseInvariant(argsofkeywords[m_count]);
                cycle_value = keywords[m_count];
                
                if(iID != null)
                {
                   clearTimeout(iID);
                }
                //alert(cycle_counts);
                //alert(cycle_value);
                //iID = setInterval(controlRobot,2000);
                iID1 = setTimeout(controlRobot,500);
           // }
        }
     }
     function controlRobot(){ 
        
        cycle_counts--;
        if(cycle_counts < 0)
        {
           //clearInterval(iID);
           clearTimeout(iID1);
           clearTimeout(iID2);
           
           iID = setTimeout(tempcontrolRobot,500);
           
        }
        else
        {
        asfunc(cycle_value);
        if(iID2 != null)
        {
           clearTimeout(iID2);
        }
           iID2 = setTimeout(controlRobot,2000);
        }
       
     }
     function asfunc(result) {
         thisMovie("jstoflash").asfunc(result);
     }

 </script>
 <script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
</head>
<body>
 
    
<script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab','name','jstoflash','width','560','height','640','id','jstoflash','movie','JsToFlash','quality','high','bgcolor','#FFFFCC','allowscriptaccess','sameDomain' ); //end AC code 
</script>
    
<noscript>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
             codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab" name="jstoflash" width="560" height="640"id="jstoflash">
         <param name="movie" value="JsToFlash.swf" />
         <param name="quality" value="high" />
         <param name="bgcolor" value="#FFFFCC" />
         <param name="allowScriptAccess" value="sameDomain" />
         <embed src="FlashToJs.swf" quality="high" bgcolor="#FFFFCC"
             width="560" height="640" name="ExternalInterfaceExample" align="middle"
             play="true" loop="false" quality="high" allowScriptAccess="sameDomain"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer">
         </embed>
</object>
 </noscript>
 
 
 <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <asp:TextBox ID="txt_Terminal" runat="server" BackColor="#C0C5D8" 
            BorderColor="Silver" BorderStyle="Inset" Font-Size="Large" Height="132px" 
            TextMode="MultiLine" Width="545px"></asp:TextBox>
        <br />
                <br />
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" BackColor="#AEB748" BorderStyle="None" 
            Font-Size="X-Large" Height="30px" Text="编译" Width="64px"/>
                <br />
        <br />
        <asp:Button ID="btn_Execute" runat="server" BackColor="#AEB748" BorderStyle="None" 
            Font-Size="X-Large" Height="30px" Text="执行" 
            Width="64px" Enabled="False" />
&nbsp;&nbsp;&nbsp;<br />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    
        <br />
    
        <br />
        <asp:Label ID="Label2" runat="server"></asp:Label> 
     </ContentTemplate>
     </asp:UpdatePanel>
     </div>
    </form>
</body>
</html>
