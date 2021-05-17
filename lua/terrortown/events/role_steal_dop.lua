if CLIENT then
    EVENT.title = "title_role_steal_dop"
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_dop.vmt")

    function EVENT:GetText()
        local roleText = {
            {
                string = "desc_role_steal",
                params = {
                    nick = self.event.mimic.nick,
                    victim = self.event.victim.nick
                }
            }
        }
        if not self.event.steal then
            roleText[1].string = "desc_role_copy"
        end

        return roleText
    end
end

if SERVER then
    function EVENT:Trigger(mim, vic, steal)
        local eventData = {
            mimic = {
                nick = mim:Nick(),
                sid64 = mim:SteamID64()
            },
            victim = {
                nick = vic:Nick(),
                sid64 = vic:SteamID64()
            },
            steal = steal
        }

        return self:Add(eventData)
    end
end