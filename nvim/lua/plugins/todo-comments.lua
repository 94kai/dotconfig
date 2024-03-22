-- 强化TODO等提示
local todo = pRequire("todo-comments")
--TODO:test
--FIXME:test
--
if todo then
    todo.setup({
        keywords = {
            fix = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this fix keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            todo = { icon = " ", color = "info" },
            hack = { icon = " ", color = "warning" },
            warn = { icon = " ", color = "warning", alt = { "warning", "xxx" } },
            perf = { icon = " ", alt = { "optim", "performance", "optimize" } },
            note = { icon = " ", color = "hint", alt = { "info" } },
            test = { icon = "⏲ ", color = "test", alt = { "testing", "passed", "failed" } },
        },
    })
end
