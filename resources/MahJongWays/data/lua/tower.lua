-- ������

-- Buff����
g_buff_item =
{
	{ 
	    id = 1,                                         -- BUFF���
		image = 1,                                      -- ͼ��
		name = "����",                            		-- BUFF����
		desc = "��������Ӣ�۹�����",					-- BUFF����
	},
	{ 
	    id = 2,                                         -- BUFF���
		image = 2,                                      -- ͼ��
		name = "��׼",                            	    -- BUFF����
		desc = "��������Ӣ��������",					-- BUFF����
	},
	{ 
	    id = 3,                                         -- BUFF���
		image = 3,                                      -- ͼ��
		name = "����",                            		-- BUFF����
		desc = "��������Ӣ��Ѫ��",						-- BUFF����
	},
	{ 
	    id = 4,                                         -- BUFF���
		image = 4,                                      -- ͼ��
		name = "�б�",                            		-- BUFF����
		desc = "��������Ӣ�۱�����",					-- BUFF����
	},
	{ 
	    id = 5,                                         -- BUFF���
		image = 5,                                      -- ͼ��
		name = "����",                            		-- BUFF����
		desc = "��������Ӣ��������",					-- BUFF����
	},
}
	
-- ��ֵ
g_random_value =
{	
	--��Χ�����
	value_range = {2,8,12,16,25}, 	
}	
	
-- ����
g_drop_box =
{	
	--�������ID,20������Ӧ��20������
	drop_id = {2500,2501,2502,2503,2504,2505,2506,2507,2508,2509,2510,2511,2512,2513,2514,2515,2516,2517,2518,2519}, 	
}

-- �����ڲ����ú���������buff�����б�
function lfx_tower_get_buff_item()
	return g_buff_item
end

-- �����ڲ����ú��������������ֵ����
function lfx_tower_get_random_value()
    return g_random_value
end

-- �����ڲ����ú��������ر�������
function lfx_tower_get_drop_box()
    return g_drop_box
end
