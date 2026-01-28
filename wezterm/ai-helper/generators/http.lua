local wezterm = require("wezterm")

local function generate_content(config, prompt)
    -- Build the API endpoint URL
    local url = config.api_url or "http://localhost:11434/v1/chat/completions"
    -- Prepare the request body following OpenAI API format
    local request_body = {
        model = config.model,
        messages = {
            {
                role = "system",
                content = config.system_prompt
            },
            {
                role = "user",
                content = prompt
            }
        },
        thinking = {
            type = "disabled"
        }
    }

    -- Convert to JSON
    local json_body = wezterm.json_encode(request_body)

    -- Build curl command arguments
    local curl_args = {
        "curl",
        "-s",
        "-X", "POST",
        "-H", "Content-Type: application/json",
        url,
        "-d", json_body
    }


    -- Add authorization header if API key is provided
    if config.api_key then
        table.insert(curl_args, 5, "-H")
        table.insert(curl_args, 6, "Authorization: Bearer " .. config.api_key)
    end

    -- Add custom headers if provided
    if config.headers then
        for header_name, header_value in pairs(config.headers) do
            table.insert(curl_args, 5, "-H")
            table.insert(curl_args, 6, header_name .. ": " .. header_value)
        end
    end

    local success, stdout, stderr = wezterm.run_child_process(curl_args)

    if not success then
        return false, "", stderr or "Failed to make HTTP request"
    end

    -- Parse the JSON response
    local ok, response = pcall(wezterm.json_parse, stdout)
    if not ok then
        return false, "", "Failed to parse API response: " .. stdout
    end

    -- Handle API errors
    if response.error then
        local error_msg = "API error: " .. (response.error.message or "Unknown error")
        return false, "", error_msg
    end

    -- Extract the content from the response
    if response.choices and response.choices[1] and response.choices[1].message then
        local content = response.choices[1].message.content
        -- return true, content, ""
        return true, content, ""
    else
        return false, "", "Invalid API response format: " .. stdout
    end
end

local function validate_config(config)
    if not config.api_url then
        wezterm.log_error("AI Helper: api_url is required for HTTP type")
        return false
    end
    if not config.model then
        wezterm.log_error("AI Helper: model is required for HTTP type")
        return false
    end
    return true
end

return {
    generate_content = generate_content,
    validate_config = validate_config,
}
