local function getSummary()
  -- Set command to execute
  local command = "show nat descriptor masquerade session 1000 summary"

  -- Stores the result of command execution in the variables
  local result, summary =  rt.command(command)

  return summary
end

local function parse(summary)
    local parsedSummary = {}

    -- Set regular expression patterns
    local pattern = "%s*(%S+)%s+(%d+)%s+(%S+)%s+(%d+/%d+)%s+(%d+)"

    -- Extract each field from the input
    local interface, desc_num, outer_address, current_max, peak = summary:match(pattern)
    
    -- Stores results in an associative array
    parsedSummary.interface = interface
    parsedSummary.desc_num = desc_num
    parsedSummary.outer_address = outer_address
    parsedSummary.current_max = current_max
    parsedSummary.peak = peak

    return parsedSummary
end

-- Concatenate associative arrays into a single line of text
local function concatenateKeyValues(parsedSummary)
  local parts = {}

  for k, v in pairs(parsedSummary) do
    table.insert(parts, k .. ": " .. v)
  end

  return table.concat(parts, " ")
end

local function writeToSyslog()
  local summary = getSummary()
  local parsedSummary = parse(summary)
  local concatenatedSumarry = concatenateKeyValues(parsedSummary)

  -- Set log level
  local logLevel = "debug"
  rt.syslog(logLevel, concatenatedSumarry)
end

writeToSyslog()