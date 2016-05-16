local K, C, L, _ = select(2, ...):unpack()
if C["blizzard"].capturebar ~= true then return end

local _G = _G
local select = select
local unpack = unpack
local hooksecurefunc = hooksecurefunc

-- Reposition Capture Bar
local function CaptureUpdate()
	if not NUM_EXTENDED_UI_FRAMES then return end
	for i = 1, NUM_EXTENDED_UI_FRAMES do
		local barname = "WorldStateCaptureBar"..i
		local bar = _G[barname]

		if(bar and bar:IsShown()) then
			bar:ClearAllPoints()
			bar:SetPoint(unpack(C["position"].capturebar))
			if not bar.skinned then
				local left = _G[barname.."LeftBar"]
				local right = _G[barname.."RightBar"]
				local middle = _G[barname.."MiddleBar"]
				select(4, bar:GetRegions()):Hide()
				_G[barname.."LeftLine"]:SetAlpha(0)
				_G[barname.."RightLine"]:SetAlpha(0)
				_G[barname.."LeftIconHighlight"]:SetAlpha(0)
				_G[barname.."RightIconHighlight"]:SetAlpha(0)

				left:SetTexture(C["media"].texture)
				right:SetTexture(C["media"].texture)
				middle:SetTexture(C["media"].texture)

				left:SetVertexColor(0.2, 0.6, 1)
				right:SetVertexColor(0.9, 0.2, 0.2)
				middle:SetVertexColor(0.8, 0.8, 0.8)

				bar:SetBackdrop(nil)

				bar.skinned = true
			end
		end
	end
end
hooksecurefunc("WorldStateAlwaysUpFrame_Update", CaptureUpdate)