local jollysus = {
	pools = { ["M"] = true },
	object_type = "Joker",
	name = "cry-jollysus Joker",
	key = "jollysus",
	pos = { x = 3, y = 1 },
	config = {
		extra = {
			spawn = true,
			active = localize("k_active_ex"),
		},
	},
	rarity = 1,
	cost = 4,
	order = 267,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	dependencies = {
		items = { "set_cry_m" },
	},
	immutable = true,
	loc_vars = function(self, info_queue, center)
		if Cryptid.enabled("e_cry_m") == true then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_m
		end
		return { vars = { center.ability.extra.active } }
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.end_of_round and not context.retrigger_joker and not context.blueprint then
			if not card.ability.extra.spawn then
				card.ability.extra.active = localize("k_active_ex")
				card.ability.extra.spawn = true
				return {
					message = localize("k_reset"),
					card = card,
				}
			end
		end
		if context.selling_card and card.ability.extra.spawn and not context.retrigger_joker then
			if context.card.ability.set == "Joker" then
				if not context.blueprint and not context.retrigger_joker then
					card.ability.extra.active = localize("cry_no_triggers")
					card.ability.extra.spawn = false
				end
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "jollysus")
				if Cryptid.enabled("e_cry_m") == true then
					card:set_edition({ cry_m = true })
				end
				card:add_to_deck()
				G.jokers:emplace(card)
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("cry_m_ex"),
						colour = G.C.FILTER,
						card = card,
					}),
				}
			end
		elseif context.selling_self and card.ability.extra.spawn and not context.retrigger_joker then
			if not context.blueprint and not context.retrigger_joker then
				card.ability.extra.active = localize("cry_no_triggers")
				card.ability.extra.spawn = false
			end
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "jollysus")
			if Cryptid.enabled("e_cry_m") == true then
				card:set_edition({ cry_m = true })
			end
			card:add_to_deck()
			G.jokers:emplace(card)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.FILTER,
					card = card,
				}),
			}
		end
		if context.forcetrigger then
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "jollysus")
			if Cryptid.enabled("e_cry_m") == true then
				card:set_edition({ cry_m = true })
			end
			card:add_to_deck()
			G.jokers:emplace(card)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.FILTER,
					card = card,
				}),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
