-- signgift.lua
-- 处理游戏中每日签到



-- 保存从配置文件中读到的签到数据
g_signgift_table = {}

g_signgift_reward_table = {}

---------------------------------------------------------------
--按指定字符分割字符串
function split(str, pat)
	local t = {}
	local last_end = 0
	local s, e = string.find(str, pat, 1)
	local i = 1
	while s do
		table.insert(t, string.sub(str, last_end + 1, last_end + s - last_end - 1))
		last_end = e

		s, e = string.find(str, pat, last_end + 1)
		i = i + 1
	end
	if last_end <= #str then
		cap = string.sub(str, last_end + 1)
		table.insert(t, cap)
	end
	return t
end

--获得当前路径
function currDir()
  os.execute("cd > cd.tmp")
  local f = io.open("cd.tmp", r)
  local cwd = f:read("*a")
  f:close()
  os.remove("cd.tmp")
  return cwd
end



---------------------------------------------------------------
-- 读当月签到配置数据
function load_signgift_table()
    -- 获得当前路径
	local path = currDir()
	path = string.sub(path, 1, -2) -- 去掉换行符

    -- 根据当前月份读对应的签到配置文件
	local month = os.date("%m")
	local filename = path .. "\\data\\table\\sign_gift_" .. month .. ".txt"

	-- 读配置文件
    local file = io.open(filename,"r")

	-- 如果当月配置文件不存在，尝试读默认配置文件
	if file == nil then
	    filename = path .. "\\data\\table\\sign_gift.txt"
		file = io.open(filename, "r")
	end

	-- 遍历处理文件数据
	if file ~= nil then
		local index = 0
		for line in file:lines() do
			-- 从第2行开始,忽略第一行表格标题
			if index > 0 then
				--编号	道具	数量	VIP标记	VIP数量
				local t = split(line,'\t')

				local item = {}
				for i = 1, #t do
					if i == 1 then
						item["idx"] = t[i]
					elseif i == 2 then
					    item["item"] = t[i]
					elseif i == 3 then
						item["num"] = t[i]
					elseif i == 4 then
						item["vip_level"] = t[i]
					elseif i == 5 then
						item["vip_num"] = t[i]
					else
						break
					end
				end

				-- 保存配置数据到lua表中
				g_signgift_table[index] = item
			end

			-- 继续处理下一行
			index = index + 1
	    end
		-- 关闭打开的配置文件
		file:close()
	end
end

---------------------------------------------------------------
-- 读当月签到额外奖励配置数据
function load_signgift_reward_table()
    -- 获得当前路径
	local path = currDir()
	path = string.sub(path, 1, -2) -- 去掉换行符

    -- 根据当前月份读对应的签到配置文件
	local month = os.date("%m")
	local filename = path .. "\\data\\table\\sign_gift_reward_" .. month .. ".txt"

	-- 读配置文件
    local file = io.open(filename,"r")

	-- 如果当月配置文件不存在，尝试读默认配置文件
	if file == nil then
	    filename = path .. "\\data\\table\\sign_gift_reward.txt"
		file = io.open(filename, "r")
	end

	-- 遍历处理文件数据
	if file ~= nil then
		local index = 0
		for line in file:lines() do
			-- 从第2行开始,忽略第一行表格标题
			if index > 0 then
				--编号	道具	累计天数
				local t = split(line,'\t')

				local item = {}
				for i = 1, #t do
					if i == 1 then
						item["idx"] = t[i]
					elseif i == 2 then
					    item["item"] = t[i]
					elseif i == 3 then
						item["num"] = t[i]
					elseif i == 4 then
						item["day_sum"] = t[i]
					else
						break
					end
				end

				-- 保存配置数据到lua表中
				g_signgift_reward_table[index] = item
			end

			-- 继续处理下一行
			index = index + 1
	    end
		-- 关闭打开的配置文件
		file:close()
	end
end



---------------------------------------------------------------
-- 供c++调用函数
function lfx_signgift_get_item()
    -- 读本月签到配置数据
    load_signgift_table()

    -- 返回签到数据
	return g_signgift_table
end

function lfx_signgift_reward_get_item()
    -- 读本月签到额外奖励配置数据
    load_signgift_reward_table()

    -- 返回签到额外奖励数据
	return g_signgift_reward_table
end

