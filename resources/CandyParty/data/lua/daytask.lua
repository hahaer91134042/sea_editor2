-- ÿ�����񣨻���ű�
-- Author Jack

--[[
#define _DAYTASK_ITEM_NUM 10 // ÿ�������������
#define _MAX_VIP_LEVEL 15 // VIP�ȼ�

BITTAG_DAYTASK_ITEM = 48 * _BITTAG_PITCH + 1, // ÿ����������״̬, _DAYTASK_ITEM_NUM * 5 = 50 bit
--> 385
enum lxTaskAwardEnum
{
    TASK_AWARD_INVALID = 0,		// ��Ч
    TASK_AWARD_RMB = 1,			// ��ʯ
    TASK_AWARD_MONEY = 2,		// ���
    TASK_AWARD_EXP = 3,			// ����	
    TASK_AWARD_VIGOURPOINT = 4,	// ����
    TASK_AWARD_ITEM = 5,		// ����
};

enum lxTaskEventEnum
{
    TASK_EVENT_GENERIC = 0, 		// ������
    TASK_EVENT_CHARGE, 				// ��ֵ
	TASK_EVENT_TIMER, 				// ������� ��ʱ��
	TASK_EVENT_GENERIC_VIP,			// ��ɨǧ�������ڡ�
	TASK_EVENT_BUY_MONEY,			// ��ʯ�ɽ�
	TASK_EVENT_BUY_VIGOUR,			// ��������
    TASK_EVENT_DUNGEON_NORMAL,  	// ��ͨ���������ڡ�
    TASK_EVENT_DUNGEON_ELITE,		// ��Ӣ���������ڡ�
    TASK_EVENT_UPGRADE_HERO_SKILL,	// ��������
	TASK_EVENT_UPGRADE_LEVEL, 		// �ȼ����������ڡ�
	TASK_EVENT_WEAPONS_CANYOU,		//����Ͽ�ȡ����ڡ�
	TASK_EVENT_TREASURE_LAND,		//�ر�֮�ء����ڡ�
	TASK_EVENT_CALL_BOX,			//�ٻ�����
	TASK_EVENT_ARENA_CHALLENGE,		//������ս
	TASK_EVENT_MONTH_CARD,			//�¿�
	TASK_EVENT_DAILY_COIN,			//ɨ��ɽ��	�ճ���ҡ�������
	TASK_EVENT_DAILY_EXP,			//��������	�ճ����顾������
	TASK_EVENT_DAILY_HEROMAT,		//�����	�ճ�Ӣ�����ס�������
	TASK_EVENT_DAILY_WEAPMAT,		//�Ӷ�ֿ�	�ճ�װ�����ס�������
	TASK_EVENT_FORM_PRCTICE,		//���Ŷݼ�	���͡�������
	TASK_EVENT_CASINO,			    //������ʿ	���ѻ���������
	
	
	ͼ����sqlbrowser/icon���棬��Ŷ�Ӧ������image���
};

--]]

-- DBλ��ʶ����
_daytask_bittag_idx = 32;
-- ÿ�������ʶ����
_daytask_bittag_item_pitch = 6;

