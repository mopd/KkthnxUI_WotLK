local K, C, L = unpack(select(2, ...))
if C["chat"].enable ~= true or C["chat"].spam ~= true then return end

K.ChatSpamList = {
	"$%d+.+%d+g", -- mwatches $9.99
	"%d+g.+$%d+", -- matches 5g $9
	"%d+e.?u.?r.+%d+g", -- matches 9eu(r) 5g
	"%d+g.+%d+e.?u.?r", -- matches 5g 9eu(r)
	"%d+g.+e.?u.?r%d+", -- matches 5g eur 5 (utf8 scrambled)
	"\226\130\172%d+.+%d+g", -- matches €9 5g
	"%d+g.+\226\130\172%d+", -- matches 5g €9
	"\194\163%d+.+%d+g", -- matches £9 10g
	"%d+g.+\194\163%d+", -- matches 10g £9
	"s.?k.?y.?p.?e?", -- matches skype under almost all obfuscation's
	"s.?k.?p.?y.?e?", -- matches skpye under almost all obfuscation's
	"anal", -- anal [gtfo]
	"wins? mount",
	"account.?share","accshare",
	"qq%d+",
	
	-- on english speaking realms, these characters are very very rare
	-- and are mostly used to try and get around spam blockers
	"å","à","á","ä","â","ã",
	"è","é","ë","ê",
	"ì","í","ï","î",
	"ò","ó","ö","ô","õ",
	"ù","ú","ü","û",
	"¥",
	-- target markers
	"{square}","{star}","{triangle}","{circle}","{skull}","{diamond}"
}