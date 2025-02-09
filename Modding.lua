SMODS.Atlas {
    -- Key for code to find it with
    key = "ModdingJokers",
    -- The name of the file, for the code to pull the atlas from
    path = "ModdingJokers.png",
    -- Width of each sprite in 1x size
    px = 71,
    -- Height of each sprite in 1x size
    py = 95
}

SMODS.Joker {
    key = 'crafterbot',
    atlas = 'ModdingJokers',
    pos = { x = 0, y = 0 },
    cost = 5,
    loc_txt = {
        name = 'Crafterbot Ban Gun',
        text = {
            '{C:attention}Debuffs{} a random card held in hand after playing a hand',
            '{C:attention}Always{} eternal',
            '{s:0.8}"they have limits on what they know is a joke cheat and a real one"{}'
        }
    },
    rarity = 2,

    add_to_deck = function (self, card, from_debuff)
        card.ability.eternal = true
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            return {
                message = 'Banned!'
            }
        end

        if context.after then
            local cardToDebuff
            local found_debuff_card = false
            local debuff_card_attempt = 0
            repeat
                cardToDebuff = pseudorandom_element(G.hand.cards, pseudoseed('crafterbot'))
                debuff_card_attempt = debuff_card_attempt + 1
                if not cardToDebuff.debuff then
                    found_debuff_card = true
                    SMODS.debuff_card(cardToDebuff, true, 'crafterbot')
                    play_sound('tarot1')
                    cardToDebuff.T.r = -0.2
                    cardToDebuff:juice_up(0.3, 0.4)
                end
            until found_debuff_card or debuff_card_attempt >= #G.hand.cards
        end
    end
}