--TODO
--Fix Incompatiblity with Brainstorm (the joker not the mod)
--Make Blueprints create copies when this is sold to the right of Blueprint
local bubblem = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-bubblem",
	key = "bubblem",
	pools = { ["M"] = true },
	order = 251,
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			spawn = false,
			type = "Three of a Kind",
		},
	},
	rarity = 1,
	cost = 2,
	eternal_compat = false,
	demicoloncompat = true,
	immutable = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		if not center.edition or (center.edition and not center.edition.foil) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		end
		return { vars = { localize(center.ability.extra.type, "poker_hands") } }
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.before
			and next(context.poker_hands[card.ability.extra.type])
			and not context.blueprint
			and not context.retrigger_joker
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(self)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
			card:set_edition({
				foil = true,
			})
			card:add_to_deck()
			G.jokers:emplace(card)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.FILTER,
				}),
			}
		end
		if context.forcetrigger then
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
			card:set_edition({
				foil = true,
			})
			card:add_to_deck()
			G.jokers:emplace(card)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.FILTER,
				}),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local foodm = {
	object_type = "Joker",
	name = "cry-foodm",
	key = "foodm",
	pools = { ["M"] = true, ["Food"] = true },
	config = {
		extra = {
			mult = 40,
			rounds_remaining = 2,
			round_inc = 1,
		},
	},
	pos = { x = 4, y = 2 },
	rarity = 1,
	dependencies = {
		items = { "set_cry_m" },
	},
	order = 252,
	cost = 5,
	atlas = "atlasone",
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				number_format(center.ability.extra.mult),
				number_format(center.ability.extra.rounds_remaining),
				number_format(center.ability.extra.round_inc),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.mult) > to_big(0)) then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
				colour = G.C.MULT,
			}
		end
		if
			context.end_of_round
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			card.ability.extra.rounds_remaining = lenient_bignum(to_big(card.ability.extra.rounds_remaining) - 1)
			if to_big(card.ability.extra.rounds_remaining) > to_big(0) then
				return {
					message = { localize("cry_minus_round") },
					colour = G.C.FILTER,
				}
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("cry_m_ex"),
				}
			end
		end
		if
			context.selling_card
			and not context.blueprint
			and not context.retrigger_joker
			and context.card:is_jolly()
		then
			card.ability.extra.rounds_remaining =
				lenient_bignum(to_big(card.ability.extra.rounds_remaining) + card.ability.extra.round_inc)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = "a_round",
						vars = { number_format(card.ability.extra.round_inc) },
					}),
					colour = G.C.FILTER,
				}),
			}
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
				colour = G.C.MULT,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local mstack = {
	object_type = "Joker",
	name = "cry-mstack",
	key = "mstack",
	pools = { ["M"] = true },
	order = 253,
	config = {
		extra = {
			sell = 0,
			sell_req = 3,
			retriggers = 1,
			check = false,
		},
		immutable = {
			max_retriggers = 40,
		},
	},
	dependencies = {
		items = { "set_cry_m" },
	},
	pos = { x = 2, y = 3 },
	atlas = "atlastwo",
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				number_format(math.min(center.ability.extra.retriggers, center.ability.immutable.max_retriggers)),
				number_format(center.ability.extra.sell_req),
				number_format(center.ability.extra.sell),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						math.min(card.ability.extra.retriggers, card.ability.immutable.max_retriggers)
					),
					card = card,
				}
			end
		end

		if
			context.selling_card
			and context.card:is_jolly()
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.extra.check = true
			if to_big(card.ability.extra.sell) + 1 >= to_big(card.ability.extra.sell_req) then
				if not context.blueprint or context.retrigger_joker then
					card.ability.extra.retriggers = lenient_bignum(to_big(card.ability.extra.retriggers) + 1)
				end
				card.ability.extra.sell = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.FILTER,
					}),
				}
			else
				card.ability.extra.sell = card.ability.extra.sell + 1
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = number_format(card.ability.extra.sell) .. "/" .. number_format(
							card.ability.extra.sell_req
						),
						colour = G.C.FILTER,
					}),
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff) --Force retriggers to be 1 when bought/obtained on misprint deck (no 0.43 retriggers that do nothing)
		card.ability.extra.retriggers = lenient_bignum(math.floor(card.ability.extra.retriggers))
		if to_big(card.ability.extra.retriggers) < to_big(1) and not card.ability.extra.check then
			card.ability.extra.retriggers = 1
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local mneon = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-mneon",
	key = "mneon",
	pools = { ["M"] = true },
	pos = { x = 4, y = 2 },
	order = 254,
	config = {
		extra = {
			bonus = 1,
			money = 0,
		},
	},
	rarity = 2,
	cost = 7,
	perishable_compat = false,
	blueprint_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				number_format(center.ability.extra.bonus),
				number_format(center.ability.extra.money),
			},
		}
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
			local jollycount = 0
			for i = 1, #G.jokers.cards do
				if
					G.jokers.cards[i]:is_jolly()
					or Cryptid.safe_get(G.jokers.cards[i].config.center, "pools", "M")
					or G.jokers.cards[i].ability.name == "cry-mprime"
				then
					jollycount = jollycount + 1
				end
			end
			card.ability.extra.money = lenient_bignum(
				to_big(card.ability.extra.money) + math.max(1, to_big(card.ability.extra.bonus)) * (jollycount or 1)
			)
			return { message = localize("cry_m_ex") }
		end
		if context.forcetrigger then
			card.ability.extra.money = lenient_bignum(
				to_big(card.ability.extra.money) + math.max(1, to_big(card.ability.extra.bonus)) * (jollycount or 1)
			)
			return {
				dollars = lenient_bignum(
					to_big(card.ability.extra.money) + math.max(1, to_big(card.ability.extra.bonus)) * (jollycount or 1)
				),
			}
		end
	end,
	calc_dollar_bonus = function(self, card)
		if to_big(card.ability.extra.money) > to_big(0) then
			return lenient_bignum(card.ability.extra.money)
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local notebook = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-notebook",
	key = "notebook",
	pools = { ["M"] = true },
	pos = { x = 1, y = 0 },
	order = 255,
	config = {
		extra = {
			add = 1,
			odds = 7,
			jollies = 4,
			check = true,
			active = "Active",
			inactive = "",
		},
		immutable = {
			slots = 0,
			max_slots = 100,
		},
	},
	rarity = 3,
	cost = 9,
	perishable_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		local aaa, bbb = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Notebook")
		return {
			vars = {
				aaa,
				bbb,
				number_format(card.ability.immutable.slots),
				number_format(card.ability.extra.active),
				number_format(card.ability.extra.jollies),
				number_format(card.ability.extra.add),
			},
		}
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if
			context.reroll_shop
			and card.ability.extra.check
			and not context.blueprint
			and not context.retrigger_joker
		then
			local jollycount = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:is_jolly() then
					jollycount = jollycount + 1
				end
			end
			local aaa = to_number(jollycount) >= to_number(card.ability.extra.jollies) and 1e20 or 1
			if SMODS.pseudorandom_probability(card, "cry_notebook", 1 * aaa, card.ability.extra.odds, "Notebook") then
				card.ability.immutable.slots = to_number(
					math.min(
						card.ability.immutable.max_slots,
						lenient_bignum(card.ability.immutable.slots + to_big(card.ability.extra.add))
					)
				)

				if to_big(card.ability.immutable.slots) >= to_big(card.ability.immutable.max_slots) then
					card.ability.extra.add = 0
				end

				G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit + to_big(card.ability.extra.add))
				card.ability.extra.check = false
				card.ability.extra.active = localize("cry_inactive")
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.DARK_EDITION,
					}),
				}
			end
		end
		if context.end_of_round and not context.retrigger_joker and not context.blueprint then
			if not card.ability.extra.check then
				card.ability.extra.check = true
				card.ability.extra.active = localize("cry_active")
				return {
					message = localize("k_reset"),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			card.ability.immutable.slots = to_number(
				math.min(
					card.ability.immutable.max_slots,
					lenient_bignum(card.ability.immutable.slots + to_big(card.ability.extra.add))
				)
			)

			if card.ability.immutable.slots >= card.ability.immutable.max_slots then
				card.ability.extra.add = 0
			end

			G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit + to_big(card.ability.extra.add))
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit + to_big(card.ability.immutable.slots))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = lenient_bignum(G.jokers.config.card_limit - to_big(card.ability.immutable.slots))
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local bonk = {
	dependencies = {
		items = {
			"set_cry_m",
			"set_cry_meme",
		},
	},
	object_type = "Joker",
	name = "cry-bonk",
	key = "bonk",
	pools = { ["M"] = true, ["Meme"] = true },
	order = 256,
	pos = { x = 2, y = 2 },
	config = {
		extra = {
			chips = 6,
			bonus = 1,
			xchips = 3,
			type = "Pair",
		},
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				number_format(center.ability.extra.chips),
				number_format(center.ability.extra.bonus),
				localize(center.ability.extra.type, "poker_hands"),
				number_format(lenient_bignum(to_big(center.ability.extra.chips) * center.ability.extra.xchips)),
			},
		}
	end,
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	atlas = "atlasone",
	perishable_compat = false,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if context.scoring_name == card.ability.extra.type then
				card.ability.extra.chips = lenient_bignum(to_big(card.ability.extra.chips) + card.ability.extra.bonus)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_upgrade_ex"),
					colour = G.C.CHIPS,
				})
				return nil, true
			end
		end
		if context.other_joker and context.other_joker.ability.set == "Joker" then
			if context.other_joker:is_jolly() then
				if not Talisman.config_file.disable_anims then
					G.E_MANAGER:add_event(Event({
						func = function()
							context.other_joker:juice_up(0.5, 0.5)
							return true
						end,
					}))
				end
				return {
					message = localize({
						type = "variable",
						key = "a_chips",
						vars = {
							number_format(lenient_bignum(to_big(card.ability.extra.chips) * card.ability.extra.xchips)),
						},
					}),
					chip_mod = lenient_bignum(to_big(card.ability.extra.chips) * card.ability.extra.xchips),
				}
			else
				if not Talisman.config_file.disable_anims then
					G.E_MANAGER:add_event(Event({
						func = function()
							context.other_joker:juice_up(0.5, 0.5)
							return true
						end,
					}))
				end
				return {
					message = localize({
						type = "variable",
						key = "a_chips",
						vars = { number_format(card.ability.extra.chips) },
					}),
					chip_mod = lenient_bignum(card.ability.extra.chips),
				}
			end
		end
		if context.forcetrigger then
			card.ability.extra.chips = lenient_bignum(to_big(card.ability.extra.chips) + card.ability.extra.bonus)
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = {
						number_format(lenient_bignum(to_big(card.ability.extra.chips) * card.ability.extra.xchips)),
					},
				}),
				chip_mod = lenient_bignum(to_big(card.ability.extra.chips) * card.ability.extra.xchips),
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.xchips = lenient_bignum(math.floor(to_big(card.ability.extra.xchips) + 0.5)) --lua moment
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local loopy = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-loopy",
	key = "loopy",
	pools = { ["M"] = true },
	config = { extra = { retrigger = 0 }, immutable = { limit = 40 } },
	pos = { x = 7, y = 0 },
	order = 257,
	atlas = "atlastwo",
	immutable = true,
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return { vars = { math.min(center.ability.extra.retrigger, center.ability.immutable.limit) } }
	end,
	calculate = function(self, card, context)
		if
			context.selling_card
			and context.card:is_jolly()
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.extra.retrigger = math.min((card.ability.extra.retrigger + 1), card.ability.immutable.limit)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.GREEN,
				}),
			}
		end
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and context.other_card ~= self
			and card.ability.extra.retrigger ~= 0
		then
			return {
				message = localize("k_again_ex"),
				colour = G.C.GREEN,
				repetitions = math.min(card.ability.extra.retrigger, card.ability.immutable.limit),
				card = card,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local scrabble = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-scrabble",
	key = "scrabble",
	pools = { ["M"] = true },
	config = { extra = { odds = 4 } },
	pos = { x = 0, y = 2 },
	order = 258,
	rarity = 2,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, card)
		if Cryptid.enabled("e_cry_m") == true then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_m
		end
		return {
			vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Scrabble Tile") },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.retrigger_joker then
			local check = false
			if SMODS.pseudorandom_probability(card, "scrabbleother", 1, card.ability.extra.odds, "Scrabble Tile") then
				check = true
				local card = create_card("Joker", G.jokers, nil, 0.9, nil, nil, nil, "scrabbletile")
				if Cryptid.enabled("e_cry_m") == true then
					card:set_edition({ cry_m = true })
				end
				card:add_to_deck()
				G.jokers:emplace(card)
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
				)
				return nil, true
			end
		end
		if context.forcetrigger then
			local card = create_card("Joker", G.jokers, nil, 0.9, nil, nil, nil, "scrabbletile")
			if Cryptid.enabled("e_cry_m") == true then
				card:set_edition({ cry_m = true })
			end
			card:add_to_deck()
			G.jokers:emplace(card)
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local sacrifice = {
	object_type = "Joker",
	name = "cry-sacrifice",
	dependencies = {
		items = { "set_cry_m" },
	},
	key = "sacrifice",
	pools = { ["M"] = true },
	config = {
		extra = {
			jollies = 3,
			unc = 1,
			text = localize("k_active_ex"),
			spawn = true,
		},
		immutable = {
			max_spawns = 30,
		},
	},
	pos = { x = 5, y = 2 },
	order = 259,
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				center.ability.extra.text,
				math.min(center.ability.immutable.max_spawns, center.ability.extra.jollies),
				math.min(center.ability.immutable.max_spawns, center.ability.extra.unc),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and card.ability.extra.spawn and not context.retrigger_joker then
			if context.consumeable.ability.set == "Spectral" then
				if not context.blueprint then
					G.E_MANAGER:add_event(Event({
						func = function()
							card.ability.extra.spawn = false
							return true
						end,
					}))
				end
				if to_big(card.ability.extra.jollies) < to_big(1) then
					card.ability.extra.jollies = 1
				end
				if to_big(card.ability.extra.unc) < to_big(1) then
					card.ability.extra.unc = 1
				end
				for i = 1, math.min(card.ability.immutable.max_spawns, card.ability.extra.jollies) do
					local jolly = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
					jolly:add_to_deck()
					G.jokers:emplace(jolly)
				end
				for i = 1, math.min(card.ability.immutable.max_spawns, card.ability.extra.unc) do
					local unc = create_card("Joker", G.jokers, nil, 0.9, nil, nil, nil, "sacrifice")
					unc:add_to_deck()
					G.jokers:emplace(unc)
					unc:start_materialize()
				end
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("cry_m_ex"), colour = G.C.SPECTRAL }
				)
				return nil, true
			end
		end
		if context.end_of_round and not context.retrigger_joker and not context.blueprint then
			if not card.ability.extra.spawn then
				card.ability.extra.spawn = true
				card.ability.extra.text = localize("k_active_ex")
				return {
					message = localize("k_reset"),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			if to_big(card.ability.extra.jollies) < to_big(1) then
				card.ability.extra.jollies = 1
			end
			if to_big(card.ability.extra.unc) < to_big(1) then
				card.ability.extra.unc = 1
			end
			for i = 1, math.min(card.ability.immutable.max_spawns, card.ability.extra.jollies) do
				local jolly = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
				jolly:add_to_deck()
				G.jokers:emplace(jolly)
			end
			for i = 1, math.min(card.ability.immutable.max_spawns, card.ability.extra.unc) do
				local unc = create_card("Joker", G.jokers, nil, 0.9, nil, nil, nil, "sacrifice")
				unc:add_to_deck()
				G.jokers:emplace(unc)
				unc:start_materialize()
			end
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("cry_m_ex"), colour = G.C.SPECTRAL }
			)
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
			"George the Rat",
		},
		code = {
			"Jevonn",
		},
	},
}
--TODO: Fix Brainstorm incompatibility (the joker not the mod)
local reverse = {
	object_type = "Joker",
	name = "cry-reverse",
	key = "reverse",
	effect = "M Joker",
	dependencies = {
		items = {
			"set_cry_m",
			"set_cry_meme",
		},
	},
	config = {
		extra = { type = "Pair" },
		immutable = { max_spawns = 100 },
	},
	pools = { ["Meme"] = true, ["M"] = true },
	pos = { x = 0, y = 0 },
	display_size = { w = 0.7 * 71, h = 0.7 * 95 },
	rarity = 2,
	order = 260,
	cost = 4,
	eternal_compat = false,
	demicoloncompat = true,
	immutable = true,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		if not center.edition or (center.edition and not center.edition.holo) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
		end
		return { vars = { localize(center.ability.extra.type, "poker_hands") } }
	end,
	calculate = function(self, card, context)
		if context.pre_discard and not context.retrigger_joker and not context.blueprint then
			if
				G.FUNCS.get_poker_hand_info(G.hand.highlighted) == card.ability.extra.type
				and #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit
			then
				G.E_MANAGER:add_event(Event({ --self destruct
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(self)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				local spawnamount = math.min(
					card.ability.immutable.max_spawns,
					G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
				) + 1 -- +1 to account for reverse card self destruct
				G.GAME.joker_buffer = G.GAME.joker_buffer + spawnamount
				G.E_MANAGER:add_event(Event({
					func = function()
						for i = 1, spawnamount do
							local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
							card:set_edition({
								holo = true, --certified Thunk moment, this literally took ten minutes to figure out why is it set up like this
							})
							card:add_to_deck()
							G.jokers:emplace(card)
							G.GAME.joker_buffer = 0
						end
						return true
					end,
				}))
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
				)
			end
		end
		if context.forcetrigger then
			local spawnamount = math.min(
				card.ability.immutable.max_spawns,
				G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
			) + 1 -- +1 to account for reverse card self destruct
			G.GAME.joker_buffer = G.GAME.joker_buffer + spawnamount
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, spawnamount do
						local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
						card:set_edition({
							holo = true, --certified Thunk moment, this literally took ten minutes to figure out why is it set up like this
						})
						card:add_to_deck()
						G.jokers:emplace(card)
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			card_eval_status_text(
				card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
			)
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local doodlem = {
	object_type = "Joker",
	name = "cry-doodlem",
	key = "doodlem",
	atlas = "atlasepic",
	pools = { ["M"] = true },
	dependencies = {
		items = {
			"set_cry_m",
			"set_cry_epic",
		},
	},
	config = {
		extra = {
			add = 1,
			init = 2,
		},
		immutable = { max_jollies = 25 },
	},
	pos = { x = 2, y = 0 },
	rarity = "cry_epic",
	cost = 13,
	order = 266,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return {
			vars = {
				number_format(center.ability.extra.add),
				number_format(center.ability.extra.init),
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and not (context.blueprint_card or self).getting_sliced) or context.forcetrigger then
			local jollycount = lenient_bignum(card.ability.extra.init)
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:is_jolly() then
					jollycount = lenient_bignum(to_big(jollycount) + math.floor(card.ability.extra.add))
				end
			end
			if to_big(jollycount) > to_big(card.ability.immutable.max_jollies) then
				jollycount = card.ability.immutable.max_jollies
			end --reduce excessive consumeable spam (Lag)
			for i = 1, jollycount do
				local card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, nil, "cry_doodlem")
				card:set_edition({ negative = true })
				card:add_to_deck()
				G.consumeables:emplace(card)
			end
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
			)
			return nil, true
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local virgo = {
	object_type = "Joker",
	name = "cry-virgo",
	key = "virgo",
	pools = { ["M"] = true },
	dependencies = {
		items = {
			"set_cry_m",
			"set_cry_epic",
		},
	},
	pos = { x = 1, y = 2 },
	soul_pos = { x = 10, y = 0, extra = { x = 2, y = 2 } },
	config = {
		extra = {
			bonus = 4,
			type = "Pair",
		},
		immutable = { max_summons = 80 },
	},
	rarity = "cry_epic",
	cost = 8,
	order = 265,
	eternal_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		if not center.edition or (center.edition and not center.edition.polychrome) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		end
		return {
			vars = {
				number_format(center.ability.extra.bonus),
				localize(center.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasepic",
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.before
			and next(context.poker_hands["Pair"])
			and not context.blueprint
		then
			card.ability.extra_value = lenient_bignum(card.ability.extra_value + to_big(card.ability.extra.bonus)) --this doesn't seem to work with retrigger jokers. Intentional?
			card:set_cost()
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_val_up"),
				colour = G.C.MONEY,
			})
		end
		if (context.selling_self and not context.blueprint and not context.retrigger_joker) or context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							local summon = lenient_bignum(
								math.floor(
									(to_big(card.ability.extra_value) + card.ability.extra.bonus)
										/ to_big(card.ability.extra.bonus)
								)
							)
							if summon == nil or to_big(summon) < to_big(1) then
								summon = 1
							end --precautionary measure, just in case
							for i = 1, math.min(card.ability.immutable.max_summons, summon) do --another precautionary measure
								local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
								card:set_edition({
									polychrome = true,
								})
								card:add_to_deck()
								G.jokers:emplace(card)
							end
							return true
						end,
					}))
					card_eval_status_text(
						card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
					)
					return true
				end,
			}))
			return nil, true
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local smallestm = {
	object_type = "Joker",
	name = "cry-smallestm",
	dependencies = {
		items = {
			"set_cry_m",
			"set_cry_epic",
			"tag_cry_double_m",
		},
	},
	key = "smallestm",
	pools = { ["M"] = true },
	config = { extra = { type = "Pair" } },
	pos = { x = 5, y = 0 },
	rarity = "cry_epic",
	cost = 8,
	order = 264,
	blueprint_compat = true,
	atlas = "atlasepic",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_cry_double_m" }
		return {
			vars = {
				localize(center.ability.extra.type, "poker_hands"),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
			--This isn't retrigger joker compatible for some reason
			if context.scoring_name == card.ability.extra.type then
				local tag = Tag("tag_cry_double_m")
				tag.ability.shiny = Cryptid.is_shiny()
				add_tag(tag)
				play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
				play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
				card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
					message = localize("cry_m_ex"),
					colour = G.C.FILTER,
				})
			end
		end
		if context.forcetrigger then
			local tag = Tag("tag_cry_double_m")
			tag.ability.shiny = Cryptid.is_shiny()
			add_tag(tag)
			play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
			play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
			card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
				message = localize("cry_m_ex"),
				colour = G.C.FILTER,
			})
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local biggestm = {
	object_type = "Joker",
	name = "cry-biggestm",
	key = "biggestm",
	config = {
		extra = {
			x_mult = 7,
			type = "Pair",
			check = false,
			text = "Inactive",
		},
	},
	pos = { x = 3, y = 3 },
	display_size = { w = 1.7 * 71, h = 1.7 * 95 },
	dependencies = {
		items = {
			"set_cry_m",
			"set_cry_epic",
		},
	},
	rarity = "cry_epic",
	pools = { ["M"] = true },
	cost = 12,
	order = 268,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasepic",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.x_mult),
				localize(center.ability.extra.type, "poker_hands"),
				center.ability.extra.text,
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.joker_main and card.ability.extra.check) or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
				colour = G.C.MULT,
			}
		end
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if context.scoring_name == card.ability.extra.type and not card.ability.extra.check then
				card.ability.extra.check = true
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_active_ex"),
					colour = G.C.FILTER,
				})
				card.ability.extra.text = localize("cry_active")
			end
		end
		if
			context.end_of_round
			and card.ability.extra.check
			and not context.blueprint
			and not context.retrigger_joker
			and not context.individual
			and not context.repetition
		then
			card.ability.extra.check = false
			card.ability.extra.text = localize("cry_inactive")
			return {
				message = localize("k_reset"),
				card = card,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Kailen",
		},
		art = {
			"Ein13",
		},
		code = {
			"Kailen",
		},
	},
}
local mprime = {
	dependencies = {
		items = {
			"set_cry_m",
			"c_cry_gateway",
		},
	},
	object_type = "Joker",
	name = "cry-mprime",
	key = "mprime",
	pos = { x = 0, y = 5 },
	soul_pos = { x = 2, y = 5, extra = { x = 1, y = 5 } },
	config = {
		extra = {
			mult = 1.05,
			bonus = 0.04,
		},
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				number_format(center.ability.extra.mult),
				number_format(center.ability.extra.bonus),
			},
		}
	end,
	rarity = "cry_exotic",
	cost = 50,
	order = 1000000,
	blueprint_compat = true,
	atlas = "atlasexotic",
	perishable_compat = false,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.selling_card and (context.card:is_jolly()) then
			if not context.blueprint then
				card.ability.extra.mult = lenient_bignum(to_big(card.ability.extra.mult) + card.ability.extra.bonus)
			end
			if not context.retrigger_joker then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("cry_m_ex"), colour = G.C.DARK_EDITION }
				)
			end
		elseif
			context.end_of_round
			and not context.individual
			and not context.repetition
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
			and not context.retrigger_joker
		then
			local mjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + mjoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if mjoker > 0 then
						local card = create_card("M", G.jokers, nil, nil, nil, nil, nil, "mprime")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
		elseif context.other_joker then
			if
				context.other_joker
				and (
					context.other_joker:is_jolly() or Cryptid.safe_get(context.other_joker.config.center, "pools", "M")
				)
			then
				if not Talisman.config_file.disable_anims then
					G.E_MANAGER:add_event(Event({
						func = function()
							context.other_joker:juice_up(0.5, 0.5)
							return true
						end,
					}))
				end
				return {
					message = localize({
						type = "variable",
						key = "a_powmult",
						vars = { number_format(card.ability.extra.mult) },
					}),
					Emult_mod = lenient_bignum(card.ability.extra.mult),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
		if context.forcetrigger then
			card.ability.extra.mult = lenient_bignum(to_big(card.ability.extra.mult) + card.ability.extra.bonus)
			local mjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + mjoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if mjoker > 0 then
						local card = create_card("M", G.jokers, nil, nil, nil, nil, nil, "mprime")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				Emult_mod = lenient_bignum(card.ability.extra.mult),
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local macabre = {
	dependencies = {
		items = {
			"set_cry_m",
		},
	},
	object_type = "Joker",
	name = "cry-Macabre Joker",
	key = "macabre",
	pools = { ["M"] = true },
	order = 263,
	pos = { x = 1, y = 2 },
	display_size = { w = 1.2 * 71, h = 1.2 * 95 },
	config = {
		extra = { add = 1 },
		immutable = { max_spawn = 15 },
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				math.min(center.ability.immutable.max_spawn, center.ability.extra.add),
			},
		}
	end,
	rarity = 1,
	cost = 5,
	atlas = "atlasthree",
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.setting_blind and not (context.blueprint or context.retrigger_joker) and not card.getting_sliced)
			or context.forcetrigger
		then
			if to_big(card.ability.extra.add) < to_big(1) then
				card.ability.extra.add = 1
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					local triggered = false
					local destroyed_jokers = {}
					for _, v in pairs(G.jokers.cards) do
						if
							v ~= card
							and not v:is_jolly()
							and v.config.center.key ~= "j_cry_mprime"
							and not (
								SMODS.is_eternal(v)
								or v.getting_sliced
								or Cryptid.safe_get(v.config.center, "pools", "M")
							)
						then
							destroyed_jokers[#destroyed_jokers + 1] = v
						end
					end
					for _, v in pairs(destroyed_jokers) do
						if v.config.center.rarity == "cry_exotic" then
							check_for_unlock({ type = "what_have_you_done" })
						end
						triggered = true
						v.getting_sliced = true
						v:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						for i = 1, math.min(card.ability.immutable.max_spawn, card.ability.extra.add) do
							local jolly_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
							jolly_card:add_to_deck()
							G.jokers:emplace(jolly_card)
						end
					end
					if triggered then
						card:juice_up(0.8, 0.8)
						play_sound("slice1", 0.96 + math.random() * 0.08)
					end
					return true
				end,
			}))
		end
	end,
	cry_credits = {
		idea = {
			"SDM_0",
		},
		art = {
			"SDM_0",
		},
		code = {
			"SDM_0",
		},
	},
}
local megg = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-megg",
	key = "megg",
	pools = { ["M"] = true },
	blueprint_compat = false,
	eternal_compat = false,
	demicoloncompat = true,
	pos = { x = 0, y = 4 },
	order = 262,
	config = {
		extra = {
			amount = 0,
			amount_mod = 1,
		},
		immutable = { max_amount = 200 },
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		return {
			vars = {
				math.max(1, center.ability.extra.amount_mod),
				math.min(center.ability.immutable.max_amount, math.floor(center.ability.extra.amount)),
				(center.ability.extra.amount > 1 and "Jokers") or "Joker",
			},
		}
	end,
	rarity = 1,
	cost = 4,
	atlas = "atlasthree",
	calculate = function(self, card, context)
		if
			context.end_of_round
			and to_big(card.ability.extra.amount) < to_big(card.ability.immutable.max_amount)
			and not (context.individual or context.repetition or context.blueprint)
		then
			card.ability.extra.amount =
				lenient_bignum(card.ability.extra.amount + math.max(1, to_big(card.ability.extra.amount_mod)))
			if to_big(card.ability.extra.amount) > to_big(card.ability.immutable.max_amount) then
				card.ability.extra.amount = lenient_bignum(card.ability.immutable.max_amount)
			end
			card_eval_status_text(
				card,
				"extra",
				nil,
				nil,
				nil,
				{ message = { localize("cry_jolly_ex") }, colour = G.C.FILTER }
			)
			return nil, true
		end
		if
			context.selling_self
			and not (context.blueprint or context.retrigger_joker_check or context.retrigger_joker)
			and to_big(card.ability.extra.amount) > to_big(0)
		then
			for i = 1, math.min(card.ability.immutable.max_amount, math.floor(card.ability.extra.amount)) do
				local jolly_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
				jolly_card:add_to_deck()
				G.jokers:emplace(jolly_card)
			end
		end
		if context.forcetrigger then
			card.ability.extra.amount =
				lenient_bignum(card.ability.extra.amount + math.max(1, to_big(card.ability.extra.amount_mod)))
			if to_big(card.ability.extra.amount) > to_big(card.ability.immutable.max_amount) then
				card.ability.extra.amount = lenient_bignum(card.ability.immutable.max_amount)
			end
			for i = 1, math.min(card.ability.immutable.max_amount, math.floor(card.ability.extra.amount)) do
				local jolly_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
				jolly_card:add_to_deck()
				G.jokers:emplace(jolly_card)
			end
		end
	end,
	cry_credits = {
		idea = {
			"Watermelon Lover",
		},
		art = {
			"Watermelon Lover",
		},
		code = {
			"SDM_0",
		},
	},
}
local longboi = {
	dependencies = {
		items = { "set_cry_m" },
	},
	object_type = "Joker",
	name = "cry-longboi",
	key = "longboi",
	pos = { x = 5, y = 4 },
	config = {
		extra = {
			monster = 1,
			bonus = 0.75,
		},
		immutable = { max_bonus = 0.75 },
	},
	rarity = 1,
	cost = 5,
	order = 261,
	pools = { ["M"] = true },
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				math.max(center.ability.immutable.max_bonus, center.ability.extra.bonus),
				number_format(center.ability.extra.monster),
			},
		}
	end,
	atlas = "atlasthree",
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition then
			G.GAME.monstermult = lenient_bignum(
				G.GAME.monstermult + math.max(card.ability.immutable.max_bonus, to_big(card.ability.extra.bonus))
			)
			if not context.retrigger_joker then
				return {
					card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
						message = localize("cry_m_ex"),
						colour = G.C.FILTER,
					}),
				}
			end
		elseif context.joker_main and to_big(card.ability.extra.monster) > to_big(1) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.monster) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.monster),
			}
		end
		if context.forcetrigger then
			G.GAME.monstermult = lenient_bignum(
				G.GAME.monstermult + math.max(card.ability.immutable.max_bonus, to_big(card.ability.extra.bonus))
			)
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.monster) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.monster),
			}
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.monster = lenient_bignum(G.GAME and G.GAME.monstermult or 1)
		if to_big(card.ability.extra.monster) >= to_big(1234567654321) then
			card.children.center:set_sprite_pos({ x = 7, y = 5 })
		elseif to_big(card.ability.extra.monster) >= to_big(12321) then
			card.children.center:set_sprite_pos({ x = 7, y = 6 })
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Watermelon Lover",
		},
		code = {
			"Jevonn",
		},
	},
}
local ret_items = {
	jollysus,
	bubblem,
	foodm,
	mstack,
	mneon,
	notebook,
	bonk,
	loopy,
	sacrifice,
	reverse,
	macabre,
	megg,
	longboi,
	doodlem,
	virgo,
	smallestm,
	biggestm,
	mprime,
	scrabble,
}
--retriggering system for M Vouchers
function Cryptid.get_m_retriggers(self, card, context)
	local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
	if G.GAME.used_vouchers.v_cry_pairamount_plus then
		local pairs = 0
		for i = 1, #G.play.cards - 1 do
			for j = i + 1, #G.play.cards do
				local m, n = G.play.cards[i], G.play.cards[j]
				if m:get_id() == n:get_id() then
					pairs = pairs + 1
				end
			end
		end
		return pairs
	end
	if G.GAME.used_vouchers.v_cry_repair_man and poker_hands["Pair"] then
		return 1
	end
	if G.GAME.used_vouchers.v_cry_pairing and text == "Pair" then
		return 1
	end
	return 0
end
return {
	name = "M Jokers",
	init = function() end,
	items = ret_items,
}
