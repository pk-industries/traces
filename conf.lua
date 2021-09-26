function love.conf(t)
    t.title = "T R A C E S"
    t.window.width = 400 -- The window width (number)
    t.window.height = 240
    t.window.fullscreen = false -- Enable fullscreen (boolean)
    t.window.resizable = false -- Let the window be user-resizable
    t.window.vsync = true -- Enable vertical sync (boolean)
end

-- if not set, the folder name will be used
name = 'Example'
-- list of matched words
words = {'thisIsAnExampleWord%.ifItExistsInFile%.thenTryLoadThisLibrary'}
-- list or matched file names. `.lua`, `.dll` and `.so` only
files = {
    'thisIsAnExampleFile%.ifItExistsInWorkSpace%.thenTryLoadThisLibrary%.lua'
}
-- lsit of settings to be changed
configs = {
    {
        key = 'Lua.runtime.version',
        action = 'set',
        value = 'LuaJIT'
    }, {
        key = 'Lua.diagnostics.globals',
        action = 'add',
        value = 'global1'
    }, {
        key = 'Lua.runtime.special',
        action = 'prop',
        prop = 'include',
        value = 'require'
    }, {
        key = 'Lua.runtime.builtin',
        action = 'prop',
        prop = 'io',
        value = 'disable'
    }
}
for _, name in ipairs {'love', 'love2d', 'global4'} do
    configs[#configs + 1] = {
        key = 'Lua.diagnostics.globals',
        action = 'add',
        value = name
    }
end
