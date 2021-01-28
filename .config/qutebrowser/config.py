config.load_autoconfig(False)

c.auto_save.session = True
c.bindings.default = {}
c.colors.tabs.indicator.start = 'white'
c.colors.tabs.indicator.stop = 'black'
c.completion.cmd_history_max_items = 1000
c.completion.height = 300
c.completion.open_categories = []
c.completion.shrink = True
c.confirm_quit = ['downloads']
c.content.blocking.enabled = False
c.content.cache.maximum_pages = 15
c.content.geolocation = False
c.content.media.audio_capture = False
c.content.media.video_capture = False
c.content.media.audio_video_capture = False
c.content.proxy = 'http://localhost:8118'
c.downloads.location.directory = '/home/j'
c.downloads.location.prompt = False
c.downloads.location.remember = False
c.downloads.location.suggestion = 'filename'
c.downloads.remove_finished = 0
c.editor.command = ['alacritty', '-e', 'vim', '{}']
c.hints.auto_follow = 'always'
c.hints.auto_follow_timeout = 300
c.hints.chars = 'aoeuhtns'
c.input.forward_unbound_keys = 'none'
c.input.insert_mode.auto_leave = False
c.input.insert_mode.leave_on_load = False
c.input.links_included_in_focus_chain = False
c.input.mouse.back_forward_buttons = False
c.new_instance_open_target = 'tab-silent'
c.prompt.filebrowser = False
c.scrolling.bar = 'always'
c.search.incremental = True
c.session.lazy_restore = True
c.tabs.background = True
c.tabs.last_close = 'close'
c.tabs.new_position.related = 'last'
c.tabs.position = 'left'
c.tabs.title.format = '{current_title}'
c.tabs.width = 200
c.url.auto_search = 'never'
c.url.default_page = 'about:blank'
c.url.open_base_url = True
c.url.searchengines['search'] = 'https://www.google.co.uk/search?q={}'
c.url.searchengines['ddg'] = 'https://duckduckgo.com/?q={}'
c.url.searchengines['site'] = 'https://duckduckgo.com/?q=!{}'
c.url.start_pages = ['about:blank']
c.url.yank_ignored_parameters = []
c.window.title_format = 'qutebrowser - {current_title}'

# normal mode
config.bind('i', 'mode-enter insert')
config.bind('<Ctrl-P>', 'mode-enter passthrough')
config.bind(':', 'set-cmd-text :')
config.bind('<Escape>', 'clear-keychain ;; search')

config.bind('j', 'scroll down')
config.bind('k', 'scroll up')
config.bind('<Left>', 'scroll left')
config.bind('<Right>', 'scroll right')
config.bind('gg', 'scroll-to-perc 0')
config.bind('G', 'scroll-to-perc')
config.bind('<Ctrl-U>', 'scroll-page 0 -1')
config.bind('<Ctrl-D>', 'scroll-page 0 1')
config.bind('<Home>', 'scroll-to-perc 0')
config.bind('<End>', 'scroll-to-perc')
config.bind('<PgUp>', 'scroll-page 0 -1')
config.bind('<PgDown>', 'scroll-page 0 1')
config.bind('/', 'set-cmd-text /')
config.bind('?', 'set-cmd-text ?')
config.bind('n', 'search-next')
config.bind('N', 'search-prev')
config.bind('I', 'hint inputs')
config.bind('z+', 'zoom-in')
config.bind('z-', 'zoom-out')
config.bind('z=', 'zoom')
config.bind('r', 'reload')
config.bind('R', 'reload -f')
config.bind('x', 'stop')

config.bind('<Return>', 'selection-follow')
config.bind('<Ctrl-Return>', 'selection-follow -t')
config.bind('a', 'back')
config.bind('e', 'forward')
config.bind('o', 'set completion.open_categories [] ;; set-cmd-text -s :open')
config.bind('O', 'set completion.open_categories [] ;; set-cmd-text :open {url:pretty}')
config.bind('h', 'set completion.open_categories ["history"] ;; set-cmd-text -s :open')
config.bind('s', 'set completion.open_categories [] ;; set-cmd-text -s :open search')
config.bind('S', 'set completion.open_categories [] ;; set-cmd-text -s :open ddg')
config.bind('l', 'set completion.open_categories [] ;; set-cmd-text -s :open site')
config.bind('gu', 'navigate up')
config.bind('gU', 'navigate up -t')
config.bind('gh', 'view-source')
config.bind('f', 'hint links current')
config.bind(';s', 'hint links fill :open {hint-url}')
config.bind(';c', 'hint all right-click')

config.bind('t', 'open -t')
config.bind('T', 'set completion.open_categories [] ;; set-cmd-text :open -t {url:pretty}')
config.bind('H', 'set completion.open_categories ["history"] ;; set-cmd-text -s :open -t')
config.bind('F', 'hint links tab-fg')
config.bind(';r', 'hint --rapid links tab-bg')
config.bind('c', 'tab-clone')
config.bind('d', 'tab-close')
config.bind('u', 'undo')
config.bind(',', 'tab-prev')
config.bind('.', 'tab-next')
config.bind('-', 'tab-move -')
config.bind('+', 'tab-move +')

