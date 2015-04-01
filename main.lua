------------------------------------------------------------------------------------------------------------
-- GLOBAL
------------------------------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
local hit = audio.loadSound('song_hit.mp3')
local ambianceSound = audio.loadStream('song_ambiance_forest.mp3')
local int controlePonto = 0

-----------------------------------------
-- CONTROLE DA VELOCIDADE DE TRANSIÇÃO --
-----------------------------------------
local int timeVilaoOneUp = 4500;
local int timeVilaoOneDown = 4500;
local int timeVilaoTwoUp = 4000;
local int timeVilaoTwoDown = 3500;
local int timeAnimalOneUp = 3500;
local int timeAnimalOneDown = 4500;

function controleVelocidade()
	if controlePonto > 0 and controlePonto < 50 then
		timeVilaoOneUp 			= 4500;
		timeVilaoOneDown 		= 4500;
		timeVilaoTwoUp 			= 4000;
		timeVilaoTwoDown 		= 3500;
		timeAnimalOneUp 		= 4000;
		timeAnimalOneDown 		= 4500;
	end

	if controlePonto > 50 and controlePonto < 100 then
		timeVilaoOneUp 			= 4500 - 100;
		timeVilaoOneDown 		= 4500 - 100;
		timeVilaoTwoUp 			= 4000 - 100;
		timeVilaoTwoDown 		= 3500 - 100;
		timeAnimalOneUp 		= 4000 - 100;
		timeAnimalOneDown 		= 4500 - 100;
	end

	if controlePonto > 100 and controlePonto < 200 then
		timeVilaoOneUp 			= 4500 - 200;
		timeVilaoOneDown 		= 4500 - 200;
		timeVilaoTwoUp 			= 4000 - 200;
		timeVilaoTwoDown 		= 3500 - 200;
		timeAnimalOneUp 		= 4000 - 200;
		timeAnimalOneDown 		= 4500 - 200;
	end

	if controlePonto > 200 and controlePonto < 300 then
		timeVilaoOneUp 			= 4500 - 300;
		timeVilaoOneDown 		= 4500 - 300;
		timeVilaoTwoUp 			= 4000 - 300;
		timeVilaoTwoDown 		= 3500 - 300;
		timeAnimalOneUp 		= 4000 - 300;
		timeAnimalOneDown 		= 4500 - 300;
	end

	if controlePonto > 300 and controlePonto < 400 then
		timeVilaoOneUp 			= 4500 - 400;
		timeVilaoOneDown 		= 4500 - 400;
		timeVilaoTwoUp 			= 4000 - 400;
		timeVilaoTwoDown 		= 3500 - 400;
		timeAnimalOneUp 		= 4000 - 400;
		timeAnimalOneDown 		= 4500 - 400;
	end

	if controlePonto > 400 and controlePonto < 500 then
		timeVilaoOneUp 			= 4500 - 500;
		timeVilaoOneDown 		= 4500 - 500;
		timeVilaoTwoUp 			= 4000 - 500;
		timeVilaoTwoDown 		= 3500 - 500;
		timeAnimalOneUp 		= 4000 - 500;
		timeAnimalOneDown 		= 4500 - 500;
	end

	if controlePonto > 500 and controlePonto < 600 then
		timeVilaoOneUp 			= 4500 - 600;
		timeVilaoOneDown 		= 4500 - 600;
		timeVilaoTwoUp 			= 4000 - 600;
		timeVilaoTwoDown 		= 3500 - 600;
		timeAnimalOneUp 		= 4000 - 600;
		timeAnimalOneDown 		= 4500 - 600;
	end

	if controlePonto > 600 and controlePonto < 700 then
		timeVilaoOneUp 			= 4500 - 700;
		timeVilaoOneDown 		= 4500 - 700;
		timeVilaoTwoUp 			= 4000 - 700;
		timeVilaoTwoDown 		= 3500 - 700;
		timeAnimalOneUp 		= 4000 - 700;
		timeAnimalOneDown 		= 4500 - 700;
	end

	if controlePonto > 700 and controlePonto < 800 then
		timeVilaoOneUp 			= 4500 - 800;
		timeVilaoOneDown 		= 4500 - 800;
		timeVilaoTwoUp 			= 4000 - 800;
		timeVilaoTwoDown 		= 3500 - 800;
		timeAnimalOneUp 		= 4000 - 800;
		timeAnimalOneDown 		= 4500 - 800;
	end

	if controlePonto > 800 and controlePonto < 900 then
		timeVilaoOneUp 			= 4500 - 900;
		timeVilaoOneDown 		= 4500 - 900;
		timeVilaoTwoUp 			= 4000 - 900;
		timeVilaoTwoDown 		= 3500 - 900;
		timeAnimalOneUp 		= 4000 - 900;
		timeAnimalOneDown 		= 4500 - 900;
	end

	if controlePonto > 900 and controlePonto < 1000 then
		timeVilaoOneUp 			= 4500 - 1000;
		timeVilaoOneDown 		= 4500 - 1000;
		timeVilaoTwoUp 			= 4000 - 1000;
		timeVilaoTwoDown 		= 3500 - 1000;
		timeAnimalOneUp 		= 4000 - 1000;
		timeAnimalOneDown 		= 4500 - 1000;
	end

	if controlePonto > 1000 and controlePonto < 1100 then
		timeVilaoOneUp 			= 4500 - 1100;
		timeVilaoOneDown 		= 4500 - 1100;
		timeVilaoTwoUp 			= 4000 - 1100;
		timeVilaoTwoDown 		= 3500 - 1100;
		timeAnimalOneUp 		= 4000 - 1100;
		timeAnimalOneDown 		= 4500 - 1100;
	end

	if controlePonto > 1100 and controlePonto < 1200 then
		timeVilaoOneUp 			= 4500 - 1200;
		timeVilaoOneDown 		= 4500 - 1200;
		timeVilaoTwoUp 			= 4000 - 1200;
		timeVilaoTwoDown 		= 3500 - 1200;
		timeAnimalOneUp 		= 4000 - 1200;
		timeAnimalOneDown 		= 4500 - 1200;
	end

	if controlePonto > 1200 and controlePonto < 1300 then
		timeVilaoOneUp 			= 4500 - 1300;
		timeVilaoOneDown 		= 4500 - 1300;
		timeVilaoTwoUp 			= 4000 - 1300;
		timeVilaoTwoDown 		= 3500 - 1300;
		timeAnimalOneUp 		= 4000 - 1300;
		timeAnimalOneDown 		= 4500 - 1300;
	end

	if controlePonto > 1300 and controlePonto < 1400 then
		timeVilaoOneUp 			= 4500 - 1400;
		timeVilaoOneDown 		= 4500 - 1400;
		timeVilaoTwoUp 			= 4000 - 1400;
		timeVilaoTwoDown 		= 3500 - 1400;
		timeAnimalOneUp 		= 4000 - 1400;
		timeAnimalOneDown 		= 4500 - 1400;
	end

	if controlePonto > 1400 and controlePonto < 1500 then
		timeVilaoOneUp 			= 4500 - 1500;
		timeVilaoOneDown 		= 4500 - 1500;
		timeVilaoTwoUp 			= 4000 - 1500;
		timeVilaoTwoDown 		= 3500 - 1500;
		timeAnimalOneUp 		= 4000 - 1500;
		timeAnimalOneDown 		= 4500 - 1500;
	end

	if controlePonto > 1500 and controlePonto < 1600 then
		timeVilaoOneUp 			= 4500 - 1600;
		timeVilaoOneDown 		= 4500 - 1600;
		timeVilaoTwoUp 			= 4000 - 1600;
		timeVilaoTwoDown 		= 3500 - 1600;
		timeAnimalOneUp 		= 4000 - 1600;
		timeAnimalOneDown 		= 4500 - 1600;
	end

	if controlePonto > 1600 and controlePonto < 1700 then
		timeVilaoOneUp 			= 4500 - 1700;
		timeVilaoOneDown 		= 4500 - 1700;
		timeVilaoTwoUp 			= 4000 - 1700;
		timeVilaoTwoDown 		= 3500 - 1700;
		timeAnimalOneUp 		= 4000 - 1700;
		timeAnimalOneDown 		= 4500 - 1700;
	end

	if controlePonto > 1200 and controlePonto < 1300 then
		timeVilaoOneUp 			= 4500 - 1300;
		timeVilaoOneDown 		= 4500 - 1300;
		timeVilaoTwoUp 			= 4000 - 1300;
		timeVilaoTwoDown 		= 3500 - 1300;
		timeAnimalOneUp 		= 4000 - 1300;
		timeAnimalOneDown 		= 4500 - 1300;
	end

	if controlePonto > 1300 and controlePonto < 1400 then
		timeVilaoOneUp 			= 4500 - 1400;
		timeVilaoOneDown 		= 4500 - 1400;
		timeVilaoTwoUp 			= 4000 - 1400;
		timeVilaoTwoDown 		= 3500 - 1400;
		timeAnimalOneUp 		= 4000 - 1400;
		timeAnimalOneDown 		= 4500 - 1400;
	end

