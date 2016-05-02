local LSM = LibStub('LibSharedMedia-3.0')

if LSM == nil then return end

-- LSM Fonts
LSM:Register("font", "KkUI Normal", [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]])
LSM:Register("font", "KkUI Damage", [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]])
-- LSM Borders
LSM:Register("border", "KkUI Border", [[Interface\Tooltips\UI-Tooltip-Border]])
LSM:Register("border", "KkUI GlowTex", [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex]])
-- LSM Statusbars
LSM:Register("statusbar", "KkUI StatusBar", [[Interface\TargetingFrame\UI-StatusBar]])
-- LSM Sounds
LSM:Register("sound", "GMWhisper", [[Sound\Spells\Simongame_visual_gametick.wav]])
LSM:Register("sound", "KkUI Whisper", [[Interface\AddOns\KkthnxUI\Media\Sounds\KWhisper.ogg]])