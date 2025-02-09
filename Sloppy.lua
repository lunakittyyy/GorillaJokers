function getOS()
-- ask LuaJIT first
if jit then
    return jit.os
    end

    -- Unix, Linux variants
    local fh,err = assert(io.popen("uname -o 2>/dev/null","r"))
    if fh then
        osname = fh:read()
        end

        return osname or "Windows"
        end


SMODS.Atlas {
    -- Key for code to find it with
    key = "SloppyJokers",
    -- The name of the file, for the code to pull the atlas from
    path = "SloppyJokers.png",
    -- Width of each sprite in 1x size
    px = 71,
    -- Height of each sprite in 1x size
    py = 95
}

SMODS.Joker {
    key = 'bloodjman',
    atlas = 'SloppyJokers',
    pos = { x = 0, y = 0 },
    cost = 30,
    loc_txt = {
        name = 'Blood JMan',
        text = {
            '{X:mult,C:dark_edition}^^^100{} Mult',
            'Opens a {C:attention}Be Prepared video{} at the end of each shop',
            '{s:0.8}"guess you shoulödve been prepared...heh"{}'
        }
    },
    rarity = 4,

    calculate = function (self, card, context)
        if context.joker_main then
            return {
                EEEmult_mod = 100
            }
        end
        if context.ending_shop then
            local myOs = getOS()
            if myOs == "Windows" then
                os.execute('start https://www.youtube.com/watch?v=BX5XSeCKz6k')
            else
                os.execute('xdg-open https://www.youtube.com/watch?v=BX5XSeCKz6k')
            end
        end
    end
}