-- ÿ����������
g_daytask_item =
{
	{
	    id = 1,
		name = "�������", 
		image = 1, 
		text = "ÿ��12:00��14:00����ȡ60������", 
		term_type = TASK_EVENT_TIMER, 
		term_val = {12, 14 },
		award0 = {TASK_AWARD_RMB, 30, 0 },
		award1 = { TASK_AWARD_VIGOURPOINT, 60, 0 }
	 
	},
	{ 
	    id = 2,
		name = "�������", 
		image = 1, 
		text = "ÿ��18:00��20:00����ȡ60������", 
		term_type = TASK_EVENT_TIMER, 
		term_val = {18, 20 },
		award0 = {TASK_AWARD_RMB, 20, 0 },
		award1 = { TASK_AWARD_VIGOURPOINT, 60, 0 }
	 
	},
	{ 
	    id = 3,
		name = "����ҹ��", 
		image = 1, 
		text = "ÿ��21:00��23:00����ȡ60������", 
		term_type = TASK_EVENT_TIMER, 
		term_val = {21, 23 },
		award0 = {TASK_AWARD_RMB, 10, 0 },
		award1 = { TASK_AWARD_VIGOURPOINT, 60, 0 }
	 
	},
	{ 
	    id = 4,
		name = "��ɨǧ��", 
		image = 2, 
		text = "VIP���ÿ��������ȡɨ�����֤", 
		term_type = TASK_EVENT_GENERIC_VIP, 
		term_val = { 0, 0 }, 
		award0 = {TASK_AWARD_ITEM, 999, 30 }, 
		award1 = { TASK_AWARD_INVALID, 0, 0 } 
	 
	},
	{
	    id = 5, 
		name = "��ʯ�ɽ�", 
		image = 3, 
		text = "����ʯ����1�ν��", 
		term_type = TASK_EVENT_BUY_MONEY, 
		term_val = { 1, 0 }, 
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 }
		
	},
	{ 
	    id = 6,
		name = "��������", 
		image = 4, 
		text = "����ʯ����1������", 
		term_type = TASK_EVENT_BUY_VIGOUR, 
		term_val = { 1, 0 }, 
		award0 = {TASK_AWARD_EXP, 200, 0 },  		
		award1 = { TASK_AWARD_RMB, 5, 0 }
		
	},	
	{ 
	    id = 7,
		name = "����ɱ��", 
		image = 5, 
		text = "������⸱��10��", 
		term_type = TASK_EVENT_DUNGEON_NORMAL,
		term_val = { 10, 0 },
		award0 = {TASK_AWARD_EXP, 300, 0 },  
		award1 = { TASK_AWARD_RMB, 5, 0 }  
	},	
	{ 
	    id = 8,
		name = "��Ӣɱ��", 
		image = 6, 
		text = "������⾫Ӣ����3��", 
		term_type = TASK_EVENT_DUNGEON_ELITE,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 300, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
		
	},
	{
	    id = 9, 
		name = "��������", 
		image = 7, 
		text = "�������⼼��3��", 
		term_type = TASK_EVENT_UPGRADE_HERO_SKILL,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	
	
	{ 
	    id = 10,
		name = "�鵽����", 
		image = 14, 
		text = "��ȡ5�����ⱦ��", 
		term_type = TASK_EVENT_CALL_BOX,
		term_val = { 5, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{
	    id = 11, 
		name = "�ر�֮��", 
		image = 15, 
		text = "��ɲر�֮��2��", 
		term_type = TASK_EVENT_TREASURE_LAND,
		term_val = { 2, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{ 
	    id = 12,
		name = "����Ͽ��", 
		image = 16, 
		text = "�������Ͽ��3��", 
		term_type = TASK_EVENT_WEAPONS_CANYOU,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{ 
	    id = 13,
		name = "��������", 
		image = 17, 
		text = "�ھ��������3����ս", 
		term_type = TASK_EVENT_ARENA_CHALLENGE,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{ 
	    id = 14,
		name = "�¿�����", 
		image = 101, 
		text = "�¿��û�ÿ�տ���ȡ��ʯ����", 
		term_type = TASK_EVENT_MONTH_CARD,
		term_val = { 0, 0 },
		award0 = {TASK_AWARD_RMB, 100, 0  },
		award1 = { TASK_AWARD_INVALID, 0, 0 } 
	},

}


g_daytask_vip_award =  	
{
	{ TASK_AWARD_ITEM, 999, 30 },
	{ TASK_AWARD_ITEM, 11, 120 },
	{ TASK_AWARD_ITEM, 11, 130 },
	{ TASK_AWARD_ITEM, 11, 140 },
	{ TASK_AWARD_ITEM, 11, 140 },
	{ TASK_AWARD_ITEM, 11, 150 },
	{ TASK_AWARD_ITEM, 11, 160 },
	{ TASK_AWARD_ITEM, 11, 170 },
	{ TASK_AWARD_ITEM, 11, 180 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
}

function lfx_daytask_get_item()
	return g_daytask_item;
end

function lfx_daytask_get_vip_award()
	return g_daytask_vip_award;
end

-- ����ÿ�����񣨵������������ڱ仯���µ�һ�쵽��ʱ��
function lfx_daytask_reset_state(player)
    local bigtag_offset;

	for i = 1, table.getn(g_daytask_item) do
		
		local task = g_daytask_item[i];
	    bittag_offset = _daytask_bittag_idx + _daytask_bittag_item_pitch * task.id;

		-- ��������״̬Ϊδ���״̬��������ɴ���Ϊ0
	    cfx_player_set_bittag(player, bittag_offset, _daytask_bittag_item_pitch, 0);

		-- ֪ͨ�ͻ��˸�������״̬
		cfx_daytask_notify(player, i, 0, 0);
	end
end

-- wparam ������ֵ����ؿ���ţ�Ӣ�۱�ŵȣ�
-- lparam ������ֵ���������̣���ֵ������64���磺�ؿ�ɨ��������Ӣ���Ǽ���
function lfx_daytask_input_event(player, event_type, wparam, lparam)

	local bittag_offset;
	
	for i = 1, table.getn(g_daytask_item) do
		
		local task = g_daytask_item[i];
		if task.term_type == event_type then
			bittag_offset = _daytask_bittag_idx + _daytask_bittag_item_pitch * task.id;
			-- ������״̬
			flag = cfx_player_get_bittag(player, bittag_offset, 2);
			if flag == 2 then
			    if event_type == TASK_EVENT_TIMER then
				    if lparam >= task.term_val[2] then
						-- �������δ�콱���ø��������콱���ѹ��ڣ�
						flag = 1;
						cfx_player_set_bittag(player, bittag_offset, 2, flag);

						-- Ͷ��֪ͨ��Ϣ
						cfx_daytask_notify(player, task.id, flag, 0);
					end
				end
			elseif flag == 0 then
				if event_type == TASK_EVENT_GENERIC_VIP  				-- ��ɨǧ��
					or (event_type == TASK_EVENT_BUY_MONEY)				-- ��ʯ�ɽ�
					or (event_type == TASK_EVENT_BUY_VIGOUR) 			-- ��������
					or (event_type == TASK_EVENT_MONTH_CARD) then		-- �¿�
						local idx = bittag_offset + 2;
						local bit_val = cfx_player_get_bittag(player, idx, 4);
						-- �ж��Ƿ��Ѿ�֪ͨ��
						if bit_val == 0 then
							-- ����״̬
							flag = 2; -- ״̬Ϊ�����
							cfx_player_set_bittag(player, bittag_offset, 2, flag);
							cfx_player_set_bittag(player, idx, 4, 1);
							-- Ͷ��֪ͨ��Ϣ
							cfx_daytask_notify(player, task.id, 2, 1);
						end

				elseif event_type == TASK_EVENT_TIMER then -- ��ʱ�� -- ������͡�ҹ��
					-- �ж�ʱ���
					if lparam >= task.term_val[1] and lparam < task.term_val[2] then
						-- ��õ�ǰtick״̬
						local idx = bittag_offset + 2;
						local bit_val = cfx_player_get_bittag(player, idx, 4);
						-- �ж��Ƿ��Ѿ�֪ͨ��
						if bit_val == 0 then
							-- ����״̬
							flag = 2; -- ״̬Ϊ�����
							cfx_player_set_bittag(player, bittag_offset, 2, flag);
							cfx_player_set_bittag(player, idx, 4, 1);
							-- Ͷ��֪ͨ��Ϣ
							cfx_daytask_notify(player, task.id, 2, 1);
						end
					end
				elseif (event_type == TASK_EVENT_DUNGEON_NORMAL)		-- ��ͨ����
					or (event_type == TASK_EVENT_DUNGEON_ELITE) 		-- ��Ӣ����
					or (event_type == TASK_EVENT_UPGRADE_HERO_SKILL) 	-- ��������	
					or (event_type == TASK_EVENT_WEAPONS_CANYOU)        -- ����Ͽ��
	                or (event_type == TASK_EVENT_TREASURE_LAND)         -- �ر�֮��
	                or (event_type == TASK_EVENT_CALL_BOX)              -- �ٻ�����
	                or (event_type == TASK_EVENT_ARENA_CHALLENGE) then  -- ������ս

					local term_val = task.term_val[1];
					-- ��õ�ǰ��ɴ���
					local idx = bittag_offset + 2;
					local bit_val = cfx_player_get_bittag(player, idx, 4);
					if bit_val < term_val then
						bit_val = bit_val + lparam;
						if bit_val > term_val then
							bit_val = term_val
						end
						-- ˢ����ɴ���
						cfx_player_set_bittag(player, idx, 4, bit_val);
					end
					
					-- Ͷ��֪ͨ��Ϣ
					--local flag;
					--if bit_val >= term_val then
					--	flag = 2;
					--else
					--	flag = 0;
					--end
					local flag = (bit_val >= term_val) and 2 or 0;
					if flag == 2 then
					    -- ��������״̬Ϊ����ɣ�2 - ����ɣ�1 - ����ɣ� 0 - δ��ɣ�
						cfx_player_set_bittag(player, bittag_offset, 2, flag);
					end
					cfx_daytask_notify(player, task.id, flag, bit_val);
							
				end
			end
		end
	end
	
end

-- task_id: Ϊlua������base 1��
-- ����ֵ: 0: ʧ��; 1: �ɹ�; 2: �����
function lfx_daytask_get_award(player, task_id)
	
	-- �жϱ���Ƿ�Խ��
	if task_id > table.getn(g_daytask_item) then
		return 0;
	end
	
	local bittag_offset = _daytask_bittag_idx + _daytask_bittag_item_pitch * task_id;
	-- ������״̬
	local flag = cfx_player_get_bittag(player, bittag_offset, 2);
	if flag == 1 then
		return 2;
	end

	local task = g_daytask_item[task_id];
	
	if task.term_type == DAYTASK_TERM_DUNGEON_NORMAL
		or task.term_type == DAYTASK_TERM_DUNGEON_ELITE
		or task.term_type == DAYTASK_TERM_UPGRADE_SKILL
		or task.term_type == TASK_EVENT_WEAPONS_CANYOU
	    or task.term_type == TASK_EVENT_TREASURE_LAND
	    or task.term_type == TASK_EVENT_CALL_BOX
	    or task.term_type == TASK_EVENT_ARENA_CHALLENGE then
		
		-- �жϴ���
		local bit_val = cfx_player_get_bittag(player, bittag_offset + 2, 4);
		if bit_val < task.term_val[1] then
			return 0;
		end
		
	elseif task.term_type == TASK_EVENT_TIMER then
		local bit_val = cfx_player_get_bittag(player, bittag_offset + 2, 4);
		if bit_val == 0 then
			return 0;
		end
	end
	
	-- ���������״̬��2 - ����ɣ�1 - ����ɣ� 0 - δ��ɣ�
	flag = 1;
	cfx_player_set_bittag(player, bittag_offset, 2, flag);
	
	-- ֪ͨ��Ϣ
	cfx_daytask_notify(player, task_id, flag, 0);
	
	-- ���ͽ�������
	cfx_daytask_add_award(player, task.name, task.award0[1], task.award0[2], task.award0[3]);
	if task.award1[1] ~= TASK_AWARD_INVALID then
		cfx_daytask_add_award(player, task.name, task.award1[1], task.award1[2], task.award1[3]);
	end
	
	return 1;
end

