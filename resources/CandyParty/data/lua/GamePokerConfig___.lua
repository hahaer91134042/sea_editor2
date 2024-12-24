require("gamelist")

local _PokerSceneCfg = 
{
   {
       gameid = 501;
       classid = 0;
       name = "µÂÖÝÆË¿Ë";
    }
}

function GetPokerCfgList()
	return _PokerSceneCfg 
end

function GetPokerCfglist1(game_id)
for i, v in pairs(_PokerSceneCfg) do  
     if type(v) == "table" then 
         if v[gameid]==game_id then
            return v;
		 end
     end  
 end 
   return nil;
end