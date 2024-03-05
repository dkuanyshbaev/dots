require('vis')

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	--global configuration--
	vis:command('set change-256colors off') --see vis#613
	vis:command('set theme base16-nord')
	vis:command('set number')
	--keyboard shortcuts--
	vis:command('map insert kj <Escape>')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	--per-window configuration--
	vis:command('set autoindent on')
	vis:command('set cursorline on')
	vis:command('set tabwidth 4')
end)