end
-----------------------------------------
-----------------------------------------


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

local imgHunterOne = display.newImage( "img_person_vilao.png" )
imgHunterOne.y = 600

local imgHunterTwo = display.newImage( "img_person_vilao_2.png" )
imgHunterTwo.y = 600

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

function vilaoOneUp()
	imgHunterOne.alpha = 1;
	imgHunterOne.x = math.random (20, 215)
	transition.to(imgHunterOne, {time = timeVilaoOneUp, x = imgHunterOne.x, y = 220, onComplete = vilaoOneDown})
end

function vilaoOneDown()
	transition.to(imgHunterOne, {time = timeVilaoOneDown, x = imgHunterOne.x, y = 600, onComplete = vilaoOneUp})
end

function vilaoTwoUp()
	imgHunterTwo.alpha = 1;
	imgHunterTwo.x = math.random (270, 450)
	transition.to(imgHunterTwo, {time = timeVilaoTwoUp, x = imgHunterTwo.x, y = 220, onComplete = vilaoTwoDown})
end

function vilaoTwoDown()
	transition.to(imgHunterTwo, {time = timeVilaoTwoDown, x = imgHunterTwo.x, y = 600, onComplete = vilaoTwoUp})
end

function imgHunterOne:tap(event)
	audio.play(hit)
	imgHunterOne.alpha = 0;
	scoreCount.text = tostring(tonumber(scoreCount.text ) + 10 )
	controlePonto = (controlePonto) + (tonumber(scoreCount.text))
	controleVelocidade()
