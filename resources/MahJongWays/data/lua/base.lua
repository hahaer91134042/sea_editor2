--
--[[
	角色属性定义
    PLAYER_RD_PLAYERID = 0,
    PLAYER_RD_NAME = 1,
    PLAYER_RD_VIP = 2,
    PLAYER_RD_VIGOUR_POINT = 3,
    PLAYER_RD_VIGOUR_TIME = 4,
    PLAYER_RD_LEVEL = 5,
    PLAYER_RD_EXP = 6,
    PLAYER_RD_MONEY = 7,
    PLAYER_RD_RMB = 8,
	PLAYER_RD_SIGNDATE = 9,

--]]

function lfx_get_signgift(player)
	local item,num,vip_level,vip_num = cfx_query_signgift(player);
	local player_vip = cfx_player_get_info(player, PLAYER_RD_VIP);
	if player_vip >= vip_level then
		num = num + vip_num;
	end

	return item,num;
end

