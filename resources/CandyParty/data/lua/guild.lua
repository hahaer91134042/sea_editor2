
-- 帮派脚本

--[[

enum lxGuildRankEnum
{
    GUILD_RANK_LEADER = 1, // 会长
    GUILD_RANK_ELDER = 2, // 长老
    GUILD_RANK_MEMBER = 3, // 会员
};

enum lxGuildAuthorityEnum
{
    GUILD_AUTHORITY_DISBAND =       0x0001, // 解散帮派
    GUILD_AUTHORITY_LEAVE =         0x0002, // 离开帮派
    GUILD_AUTHORITY_ADD_MEMBER =    0x0004, // 增加成员
    GUILD_AUTHORITY_DEL_MEMBER =    0x0008, // 移除成员
    GUILD_AUTHORITY_SET_GUILD =     0x0010, // 修改公告
    GUILD_AUTHORITY_CHANGE_RANK =   0x0020, // 调整成员职务（不能高于调整者自己）
	GUILD_AUTHORITY_AUTHEN_LEADER = 0x0040, // 申请成为会长
	GUILD_AUTHORITY_GUILD_MANAGE =  0x0080, // 公会政务管理
};

--]]

local _rank_auth =
{
	{
		rank = GUILD_RANK_LEADER, -- 会长
		auth = 189, -- 除离开帮派, 申请成为会长的所有其他权限
	},
	{
		rank = GUILD_RANK_ELDER, -- 长老
		auth = 78, -- 增加成员、移除成员、申请成为会长、离开帮派
	},
	{
		rank = GUILD_RANK_MEMBER, -- 成员
		auth = 2, -- 离开帮派
	},		
}

function lfx_guild_get_rank_auth()
	return _rank_auth;
end
