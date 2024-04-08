-- Setup orgmode
local org_root = "~/orgfiles"
require('orgmode').setup({
	org_agenda_files = { org_root .. '/**/*' },
	org_default_notes_file = org_root .. '/refile.org',
	org_capture_templates = {
		T = { description = 'Task', template = '* TODO %?\n  SCHEDULED: %t' },
		t = 'TODO',
		tv = {
			description = 'Vim Tasks',
			template = '* TODO %?\n  SCHEDULED: %t',
			target = org_root .. '/vim.org',
		},
		ta = {
			description = 'AdSystem Tasks',
			template = '* TODO %?\n  SCHEDULED: %t',
			target = org_root .. '/adsystem.org',
		},
		tb = {
			description = 'Blog Tasks',
			template = '* TODO %?\n  SCHEDULED: %t',
			target = org_root .. '/blog.org',
		},
		ts = {
			description = 'Study Tasks',
			template = '* TODO %?\n  SCHEDULED: %t',
			target = org_root .. '/study.org',
		},
	},
})
