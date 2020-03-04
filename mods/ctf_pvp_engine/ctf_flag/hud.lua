-- TODO: delete flags if they are removed (ctf.next, or captured)

ctf.hud.register_part(function(player, name, tplayer)
	-- Check all flags
	local alert = nil
	local color = "0xFFFFFF"
	if ctf.setting("flag.alerts") then
		if ctf.setting("flag.alerts.neutral_alert") then
			alert = "Punch the enemy flag! Protect your flag!"
		end
		local claimed = ctf_flag.collect_claimed()
		for _, flag in pairs(claimed) do
			if flag.claimed.player == name then
				alert = "You've got the flag! Run back and punch your flag!"
				color = "0xFF0000"
				break
			elseif flag.team == tplayer.team then
				alert = "Kill " .. flag.claimed.player .. ", they have your flag!"
				color = "0xFF0000"
				break
			else
				alert = "Protect " .. flag.claimed.player .. ", he's got the enemy flag!"
				color = "0xFF0000"
			end
		end
	end

	-- Display alert
	if alert then
		if ctf.hud:exists(player, "ctf:hud_team_alert") then
			ctf.hud:change(player, "ctf:hud_team_alert", "text", alert)
			ctf.hud:change(player, "ctf:hud_team_alert", "number", color)
		else
			ctf.hud:add(player, "ctf:hud_team_alert", {
				hud_elem_type = "text",
				position      = {x = 1, y = 0},
				scale         = {x = 100, y = 100},
				text          = alert,
				number        = color,
				offset        = {x = -10, y = 50},
				alignment     = {x = -1, y = 0}
			})
		end
	else
		ctf.hud:remove(player, "ctf:hud_team_alert")
	end
end)
