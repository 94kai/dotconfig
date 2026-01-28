local wezterm = require("wezterm")

local function generate_content(config, prompt)
    -- Build the command arguments
    local cmd_args = { config.ollama_path, "run", config.model }

    -- Combine system prompt with user prompt
    local full_prompt = config.system_prompt .. "\n\nUser: " .. prompt

    -- Set environment variables for remote host if specified
    local run_args = {
        cmd_args[1],
        cmd_args[2],
        cmd_args[3],
        full_prompt,
        "--format",
        "json",
    }

    local ok, success, stdout, stderr = pcall(wezterm.run_child_process, run_args)
    if not ok then
        success = false
        stdout = nil
        stderr = "Failed to run ollama process"
    end

    return success, stdout, stderr
end

local function validate_config(config)
    if not config.ollama_path then
        wezterm.log_error("AI Helper: ollama_path is required in configuration")
        return false
    end
    return true
end

return {
    generate_content = generate_content,
    validate_config = validate_config,
}
