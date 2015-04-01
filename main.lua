	------------------------------------------------------------------------------------------------------------
	-- GLOBAL
	------------------------------------------------------------------------------------------------------------
	display.setStatusBar(display.HiddenStatusBar)
	local hit = audio.loadSound('song_hit.mp3')
	local ambianceSound = audio.loadStream('song_ambiance_forest.mp3')local int controlePonto = 0local int incrementoVelocidade = 100
	
	------------------------------------------------------------------------------------------------------------
	-- BACKGROUND
	------------------------------------------------------------------------------------------------------------
	LAR = display.contentWidth 	-- Largura da tela
	ALT = display.contentHeight	-- Altura da tela
	
	ambianceSoundChannel = audio.play(ambianceSound, {channel = 1, loops = -1})
	
	local imgBgCeu = display.newImageRect ("img_bg_ceu.png", LAR, ALT)
		imgBgCeu.x = LAR/2
		imgBgCeu.y = ALT/2
		
	    --Nuvens em loop
	    rolagem = 0.4 -- Velocidade da rolagem
	
	    local imgBgNuvem = display.newImageRect ("img_bg_nuvem.png", LAR, ALT)
	    imgBgNuvem.x = LAR/2
	    imgBgNuvem.y = ALT/2
	
	    local imgBgNuvem2 = display.newImageRect ("img_bg_nuvem.png", LAR, ALT)
	    imgBgNuvem2.x = imgBgNuvem.x + (LAR - 0.2)
	    imgBgNuvem2.y = ALT/2
	
	    local imgBgNuvem3 = display.newImageRect ("img_bg_nuvem.png", LAR, ALT)
	    imgBgNuvem3.x = imgBgNuvem2.x + (LAR - 0.3)
	    imgBgNuvem3.y = ALT/2
	
	    local function imgBgNuvemRolagem (event)
	    imgBgNuvem.x = imgBgNuvem.x - rolagem
		imgBgNuvem2.x = imgBgNuvem2.x - rolagem
		imgBgNuvem3.x = imgBgNuvem3.x - rolagem	
		
		if (imgBgNuvem.x + imgBgNuvem.contentWidth) < 0 then
			imgBgNuvem:translate(LAR * 3, 0)
		end
		if (imgBgNuvem2.x + imgBgNuvem2.contentWidth) < 0 then
			imgBgNuvem2:translate(LAR * 3, 0)
		end
		if (imgBgNuvem3.x + imgBgNuvem3.contentWidth) < 0 then
			imgBgNuvem3:translate(LAR * 3, 0)
		end		
	    end
	    Runtime:addEventListener("enterFrame", imgBgNuvemRolagem)		
	    -----
		
	local imgBgTerra = display.newImageRect ("img_bg_terra.png", LAR, ALT)
		imgBgTerra.x = LAR/2
		imgBgTerra.y = ALT/2
	
	local imgHunter = display.newImage( "img_person_vilao.png" )
	imgHunter.y = 600
	
	local imgHunter2 = display.newImage( "img_person_vilao_2.png" )
	imgHunter2.y = 600
	
	local imgAnimalOne = display.newImage( "img_animal_one.png" )
	imgAnimalOne.y = 600
	
	local bgArbusto = display.newImageRect ("img_bg_arbustos.png", LAR, (ALT * 0.70))
		bgArbusto.x = LAR/2
		bgArbusto.y = ALT
	
	local scoreName = display.newText('Score:', 440, 10, native.systemFont, 12)
	local scoreCount = display.newText('0', 470, 10, native.systemFont, 12)
	
		------------------------------------------------------------------------------------------------------------
		-- TRANSIÇÃO [VILÕES]
		------------------------------------------------------------------------------------------------------------	
		local int timeVilaoOneUp = 0;
		local int timeVilaoOneDown = 0;
		local int timeVilaoTwoUp = 0;
		local int timeVilaoTwoDown = 0;
		local int timeAnimalOneUp = 0;
		local int timeAnimalOneDown = 0;
		
		function transitionDown()
		   transition.to(imgHunter, {time = 3000, x = imgHunter.x, y = 600, onComplete = transitionUp})
		end
		
		function transitionUp()
			imgHunter.alpha = 1;
			imgHunter.x = math.random (20, 215)
		    transition.to(imgHunter, {time = 3000, x = imgHunter.x, y = 220, onComplete = transitionDown})
		end
		
		function imgHunter:tap(event)
			audio.play(hit)
			imgHunter.alpha = 0;
			scoreCount.text = tostring(tonumber(scoreCount.text ) + 10 )		controlePonto = (controlePonto) + (tonumber(scoreCount.text))
		end
		
		function transitionDown2()
		   transition.to(imgHunter2, {time = 3000, x = imgHunter2.x, y = 600, onComplete = transitionUp2})
		end
		
		function transitionUp2()
			imgHunter2.alpha = 1;
			imgHunter2.x = math.random (270, 450)
		    transition.to(imgHunter2, {time = 2000, x = imgHunter2.x, y = 220, onComplete = transitionDown2})
		end
		
		function imgHunter2:tap(event)
			audio.play(hit)
			imgHunter2.alpha = 0;
			scoreCount.text = tostring(tonumber(scoreCount.text ) + 10 )	controlePonto = (controlePonto) + (tonumber(scoreCount.text))	
		end
		
		------------------------------------------------------------------------------------------------------------
		-- TRANSIÇÃO [ANIMAIS]
		------------------------------------------------------------------------------------------------------------
		
		function transitionDownAnimalOne()
		   transition.to(imgAnimalOne, {time = 4000, x = imgAnimalOne.x, y = 600, onComplete = transitionUpAnimalOne})
		end
		
		function transitionUpAnimalOne()
			imgAnimalOne.alpha = 1;
			imgAnimalOne.x = math.random (20, 450)
		    transition.to(imgAnimalOne, {time = 2000, x = imgAnimalOne.x, y = 220, onComplete = transitionDownAnimalOne})
		end
		
		function imgAnimalOne:tap(event)
			audio.play(hit)
			imgAnimalOne.alpha = 0;
		end
		
		------------------------------------------------------------------------------------------------------------
		-- MAIN
		------------------------------------------------------------------------------------------------------------	
		transitionUp()
		transitionUp2()
		transitionUpAnimalOne()
		imgHunter:addEventListener("tap", imgHunter)
		imgHunter2:addEventListener("tap", imgHunter2)
		imgAnimalOne:addEventListener("tap", imgAnimalOne)