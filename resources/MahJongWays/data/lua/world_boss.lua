-- ����Boss

-- ����boss����
g_boss_list =
{
		{ 
	    id = 1,                                         -- BOSS���
		image = 1,                                      -- BOSSͼ��		
		name = "������ħ",                        	    -- BOSS����
		scnario = 2200,                                 -- �����ؿ����
		blood = 63656250,								-- ��ʼѪ��
		level = {30, 44},								-- �ȼ���ΧҪ��
		fight_cd = 90,									-- ��սCD���룩
		vigour = 10,									-- ��������
		open_day = {1,2,3,4,5,6,7},						-- ��������
		open_time = {{"00:00", "20:30"},},				-- ���ֹʱ��  
		desc = "��ħ�ٴ���Ϯ�����ɣ�����ʷ���������ӵ���ɣ�", 	    	-- BOSS����
	},
	{ 
	    id = 2,                                         -- BOSS���
		image = 2,                                      -- BOSSͼ��
		name = "���챳����",                              -- BOSS����
		scnario = 2201,                                 -- �����ؿ����
		blood = 65250000,								-- ��ʼѪ��
		level = {45, 59},								-- �ȼ���ΧҪ��
		fight_cd = 90,									-- ��սCD���룩
		vigour = 10,									-- ��������
		open_day = {1,2,3,4,5,6,7},						-- ��������
		open_time = {{"00:00", "20:30"},},				-- ���ֹʱ��  
		desc = "������������߰�����Ҫ�������������ѧ��ѧУʳ�����50�ײ����ſڼ�����", 				    -- BOSS����
	},
	{ 
	    id = 3,                                         -- BOSS���
		image = 3,                                      -- BOSSͼ��
		name = "ħ��֮��",                              -- BOSS����
		scnario = 2202,                                 -- �����ؿ����
		blood = 93375000,								-- ��ʼѪ��
		level = {60, 74},								-- �ȼ���ΧҪ��
		fight_cd = 90,									-- ��սCD���룩
		vigour = 10,									-- ��������
		open_day = {1,2,3,4,5,6,7},						-- ��������
		open_time = {{"20:00", "20:30"},},				-- ���ֹʱ��  
		desc = "������������߰�����Ҫ�������������ѧ��ѧУʳ�����50�ײ����ſڼ�����", 				    -- BOSS����
	},	
}

-- ��������
g_inspire_attr =
{
    {
	    id = 1,                                 -- buff���
		image = 111,                              -- buffͼ��
		desc = "������,ħ������",    -- buff����
		val1 = 10,                              -- ����1��ֵ���ٷֱȣ�
		val2 = 10,                              -- ����2��ֵ���ٷֱȣ�
	},
    {
	    id = 2,                                 -- buff���
		image = 112,                              -- buffͼ��
		desc = "Ѫ������,������",              -- buff����
		val1 = 10,                              -- ����1��ֵ���ٷֱȣ�
		val2 = 2,                               -- ����2��ֵ���ٷֱȣ�
	},
}

-- �����������
g_inspire_config =
{
    gold_inspire_price = 10000,             -- ��ҹ��迪��
    gold_inspire_rate = 50,                 -- ��ҹ���ɹ��ʣ��ٷֱȣ�
	rmb_inspire_price = 20,                 -- ��ʯ���迪��
	rmb_inspire_rate = 100,                 -- ��ʯ����ɹ��ʣ��ٷֱȣ�
	max_inspire_count = 10,                 -- �����������
}

-- �����ڲ����ú���������boss�б�
function lfx_worldboss_get_boss_list()
	return g_boss_list
end

-- �����ڲ����ú��������ع�������
function lfx_worldboss_get_inspire_attr()
    return g_inspire_attr
end

-- �����ڲ����ú��������ع����������
function lfx_worldboss_get_inspire_config()
    return g_inspire_config
end