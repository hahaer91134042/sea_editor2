-- �齱ϵͳ�ű�

--[[

// ��������
enum lxLotteryAwardEnum
{
    LOTTERY_AWARD_INVALID = 0,		             // �޽���
    LOTTERY_AWARD_HERO = 1,			             // ����Ӣ�ۣ�Ӣ��ID, �Ǽ�
    LOTTERY_AWARD_ITEM = 2,		                 // ��������, ����ID, ����
};

--]]

------------------------------------------------------------------------------------------------------------------------------------------

-- �齱�����
g_lottery_item_list =
{
	{ 
		id = 1,                                                -- ���
		name = "����ٻ�",                                     -- ����
		text = "ʹ�ý���ٻ����м����и߼�װ���͸�Ʒ��Ӣ��",   -- ����
		free_count = 5,                                        -- ��Ѵ���
		free_interval = 5,                                     -- ��Ѽ��ʱ�䣨���ӣ�
		draw_lottery_cost = 10000,                             -- ���黨�ѽ������
		continous_draw_lottery_discount = 0.9,                 -- �����ۿ���
	},
	{ 
		id = 2,                                                -- ���
		name = "��ʯ�ٻ�",                                     -- ����
		text = "ʹ����ʯ�ٻ����м����и߼�װ���͸�Ʒ��Ӣ��",   -- ����
		free_count = 1,                                        -- ��Ѵ���
		free_interval = 2880,                                  -- ��Ѽ��ʱ�䣨���ӣ�
		draw_lottery_cost = 280,                               -- ����������ʯ����
		continous_draw_lottery_discount = 0.9,                 -- �����ۿ���
	},
}

-- ����Ӣ�۱���б�(��Ҫ����128��)
g_award_hero_list = 
{
    {1,3,5,7,18},  -- ����Ӣ��
	{2,12,15,22,27,31,33,34},  -- ��ӢӢ��
	{10,13,16,19,43,44,45,46,49,50,51,52,53,54},  -- ����Ӣ��
	{8,11,35,36,47,48},  -- ����Ӣ��
}

-- ����Ӣ���Ǽ����ʣ��ֱ��Ӧ1�ǣ�2�ǣ�3�ǳ��ָ��ʰٷֱȣ�
g_award_hero_star_rate =
{
    star_rate = {65, 30, 5}
}

-- �������ߵ��䷽���б���ս�ӵȼ�ÿ10����Ӧһ�����䷽������Ҫ����32����
g_award_item_drop_id_list = 
{
	{2001},                        -- drop_id_10
	{2001,2002},                   -- drop_id_20
	{2001,2002,2003},              -- drop_id_30
	{2001,2002,2003,2004},         -- drop_id_40
	{2001,2002,2003,2004,2005}     -- drop_id_50
}

------------------------------------------------------------------------------------------------------------------------------------------

-- ��ó齱�����
function lfx_lottery_get_item_list()
	return g_lottery_item_list;
end

-- ��ý���Ӣ���б�
function lfx_lottery_get_hero_list()
	return g_award_hero_list;
end

-- ��ý���Ӣ���Ǽ����ʱ�
function lfx_lottery_get_hero_star_rate_list()
	return g_award_hero_star_rate;
end

-- ��ý������ߵ��䷽���б�
function lfx_lottery_get_item_drop_id_list()
    return g_award_item_drop_id_list;
end