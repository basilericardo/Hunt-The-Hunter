----------------------------------SOM EM LOOP AO INICIAR----------------------------------display.setStatusBar (display.HiddenStatusBar)
ambianceSound = audio.loadStream("song_ambiance_forest.mp3")

ambianceSoundChannel = audio.play( ambianceSound, {channel = 1, loops = -1} )

---------------------------------------- BACKGROUND ----------------------------------------
LAR = display.contentWidth 	-- Largura da tela
ALT = display.contentHeight	-- Altura da tela
local bgCeu = display.newImageRect ("img_bg_ceu.png", LAR, ALT)
	bgCeu.x = LAR/2
	bgCeu.y = ALT/2
	
    ---------- Nuvens em loop ----------
    rolagem = 0.4 -- Velocidade da rolagem

    local bgNuvem = display.newImageRect ("img_bg_nuvem.png", LAR, ALT)
    bgNuvem.x = LAR/2
    bgNuvem.y = ALT/2

    local bgNuvem2 = display.newImageRect ("img_bg_nuvem.png", LAR, ALT)
    bgNuvem2.x = bgNuvem.x + (LAR - 0.2)
    bgNuvem2.y = ALT/2

    local bgNuvem3 = display.newImageRect ("img_bg_nuvem.png", LAR, ALT)
    bgNuvem3.x = bgNuvem2.x + (LAR - 0.3)
    bgNuvem3.y = ALT/2

    local function bgNuvemRolagem (event)
    bgNuvem.x = bgNuvem.x - rolagem
	bgNuvem2.x = bgNuvem2.x - rolagem
	bgNuvem3.x = bgNuvem3.x - rolagem	
	
	if (bgNuvem.x + bgNuvem.contentWidth) < 0 then
		bgNuvem:translate(LAR * 3, 0)
	end
	if (bgNuvem2.x + bgNuvem2.contentWidth) < 0 then
		bgNuvem2:translate(LAR * 3, 0)
	end
	if (bgNuvem3.x + bgNuvem3.contentWidth) < 0 then
		bgNuvem3:translate(LAR * 3, 0)
	end		
    end
    Runtime:addEventListener("enterFrame", bgNuvemRolagem)		
--------------------------------------		
	
local bgTerra = display.newImageRect ("img_bg_terra.png", LAR, ALT)
	bgTerra.x = LAR/2
	bgTerra.y = ALT/2
	
local bgArbusto = display.newImageRect ("img_bg_arbustos.png", LAR, (ALT * 0.70))
	bgArbusto.x = LAR/2
	bgArbusto.y = ALT
-------------------------------------------------------------------------------------------------
