local autoitems = {}
local BsleepTick = nil

autoitems.optionEnable = Menu.AddOptionBool({"Utility","AutoItems"},"bottle", false)
autoitems.stickEnable = Menu.AddOptionBool({"Utility","AutoItems"},"magick stick", false)
autoitems.wandEnable = Menu.AddOptionBool({"Utility","AutoItems"},"magick wand", false)

function autoitems.OnUpdate()

  local me = Heroes.GetLocal()
  if not me then return	end

  local bottle = NPC.GetItem(me, "item_bottle")

	local lowstick = NPC.GetItem(me, "item_magic_stick")
	local gradestick = NPC.GetItem(me, "item_magic_wand")

  if Menu.IsEnabled(autoitems.optionEnable) and bottle and (NPC.HasModifier(me, "modifier_item_invisibility_edge_windwalk") or NPC.HasModifier(me, "modifier_item_silver_edge_windwalk" or NPC.HasModifier(me, "modifier_invisible")))
    and not NPC.IsChannellingAbility(me) and Item.GetCurrentCharges(bottle) > 0 and Entity.GetHealth(me) < 120 then
      Ability.CastNoTarget(bottle)
    end

  if Menu.IsEnabled(autoitems.stickEnable) and lowstick  and Item.GetCurrentCharges(lowstick) > 0 and Entity.GetHealth(me) < 120 then
    Ability.CastNoTarget(lowstick)
  end

  if Menu.IsEnabled(autoitems.wandEnable) and gradestick and Item.GetCurrentCharges(gradestick) > 0 and Entity.GetHealth(me) < 120 then
    Ability.CastNoTarget(gradestick)
  end


end

return autoitems