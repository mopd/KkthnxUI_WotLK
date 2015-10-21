local LSM = LibStub("LibSharedMedia-3.0")

if LSM == nil then return end

-- Fonts
LSM:Register("font", "KNORM_Font", [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]])
LSM:Register("font", "KDMG_Font", [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]])
LSM:Register("font", "KUF_Font", [[Interface\AddOns\KkthnxUI\Media\Fonts\Unitframe.ttf]])
-- Tooltips
LSM:Register("font", "KkthnxBorder", [[Interface\AddOns\KkthnxUI\Media\Tooltips\KkthnxBorder.blp]])
-- Statusbars
LSM:Register("statusbar", "KkthnxTex", [[Interface\AddOns\KkthnxUI\Media\Textures\KkthnxTex.blp]])
-- Sounds
LSM:Register("sound", "GMWhisper", [[Sound\Spells\Simongame_visual_gametick.wav]])
LSM:Register("sound", "KWhisper", [[Interface\AddOns\KkthnxUI\Media\Sounds\KWhisper.ogg]])