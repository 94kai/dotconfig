local wezterm = require("wezterm")

local function generate_content(config, prompt)
    local success, stdout, stderr = wezterm.run_child_process({
        config.lms_path,
        "chat",
        config.model,
        "-s",
        config.system_prompt,
        "-p",
        prompt,
    })

    return {
        success = success,
        result = stdout,
        err = stderr,
    }
end

local function validate_config(config)
    if not config.lms_path then
        wezterm.log_error("AI Helper: lms_path is required in configuration")
        return false
    end
    return true
end

return {
    generate_content = generate_content,
    validate_config = validate_config,
}