end

function imgHunterTwo:tap(event)
	audio.play(hit)
	imgHunterTwo.alpha = 0;
	scoreCount.text = tostring(tonumber(scoreCount.text ) + 10 )
	controlePonto = (controlePonto) + (tonumber(scoreCount.text))
	controleVelocidade()	
end

------------------------------------------------------------------------------------------------------------
-- TRANSIÇÃO [ANIMAIS]
------------------------------------------------------------------------------------------------------------

function animalOneUp()
	imgAnimalOne.alpha = 1;
	imgAnimalOne.x = math.random (20, 450)
	transition.to(imgAnimalOne, {time = timeAnimalOneUp, x = imgAnimalOne.x, y = 220, onComplete = animalOneDown})
end

function animalOneDown()
	transition.to(imgAnimalOne, {time = timeAnimalOneDown, x = imgAnimalOne.x, y = 600, onComplete = animalOneUp})
end

function imgAnimalOne:tap(event)
	audio.play(hit)
	imgAnimalOne.alpha = 0;
	controleVelocidade()
end

------------------------------------------------------------------------------------------------------------
-- MAIN
------------------------------------------------------------------------------------------------------------

vilaoOneUp()
vilaoTwoUp()
animalOneUp()
imgHunterOne:addEventListener("tap", imgHunterOne)
imgHunterTwo:addEventListener("tap", imgHunterTwo)
imgAnimalOne:addEventListener("tap", imgAnimalOne)