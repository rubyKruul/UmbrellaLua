local AutoUseItems = {}

AutoUseItems.IsToggled = Menu.AddOptionBool({"Utility"}, "Sheepstick", "Auto use sheepstick on enemy hero once available")

function Sheepstick.OnUpdate()
	local hero = Heroes.GetLocal()
	if not hero or not Menu.IsEnabled(Sheepstick.IsToggled) or not Sheepstick.SleepCheck(0.1, "updaterate") or not Entity.IsAlive(hero) or NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return end
	local sheepstick = NPC.GetItem(hero, "item_sheepstick", true)
	if not sheepstick then
		for i = 2, 5 do
			sheepstick = NPC.GetItem(hero, "item_sheepstick_" .. i, true)
			if sheepstick then break end
		end
	end	
	if not sheepstick or not Ability.IsReady(sheepstick) or not Ability.IsCastable(sheepstick, Ability.GetManaCost(sheepstick))  then return end	
	local target = sheepstick.FindTarget(hero, sheepstick)
	if not target then return end
	Ability.CastTarget(sheepstick, target)	
	sheepstick.Sleep(0.1, "updaterate");
end

function Sheepstick.FindTarget(me, item)	
	local entities = Heroes.GetAll()
	for index, ent in pairs(entities) do
		local enemyhero = Heroes.Get(index)
		if not Entity.IsSameTeam(me, enemyhero) and not NPC.IsLinkensProtected(enemyhero) and not NPC.IsIllusion(enemyhero) and NPC.IsEntityInRange(me, enemyhero, Ability.GetCastRange(item) + NPC.GetCastRangeBonus(me)) then
			local amplf = 0
			if NPC.GetItem(me, "item_kaya", true) then
				amplf = 0.1
			end	
	end
end

return AutoUseItems