config.bind('y', 'yank')
config.bind('Y', 'yank selection')
config.bind(';y', 'hint links yank')
config.bind('p', 'open -- {clipboard}')
config.bind('P', 'open -t -- {clipboard}')
config.bind('ma', 'quickmark-save')
config.bind('md', 'set-cmd-text -s :quickmark-del')
config.bind('b', 'set-cmd-text -s :quickmark-load')
config.bind('B', 'set-cmd-text -s :quickmark-load -t')
config.bind('DD', 'download')
config.bind('Dc', 'download-cancel')
config.bind('DC', 'download-clear')
config.bind(';d', 'hint --rapid links download')
config.bind('<F12>', 'devtools window')

# hint mode
config.bind('<Escape>', 'mode-leave', mode='hint')

# insert mode
config.bind('<Ctrl-E>', 'edit-text', mode='insert')
config.bind('<Escape>', 'mode-leave', mode='insert')
config.bind('<Shift-Ins>', 'insert-text {primary}', mode='insert')

# passthrough mode
config.bind('<Ctrl-P>', 'mode-leave', mode='passthrough')

# register mode
config.bind('<Escape>', 'mode-leave', mode='register')

# command mode
config.bind('<Alt-B>', 'rl-backward-word', mode='command')
config.bind('<Alt-Backspace>', 'rl-backward-kill-word', mode='command')
config.bind('<Alt-D>', 'rl-kill-word', mode='command')
config.bind('<Alt-F>', 'rl-forward-word', mode='command')
config.bind('<Ctrl-?>', 'rl-delete-char', mode='command')
config.bind('<Ctrl-A>', 'rl-beginning-of-line', mode='command')
config.bind('<Ctrl-B>', 'rl-backward-char', mode='command')
config.bind('<Ctrl-D>', 'completion-item-del', mode='command')
config.bind('<Ctrl-E>', 'rl-end-of-line', mode='command')
config.bind('<Ctrl-F>', 'rl-forward-char', mode='command')
config.bind('<Ctrl-H>', 'rl-backward-delete-char', mode='command')
config.bind('<Ctrl-K>', 'rl-kill-line', mode='command')
config.bind('<Ctrl-N>', 'command-history-next', mode='command')
config.bind('<Ctrl-P>', 'command-history-prev', mode='command')
config.bind('<Ctrl-Shift-Tab>', 'completion-item-focus prev-category', mode='command')
config.bind('<Ctrl-Tab>', 'completion-item-focus next-category', mode='command')
config.bind('<Ctrl-U>', 'rl-unix-line-discard', mode='command')
config.bind('<Ctrl-W>', 'rl-unix-word-rubout', mode='command')
config.bind('<Ctrl-Y>', 'rl-yank', mode='command')
config.bind('<Down>', 'command-history-next', mode='command')
config.bind('<Escape>', 'mode-leave', mode='command')
config.bind('<Return>', 'command-accept', mode='command')
config.bind('<Shift-Delete>', 'completion-item-del', mode='command')
config.bind('<Shift-Tab>', 'completion-item-focus prev', mode='command')
config.bind('<Tab>', 'completion-item-focus next', mode='command')
config.bind('<Up>', 'command-history-prev', mode='command')

# prompt mode
config.bind('<Alt-B>', 'rl-backward-word', mode='prompt')
config.bind('<Alt-Backspace>', 'rl-backward-kill-word', mode='prompt')
config.bind('<Alt-D>', 'rl-kill-word', mode='prompt')
config.bind('<Alt-F>', 'rl-forward-word', mode='prompt')
config.bind('<Ctrl-?>', 'rl-delete-char', mode='prompt')
config.bind('<Ctrl-A>', 'rl-beginning-of-line', mode='prompt')
config.bind('<Ctrl-B>', 'rl-backward-char', mode='prompt')
config.bind('<Ctrl-E>', 'rl-end-of-line', mode='prompt')
config.bind('<Ctrl-F>', 'rl-forward-char', mode='prompt')
config.bind('<Ctrl-H>', 'rl-backward-delete-char', mode='prompt')
config.bind('<Ctrl-K>', 'rl-kill-line', mode='prompt')
config.bind('<Ctrl-U>', 'rl-unix-line-discard', mode='prompt')
config.bind('<Ctrl-W>', 'rl-unix-word-rubout', mode='prompt')
config.bind('<Ctrl-X>', 'prompt-open-download', mode='prompt')
config.bind('<Ctrl-Y>', 'rl-yank', mode='prompt')
config.bind('<Down>', 'prompt-item-focus next', mode='prompt')
config.bind('<Escape>', 'mode-leave', mode='prompt')
config.bind('<Return>', 'prompt-accept', mode='prompt')
config.bind('<Shift-Tab>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Tab>', 'prompt-item-focus next', mode='prompt')
config.bind('<Up>', 'prompt-item-focus prev', mode='prompt')

# yesno mode

config.bind('<Alt-Shift-Y>', 'prompt-yank --sel', mode='yesno')
config.bind('<Alt-Y>', 'prompt-yank', mode='yesno')
config.bind('<Escape>', 'mode-leave', mode='yesno')
config.bind('<Return>', 'prompt-accept', mode='yesno')
config.bind('n', 'prompt-accept no', mode='yesno')
config.bind('y', 'prompt-accept yes', mode='yesno')
