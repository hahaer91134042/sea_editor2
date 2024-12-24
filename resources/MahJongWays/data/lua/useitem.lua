
--[[
ʹ�õ��߽ű������ع�������£�
ret_table =
{
	{type, val0, val1},
	{type, val0, val1},
}

type���壬�ο� lxMailItemTypeEnum ö������
val0, val1����type���ͺ���

// ��������
enum lxMailItemTypeEnum
{
	MAIL_ITEM_INVALID = 0, // ��Ч
	MAIL_ITEM_ITEM = 1, // ����
	MAIL_ITEM_ATTR_MONEY = 2, // ��Ǯ
	MAIL_ITEM_ATTR_RMB = 3, // �����
	MAIL_ITEM_ATTR_CREDIT = 4, // ������������
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