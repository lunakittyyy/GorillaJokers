local today = os.date("*t")

SMODS.Atlas {
    -- Key for code to find it with
    key = "MakeshipJokers",
    -- The name of the file, for the code to pull the atlas from
    path = "MakeshipJokers.png",
    -- Width of each sprite in 1x size
    px = 71,
    -- Height of each sprite in 1x size
    py = 95
}

SMODS.Joker {
    key = 'stick',
    atlas = 'MakeshipJokers',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 2, y =0 },
    cost = 20,
    loc_txt = {
        name = 'Mod Stick',
        text = {
            'Destroys one random {C:attention}eternal Joker{} at the end of a {C:attention}shop{}',
            'This {C:attention}Joker{} is debuffed after {C:attention}Jan. 30th{}',
            '{s:0.8}"The{} {E:1}reimagined{} {s:0.8}Stick!"{}'
        }
    },
    rarity = 4,

    add_to_deck = function(self, card, from_debuff)
        if today.month > 1 or (today.month == 1 and today.day > 30) then
            if not card.debuff then
                SMODS.debuff_card(card, true, 'sticktimebomb')
            end
        end
    end,
    calculate = function (self, card, context)
        local card
        if context.ending_shop then
            local found_eternal_joker = false
            local eternal_find_attempts = 0
            repeat
                card = pseudorandom_element(G.jokers.cards, pseudoseed('stick'))
                eternal_find_attempts = eternal_find_attempts + 1
                if card.ability.eternal then
                    found_eternal_joker = true
                    card:start_dissolve()
                end
            until found_eternal_joker or eternal_find_attempts >= #G.jokers.cards
        end
    end
}
