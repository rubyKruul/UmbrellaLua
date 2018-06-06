local Utility = require ("Utility")

local AutoUseItems = {}

AutoUseItems.optionSheepstick = Menu.AddOption({"Item Specific"}, "Sheepstick", "Auto use sheepstick on enemy hero once available")

function AutoUseItems.OnUpdate()
    local myHero = Heroes.GetLocal()
    if not myHero then return end
    
function AutoUseItems.item_sheepstick(myHero)
    local item = NPC.GetItem(myHero, "item_sheepstick", true)
    if not item or not Ability.IsCastable(item, NPC.GetMana(myHero)) then return end

    local range = Utility.GetCastRange(myHero, item) -- 800
    local enemyAround = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)

    local minDistance = 99999
    local target = nil
    for i, enemy in ipairs(enemyAround) do
        if not NPC.IsIllusion(enemy) and not Utility.IsDisabled(enemy)
            and Utility.CanCastSpellOn(enemy) and not Utility.IsLinkensProtected(enemy)
            and not Utility.IsLotusProtected(enemy) then
            local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(enemy)):Length()
            if dis < minDistance then
                minDistance = dis
                target = enemy
            end
        end
    end
 if target then Ability.CastTarget(item, target) end
  end
return AutoUseItems
