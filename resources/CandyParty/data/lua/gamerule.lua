----
require("debug")

Rule =
{
    RULE_ROUND_NUM = 0, -- ����
    RULE_MAH_BASE_SCORE = 1, -- �׷�
    RULE_MAH_FLOWER_SCORE = 2, -- ����
    RULE_MAH_MAX_SCORE = 3, -- ���ӷⶥ
    RULE_MAH_DISABLE_CHOW = 4, -- ���ɳ�
    RULE_MAH_DISABLE_IP = 5, -- ͬIP����
    RULE_MAH_ZHUO_CHONG = 6, -- ׽����� (�����ơ�һģ��率��������)
    RULE_MAH_HUANG_FAN = 7, -- �ķ�
    RULE_MAH_KAI_BAO = 8, -- ����
    RULE_MAH_FLY_CANGYING = 9, -- �ɲ�Ӭ
    RULE_MAH_7PAIR = 10, -- �߶�
	RULE_MAH_BAOSANKOU_FACTOR = 12, -- �����ڣ�0: ��ֹ; 3:3��; 5:5�ң�
};

MAHCmdTime =
{
	SEAT = 0, -- ѡ��λ��Ͷ���ӣ�
	WIND = 1, -- ѡ������λͷ�ң�
	DICE = 2, -- ѡ���Ʒ���ׯ�ң�
	BUILD = 3, -- ���Ƽ��
	DRAW = 4, -- ���Ƽ��
	CHOW = 5, -- �����ܺ����Ǽ��
};

