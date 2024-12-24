-- signgift.lua
-- ������Ϸ��ÿ��ǩ��



-- ����������ļ��ж�����ǩ������
g_signgift_table = {}

g_signgift_reward_table = {}

---------------------------------------------------------------
--��ָ���ַ��ָ��ַ���
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

--��õ�ǰ·��
function currDir()
  os.execute("cd > cd.tmp")
  local f = io.open("cd.tmp", r)
  local cwd = f:read("*a")
  f:close()
  os.remove("cd.tmp")
  return cwd
end



---------------------------------------------------------------
-- ������ǩ����������
function load_signgift_table()
    -- ��õ�ǰ·��
	local path = currDir()
	path = string.sub(path, 1, -2) -- ȥ�����з�

    -- ���ݵ�ǰ�·ݶ���Ӧ��ǩ�������ļ�
	local month = os.date("%m")
	local filename = path .. "\\data\\table\\sign_gift_" .. month .. ".txt"

	-- �������ļ�
    local file = io.open(filename,"r")

	-- ������������ļ������ڣ����Զ�Ĭ�������ļ�
	if file == nil then
	    filename = path .. "\\data\\table\\sign_gift.txt"
		file = io.open(filename, "r")
	end

	-- ���������ļ�����
	if file ~= nil then
		local index = 0
		for line in file:lines() do
			-- �ӵ�2�п�ʼ,���Ե�һ�б�����
			if index > 0 then
				--���	����	����	VIP���	VIP����
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

				-- �����������ݵ�lua����
				g_signgift_table[index] = item
			end

			-- ����������һ��
			index = index + 1
	    end
		-- �رմ򿪵������ļ�
		file:close()
	end
end

---------------------------------------------------------------
-- ������ǩ�����⽱����������
function load_signgift_reward_table()
    -- ��õ�ǰ·��
	local path = currDir()
	path = string.sub(path, 1, -2) -- ȥ�����з�

    -- ���ݵ�ǰ�·ݶ���Ӧ��ǩ�������ļ�
	local month = os.date("%m")
	local filename = path .. "\\data\\table\\sign_gift_reward_" .. month .. ".txt"

	-- �������ļ�
    local file = io.open(filename,"r")

	-- ������������ļ������ڣ����Զ�Ĭ�������ļ�
	if file == nil then
	    filename = path .. "\\data\\table\\sign_gift_reward.txt"
		file = io.open(filename, "r")
	end

	-- ���������ļ�����
	if file ~= nil then
		local index = 0
		for line in file:lines() do
			-- �ӵ�2�п�ʼ,���Ե�һ�б�����
			if index > 0 then
				--���	����	�ۼ�����
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

				-- �����������ݵ�lua����
				g_signgift_reward_table[index] = item
			end

			-- ����������һ��
			index = index + 1
	    end
		-- �رմ򿪵������ļ�
		file:close()
	end
end



---------------------------------------------------------------
-- ��c++���ú���
function lfx_signgift_get_item()
    -- ������ǩ����������
    load_signgift_table()

    -- ����ǩ������
	return g_signgift_table
end

function lfx_signgift_reward_get_item()
    -- ������ǩ�����⽱����������
    load_signgift_reward_table()

    -- ����ǩ�����⽱������
	return g_signgift_reward_table
end

