local debug = require("Debug")

-- wrap debug log
local ENABLE_DEBUG = true

-- For enum
LogLevel = debug.LogLevel

function DebugInfo(level, str)
	if ENABLE_DEBUG then
		debug.logex(level, str)
	end
end
