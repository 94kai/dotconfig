-- Setup orgmode
local org_root = "~/orgfiles"
require('orgmode').setup({
	org_agenda_files = { org_root .. '/**/*' },
	org_default_notes_file = org_root .. '/refile.org',
	org_capture_templates = {
		t = {
			description = 'tag:mira and schedule',
			template = '* TODO %?  :mira:\n  SCHEDULED: %t\n  %U',
		},
	},
})
