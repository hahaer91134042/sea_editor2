----
require("debug")

Rule =
{
    RULE_ROUND_NUM = 0, -- 局数
    RULE_MAH_BASE_SCORE = 1, -- 底分
    RULE_MAH_FLOWER_SCORE = 2, -- 花分
    RULE_MAH_MAX_SCORE = 3, -- 勒子封顶
    RULE_MAH_DISABLE_CHOW = 4, -- 不可吃
    RULE_MAH_DISABLE_IP = 5, -- 同IP限制
    RULE_MAH_ZHUO_CHONG = 6, -- 捉铳条件 (无限制、一模二铳、二摸三铳)
    RULE_MAH_HUANG_FAN = 7, -- 荒番
    RULE_MAH_KAI_BAO = 8, -- 开宝
    RULE_MAH_FLY_CANGYING = 9, -- 飞苍蝇
    RULE_MAH_7PAIR = 10, -- 七对
	RULE_MAH_BAOSANKOU_FACTOR = 12, -- 包三口（0: 禁止; 3:3家; 5:5家）
};

MAHCmdTime =
{
	SEAT = 0, -- 选座位（投骰子）
	WIND = 1, -- 选风向（座位头家）
	DICE = 2, -- 选起牌方向（庄家）
	BUILD = 3, -- 起牌间隔
	DRAW = 4, -- 出牌间隔
	CHOW = 5, -- 吃碰杠胡考虑间隔
};

