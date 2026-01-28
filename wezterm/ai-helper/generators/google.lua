local dkjson = require("dkjson")
local wezterm = require("wezterm")

local function generate_content(config, prompt)
    local request_body = {
        contents = {
            {
                parts = {
                    {
                        text = prompt,
                    },
                },
            },
        },
        generationConfig = {
            responseMimeType = "application/json",
            responseSchema = {
                type = "OBJECT",
                properties = {
                    message = { type = "STRING" },
                    command = { type = "STRING" },
                },
                required = { "message" },
            },
        },
    }

    if config.system_instruction then
        request_body.system_instruction = {
            parts = {
                {
                    text = config.system_instruction,
                },
            },
        }
    end

    local url = "https://generativelanguage.googleapis.com/v1beta/models/"
        .. config.model
        .. ":generateContent?key="
        .. config.api_key

    local body = dkjson.encode(request_body)

    -- Use curl instead of http.request
    local curl_command = string.format(
        'curl -s -X POST "%s" -H "Content-Type: application/json" -d %s',
        url,
        string.format("'%s'", body:gsub("'", "'\"'\"'"))
    )

    local handle = io.popen(curl_command)
    if not handle then
        return false, nil, "Failed to execute HTTP request"
    end

    local response_body = handle:read("*a")
    local success, _, exit_code = handle:close()

    if not success or exit_code ~= 0 then
        return false, nil, "HTTP request failed with exit code: " .. (exit_code or "unknown")
    end

    if response_body == "" then
        return false, nil, "Empty response from API"
    end

    local ok, response_data = pcall(dkjson.decode, response_body)
    if not ok then
        return false, nil, "Failed to parse JSON response: " .. response_data
    end

    if not response_data.candidates or not response_data.candidates[1] then
        print("Response data: ", response_data)
        return false, nil, "Invalid API response format"
    end

    return true, response_data.candidates[1].content.parts[1].text, nil
end

local function validate_config(config)
    if not config.api_key then
        wezterm.log_error("AI Helper: api_key is required in configuration")
        return false
    end
    return true
end

return {
    generate_content = generate_content,
    validate_config = validate_config,
}
