require('vis')
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	--vis:command('set change-256colors off') --see vis#613
	--vis:command('set theme base16-nord')
	--vis:command('set theme solarized')
	-- vis:command('set number')
	vis:command('set autoindent on')
	vis:command('set cursorline on')
	vis:command('set tabwidth 4')
	vis:command('map insert kj <Escape>')
end)
