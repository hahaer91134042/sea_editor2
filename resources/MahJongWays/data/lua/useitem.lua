
--[[
使用道具脚本，返回规则表，如下：
ret_table =
{
	{type, val0, val1},
	{type, val0, val1},
}

type定义，参考 lxMailItemTypeEnum 枚举类型
val0, val1根据type解释含义

// 奖励类型
enum lxMailItemTypeEnum
{
	MAIL_ITEM_INVALID = 0, // 无效
	MAIL_ITEM_ITEM = 1, // 道具
	MAIL_ITEM_ATTR_MONEY = 2, // 金钱
	MAIL_ITEM_ATTR_RMB = 3, // 人民币
	MAIL_ITEM_ATTR_CREDIT = 4, // 竞技场荣誉点
};

--]]

function lfx_useitem_rundrop(player, param0, param1)
	
	local item_buf = cfx_run_itemdrop(player, param0);
	
	local item_ret = {};
	
	for i = 1, table.getn(item_buf) do
		table.insert(item_ret, {MAIL_ITEM_ITEM, item_buf[i][1], item_buf[i][2] });
	end
	
	return item_ret;
	
end