
--[[
�����ֶ�˵��
id ��ǰ�����ţ���1��ʼ�����Բ������������Ų��ܴ���1023
next_id ������ɺ󴥷�����һ��������ʾ��
image ����ͷ��
text �����ı�
term_type ���񴥷��¼�
term_val �������������ݲ�ͬ��term_type���岻ͬ
award0 ������1
award1 ������2
��ע������ʱ�̣�ͬʱ�ɽ�ȡ�����������ܳ���8��
--]]
g_task_item =
{
	{
		id = 1,
		next_id = {2,3},
		name = "������Ӣ��", 
		image = 1, 
		text = "��ѵ�", 
		term_type = TASK_EVENT_GENERIC, 
		term_val = {0, 0 },
		award0 = { TASK_AWARD_HERO, 1, 2 }, 
		award1 = {TASK_AWARD_INVALID, 3, 4 }
	},
	{
		id = 2,
		next_id = {0},
		name = "�����Ķ�", 
		image = 1, 
		text = "��ѵ�", 
		term_type = TASK_EVENT_DUNGEON_NORMAL, 
		term_val = {1, 0 },
		award0 = { TASK_AWARD_EXP, 100, 0 }, 
		award1 = {TASK_AWARD_MONEY, 300, 0 }
	},
	{
		id = 3,
		next_id = {0},
		name = "�����Ķ�-2", 
		image = 1, 
		text = "��ѵ�", 
		term_type = TASK_EVENT_LEVELUP, 
		term_val = {5, 0 },
		award0 = { TASK_AWARD_EXP, 100, 0 }, 
		award1 = {TASK_AWARD_MONEY, 300, 0 }
	},
}