
-- ���ɽű�

--[[

enum lxGuildRankEnum
{
    GUILD_RANK_LEADER = 1, // �᳤
    GUILD_RANK_ELDER = 2, // ����
    GUILD_RANK_MEMBER = 3, // ��Ա
};

enum lxGuildAuthorityEnum
{
    GUILD_AUTHORITY_DISBAND =       0x0001, // ��ɢ����
    GUILD_AUTHORITY_LEAVE =         0x0002, // �뿪����
    GUILD_AUTHORITY_ADD_MEMBER =    0x0004, // ���ӳ�Ա
    GUILD_AUTHORITY_DEL_MEMBER =    0x0008, // �Ƴ���Ա
    GUILD_AUTHORITY_SET_GUILD =     0x0010, // �޸Ĺ���
    GUILD_AUTHORITY_CHANGE_RANK =   0x0020, // ������Աְ�񣨲��ܸ��ڵ������Լ���
	GUILD_AUTHORITY_AUTHEN_LEADER = 0x0040, // �����Ϊ�᳤
	GUILD_AUTHORITY_GUILD_MANAGE =  0x0080, // �����������
};

--]]

local _rank_auth =
{
	{
		rank = GUILD_RANK_LEADER, -- �᳤
		auth = 189, -- ���뿪����, �����Ϊ�᳤����������Ȩ��
	},
	{
		rank = GUILD_RANK_ELDER, -- ����
		auth = 78, -- ���ӳ�Ա���Ƴ���Ա�������Ϊ�᳤���뿪����
	},
	{
		rank = GUILD_RANK_MEMBER, -- ��Ա
		auth = 2, -- �뿪����
	},		
}

function lfx_guild_get_rank_auth()
	return _rank_auth;
end
