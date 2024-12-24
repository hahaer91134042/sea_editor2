----
require("debug")

local _Currency =
{
	exchange_rate = 10, -- �һ����� 1.0RMB = ?��Ϸ��
	unit = 100, -- ��λ����
}

-- ��öһ�����
function GetExchangeRate()
	return _Currency.exchange_rate
end

function GetCurrencyUnit()
	return _Currency.unit
end

-- ʹ��db���ã��ο�shop table
local _Shop = {}
--[[
local _Shop =
{
	{
		id = 1,
		money = 1,
		name = "���� x 1 (����)",
		desc = "",		
		image = "image01.png",
		
		exchange = {
			type = "roomcard", -- �һ��Ƿ��� "rmb", "item"
			value0 = 1, -- ����
			value1 = 0, -- �����ڵ���ID
		}
	},
	
	{
		id = 2,
		money = 20,
		name = "���� x 10",
		desc = "",			
		image = "image02.png",
		
		exchange = {
			type = "roomcard", -- �һ��Ƿ��� "rmb", "item"
			value0 = 10, -- ����
			value1 = 0, -- �����ڵ���ID
		}
	},
	
	{
		id = 3,
		money = 60,
		name = "���� x 30",
		desc = "",			
		image = "image02.png",
		
		exchange = {
			type = "roomcard", -- �һ��Ƿ��� "rmb", "item"
			value0 = 30, -- ����
			value1 = 0, -- �����ڵ���ID
		}
	},
}
]]

function GetShopInfo()
	return _Shop
end

function SetShopInfo(tbl)
	_Shop = tbl
end

-- ��ֵ
-- ���� table = { type="rmb", value0=xxx, value1=xxx} type: rmb, roomcard, item
function Recharge(goods_id, fee)
	local tbl = {}
	
	repeat
		local shop = GetShopInfo()
		local goods = nil
		for i = 1, #shop do
			if shop[i].id == goods_id then
				goods = shop[i]
				break
			end		
		end
		
		-- check goods_id
		if not goods then
			break
		end
		
		-- check fee
		local unit = GetCurrencyUnit()
		local goods_fee = goods.money * unit
		if goods_fee ~= fee then
			local errstr = string.format("Dismatched fee value in `Recharge()`, goods_fee: %d, pay fee: %d", goods_fee, fee)
			debug.log(errstr)
			break
		end
		
		tbl = goods.exchange
		
	until true
	
	return tbl
end
