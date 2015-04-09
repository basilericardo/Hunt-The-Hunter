-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO JOGO E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.

-------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL ->
--
-- Contém a chamada do Storyboard, exclusão da barra de status, arquivos de áudio e variaveis que são
-- utilizadas ao longo do código.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD

		local storyboard = require("storyboard");
		local scene = storyboard.newScene();

	-- ARQUIVOS DE ÁUDIO

		local hit = audio.loadSound('Multimidia/Game/song_hit_all.mp3');

		local hitCat = audio.loadSound('Multimidia/Game/song_hit_cat.mp3');

		local ambianceSound = audio.loadStream('Multimidia/Game/song_game.mp3');
		ambianceSoundChannel = audio.play(ambianceSound, {channel = 4, loops = -1});
		
	-- CONFIGURAÇÕES DA TELA

		LAR = display.contentWidth; 	-- ALTURA
		ALT = display.contentHeight;	-- LARGURA

	-- VARIÁVEIS DE CONTROLE DE JOGABILIDADE

		local int controlePonto = 0; 	-- CONTROLE DE PONTUAÇÃO PARA UTILIZAÇÃO NA FUNÇÃO "controleVelocidade()"
		local int controleLife = 5; 	-- CONTROLE DE VIDA

-------------------------------------------------------------------------------------------------------------------------------
-- BACKGROUND ->
--
-- Composto de 5 camadas, na qual a ordem é: 
-- (1. Céu), (2. Nuvem), (3.Terra/Árvores), (4. Personagens), (5. Arbustos).
-------------------------------------------------------------------------------------------------------------------------------



	-- CÉU (1/5)

		local imgBgCeu = display.newImageRect("Multimidia/Game/img_bg_ceu.png", LAR, ALT);
			imgBgCeu.x = LAR/2;
			imgBgCeu.y = ALT/2;

	-- NUVENS (2/5)

		rolagem = 0.4; -- Velocidade da rolagem

		local imgBgNuvem = display.newImageRect("Multimidia/Game/img_bg_nuvem.png", LAR, ALT);
			imgBgNuvem.x = LAR/2;
			imgBgNuvem.y = ALT/2;

		local imgBgNuvem2 = display.newImageRect("Multimidia/Game/img_bg_nuvem.png", LAR, ALT);
			imgBgNuvem2.x = (imgBgNuvem.x + (LAR - 0.2));
			imgBgNuvem2.y = ALT/2;

		local imgBgNuvem3 = display.newImageRect("Multimidia/Game/img_bg_nuvem.png", LAR, ALT);
			imgBgNuvem3.x = (imgBgNuvem2.x + (LAR - 0.3));
			imgBgNuvem3.y = ALT/2;

		local function imgBgNuvemRolagem(event)
			imgBgNuvem.x = (imgBgNuvem.x - rolagem);
			imgBgNuvem2.x = (imgBgNuvem2.x - rolagem);
			imgBgNuvem3.x = (imgBgNuvem3.x - rolagem);	

			if (imgBgNuvem.x + imgBgNuvem.contentWidth) < 0 then
				imgBgNuvem:translate(LAR * 3, 0);
			end
			if (imgBgNuvem2.x + imgBgNuvem2.contentWidth) < 0 then
				imgBgNuvem2:translate(LAR * 3, 0);
			end
			if (imgBgNuvem3.x + imgBgNuvem3.contentWidth) < 0 then
				imgBgNuvem3:translate(LAR * 3, 0);
			end		
		end

		Runtime:addEventListener("enterFrame", imgBgNuvemRolagem)		

	-- TERRA, ÁRVORES (3/5)

		local imgBgTerra = display.newImageRect("Multimidia/Game/img_bg_terra.png", LAR, ALT);
			imgBgTerra.x = LAR/2;
			imgBgTerra.y = ALT/2;

	-- PERSONAGENS (4/5)

		local imgHunterOne = display.newImage("Multimidia/Game/img_person_vilao.png");
			imgHunterOne.y = 600;

		local imgHunterTwo = display.newImage("Multimidia/Game/img_person_vilao_2.png");
			imgHunterTwo.y = 600;

		local imgHunterLider = display.newImage("Multimidia/Game/img_person_vilao_lider.png");
			imgHunterLider.y = 600;

		local imgAnimalOne = display.newImage("Multimidia/Game/img_animal_one.png");
			imgAnimalOne.y = 600;

		local imgAnimalTwo = display.newImage("Multimidia/Game/img_animal_two.png");
			imgAnimalTwo.y = 600;

	-- ARBUSTO (5/5)

		local bgArbusto = display.newImageRect("Multimidia/Game/img_bg_arbustos.png", LAR, (ALT * 0.70));
			bgArbusto.x = LAR/2;
			bgArbusto.y = ALT;

	-- PONTUAÇÃO

		local scoreName = display.newText('Score:', 20, 10, native.systemFont, 12);
		local scoreCount = display.newText('0', 55, 10, native.systemFont, 12);

-------------------------------------------------------------------------------------------------------------------------------
-- TRANSIÇÃO DE OBJETOS (VILÕES E ANIMAIS) E CONTROLE DE JOGABILIDADE ->
--
-- xxxUP() 				- Habilita a visualização do objeto, randomiza a posição X, utiliza o valor de tempo
--							da transição definido de acordo com o score atual, quando percorrido o Y, chama "xxxDOWN()";
--
-- xxxDOWN()			- Utiliza o valor de tempo da transição definido de acordo com o score atual e desce
--							o objeto até o final da tela, quando percorrido o Y, chama "xxxUP()";
--
-- vilão:TAP(event)		- Desabilita a visualização do objeto, soma a pontuação atual dependendo do tipo de 
--							personagem, atualiza a variável "controlePonto" com a pontuação atual e chama a função
--							"controleVelocidade()" para verificar a pontuação e alterar as variáveis de tempo de transição;
--
-- animal:TAP(event)	- Desabilita a visualização do objeto e diminui uma vida;
--
-- controleVelocidade()	- Verifica a pontuação atual e atualiza as variáveis de tempo de transição.
-------------------------------------------------------------------------------------------------------------------------------

	-- VILÕES

		function vilaoOneUp()
			imgHunterOne.alpha = 1;

			imgHunterOne.x = math.random(20, 215);

			transition.to(imgHunterOne, {time = timeVilaoOneUp, x = imgHunterOne.x, y = 220, onComplete = vilaoOneDown});
		end

		function vilaoOneDown()
			transition.to(imgHunterOne, {time = timeVilaoOneDown, x = imgHunterOne.x, y = 600, onComplete = vilaoOneUp});
		end

		function vilaoTwoUp()
			imgHunterTwo.alpha = 1;

			imgHunterTwo.x = math.random(270, 450);

			transition.to(imgHunterTwo, {time = timeVilaoTwoUp, x = imgHunterTwo.x, y = 220, onComplete = vilaoTwoDown});
		end

		function vilaoTwoDown()
			transition.to(imgHunterTwo, {time = timeVilaoTwoDown, x = imgHunterTwo.x, y = 600, onComplete = vilaoTwoUp});
		end

		function vilaoLiderUp()
			imgHunterLider.alpha = 1;

			imgHunterLider.x = math.random(20, 450);

			transition.to(imgHunterLider, {time = timeVilaoLiderUp, x = imgHunterLider.x, y = 220, onComplete = vilaoLiderDown});
		end

		function vilaoLiderDown()
			transition.to(imgHunterLider, {time = timeVilaoLiderDown, x = imgHunterLider.x, y = 600, onComplete = vilaoLiderUp});
		end

		function imgHunterOne:tap(event)
			audio.play(hit);

			imgHunterOne.alpha = 0;

			scoreCount.text = tostring(tonumber(scoreCount.text) + 50);
			controlePonto = tonumber(scoreCount.text);

			controleVelocidade();
		end

		function imgHunterTwo:tap(event)
			audio.play(hit);

			imgHunterTwo.alpha = 0;

			scoreCount.text = tostring(tonumber(scoreCount.text) + 50);
			controlePonto = tonumber(scoreCount.text);

			controleVelocidade();
		end

		function imgHunterLider:tap(event)
			audio.play(hit);

			imgHunterLider.alpha = 0;

			scoreCount.text = tostring(tonumber(scoreCount.text) + 100);
			controlePonto = tonumber(scoreCount.text);

			controleVelocidade();
		end

	-- ANIMAIS

		function animalOneUp()
			imgAnimalOne.alpha = 1;

			imgAnimalOne.x = math.random (20, 450);

			transition.to(imgAnimalOne, {time = timeAnimalOneUp, x = imgAnimalOne.x, y = 220, onComplete = animalOneDown});
		end

		function animalOneDown()
			transition.to(imgAnimalOne, {time = timeAnimalOneDown, x = imgAnimalOne.x, y = 600, onComplete = animalOneUp});
		end

		function imgAnimalOne:tap(event)
			audio.play(hit);
			audio.play(hitCat);

			imgAnimalOne.alpha = 0;

			controleLife = (controleLife - 1);

			if controleLife == 0 then
				print("GAME OVER!");
			end
			
		end

		function animalTwoUp()
			imgAnimalTwo.alpha = 1;

			imgAnimalTwo.x = math.random(20, 450);

			transition.to(imgAnimalTwo, {time = timeAnimalTwoUp, x = imgAnimalTwo.x, y = 220, onComplete = animalTwoDown});
		end

		function animalTwoDown()
			transition.to(imgAnimalTwo, {time = timeAnimalTwoDown, x = imgAnimalTwo.x, y = 600, onComplete = animalTwoUp});
		end

		function imgAnimalTwo:tap(event)
			audio.play(hit);
			audio.play(hitCat);

			imgAnimalTwo.alpha = 0;

			controleLife = (controleLife - 1);

			if controleLife == 0 then
				print ("GAME OVER!");
			end
			
		end

	-- CONTROLE DA VELOCIDADE DE TRANSIÇÃO

		local int timeVilaoOneUp = 4500;
		local int timeVilaoOneDown = 4500;
		local int timeVilaoTwoUp = 4000;
		local int timeVilaoTwoDown = 3500;
		local int timeVilaoLiderUp = 1000;
		local int timeVilaoLiderDown = 1500;
		local int timeAnimalOneUp = 3500;
		local int timeAnimalOneDown = 4500;
		local int timeAnimalTwoUp = 1800;
		local int timeAnimalTwoDown = 2500;

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
				timeVilaoOneUp 			= 4500 - 500;
				timeVilaoOneDown 		= 4500 - 500;
				timeVilaoTwoUp 			= 4000 - 500;
				timeVilaoTwoDown 		= 3500 - 500;
				timeAnimalOneUp 		= 4000 - 500;
				timeAnimalOneDown 		= 4500 - 500;
			end

			if controlePonto > 100 and controlePonto < 200 then
				timeVilaoOneUp 			= 4500 - 600;
				timeVilaoOneDown 		= 4500 - 600;
				timeVilaoTwoUp 			= 4000 - 600;
				timeVilaoTwoDown 		= 3500 - 600;
				timeAnimalOneUp 		= 4000 - 600;
				timeAnimalOneDown 		= 4500 - 600;
			end

			if controlePonto > 200 and controlePonto < 300 then
				timeVilaoOneUp 			= 4500 - 700;
				timeVilaoOneDown 		= 4500 - 700;
				timeVilaoTwoUp 			= 4000 - 700;
				timeVilaoTwoDown 		= 3500 - 700;
				timeAnimalOneUp 		= 4000 - 700;
				timeAnimalOneDown 		= 4500 - 700;
			end

			if controlePonto > 300 and controlePonto < 400 then
				timeVilaoOneUp 			= 4500 - 800;
				timeVilaoOneDown 		= 4500 - 800;
				timeVilaoTwoUp 			= 4000 - 800;
				timeVilaoTwoDown 		= 3500 - 800;
				timeAnimalOneUp 		= 4000 - 800;
				timeAnimalOneDown 		= 4500 - 800;
			end

			if controlePonto > 400 and controlePonto < 500 then
				timeVilaoOneUp 			= 4500 - 900;
				timeVilaoOneDown 		= 4500 - 900;
				timeVilaoTwoUp 			= 4000 - 900;
				timeVilaoTwoDown 		= 3500 - 900;
				timeAnimalOneUp 		= 4000 - 900;
				timeAnimalOneDown 		= 4500 - 900;
			end

			if controlePonto > 500 and controlePonto < 600 then
				timeVilaoOneUp 			= 4500 - 1000;
				timeVilaoOneDown 		= 4500 - 1000;
				timeVilaoTwoUp 			= 4000 - 1000;
				timeVilaoTwoDown 		= 3500 - 1000;
				timeAnimalOneUp 		= 4000 - 1000;
				timeAnimalOneDown 		= 4500 - 1000;
			end

			if controlePonto > 600 and controlePonto < 700 then
				timeVilaoOneUp 			= 4500 - 1100;
				timeVilaoOneDown 		= 4500 - 1100;
				timeVilaoTwoUp 			= 4000 - 1100;
				timeVilaoTwoDown 		= 3500 - 1100;
				timeAnimalOneUp 		= 4000 - 1100;
				timeAnimalOneDown 		= 4500 - 1100;

				if controlePonto == 650 then
					animalTwoUp();
					imgAnimalTwo:addEventListener("tap", imgAnimalTwo);
				end
			end

			if controlePonto > 700 and controlePonto < 800 then
				timeVilaoOneUp 			= 4500 - 1200;
				timeVilaoOneDown 		= 4500 - 1200;
				timeVilaoTwoUp 			= 4000 - 1200;
				timeVilaoTwoDown 		= 3500 - 1200;
				timeAnimalOneUp 		= 4000 - 1200;
				timeAnimalOneDown 		= 4500 - 1200;
			end

			if controlePonto > 800 and controlePonto < 900 then
				timeVilaoOneUp 			= 4500 - 1300;
				timeVilaoOneDown 		= 4500 - 1300;
				timeVilaoTwoUp 			= 4000 - 1300;
				timeVilaoTwoDown 		= 3500 - 1300;
				timeAnimalOneUp 		= 4000 - 1300;
				timeAnimalOneDown 		= 4500 - 1300;

				if controlePonto == 850 then
					vilaoLiderUp();
					imgHunterLider:addEventListener("tap", imgHunterLider);
				end
			end

			if controlePonto > 900 and controlePonto < 1100 then
				timeVilaoOneUp 			= 4500 - 1300;
				timeVilaoOneDown 		= 4500 - 1300;
				timeVilaoTwoUp 			= 4000 - 1300;
				timeVilaoTwoDown 		= 3500 - 1300;
				timeAnimalOneUp 		= 4000 - 1300;
				timeAnimalOneDown 		= 4500 - 1300;
			end

			if controlePonto > 1100 and controlePonto < 1300 then
				timeVilaoOneUp 			= 4500 - 1400;
				timeVilaoOneDown 		= 4500 - 1400;
				timeVilaoTwoUp 			= 4000 - 1400;
				timeVilaoTwoDown 		= 3500 - 1400;
				timeAnimalOneUp 		= 4000 - 1400;
				timeAnimalOneDown 		= 4500 - 1400;
			end

			if controlePonto > 1300 and controlePonto < 1500 then
				timeVilaoOneUp 			= 4500 - 1500;
				timeVilaoOneDown 		= 4500 - 1500;
				timeVilaoTwoUp 			= 4000 - 1500;
				timeVilaoTwoDown 		= 3500 - 1500;
				timeAnimalOneUp 		= 4000 - 1500;
				timeAnimalOneDown 		= 4500 - 1500;
			end

			if controlePonto > 1500 and controlePonto < 1700 then
				timeVilaoOneUp 			= 4500 - 1600;
				timeVilaoOneDown 		= 4500 - 1600;
				timeVilaoTwoUp 			= 4000 - 1600;
				timeVilaoTwoDown 		= 3500 - 1600;
				timeAnimalOneUp 		= 4000 - 1600;
				timeAnimalOneDown 		= 4500 - 1600;
			end

			if controlePonto > 1700 and controlePonto < 1900 then
				timeVilaoOneUp 			= 4500 - 1700;
				timeVilaoOneDown 		= 4500 - 1700;
				timeVilaoTwoUp 			= 4000 - 1700;
				timeVilaoTwoDown 		= 3500 - 1700;
				timeAnimalOneUp 		= 4000 - 1700;
				timeAnimalOneDown 		= 4500 - 1700;
			end

			if controlePonto > 1900 and controlePonto < 2100 then
				timeVilaoOneUp 			= 4500 - 1800;
				timeVilaoOneDown 		= 4500 - 1800;
				timeVilaoTwoUp 			= 4000 - 1800;
				timeVilaoTwoDown 		= 3500 - 1800;
				timeAnimalOneUp 		= 4000 - 1800;
				timeAnimalOneDown 		= 4500 - 1800;
			end

			if controlePonto > 2100 and controlePonto < 2300 then
				timeVilaoOneUp 			= 4500 - 1900;
				timeVilaoOneDown 		= 4500 - 1900;
				timeVilaoTwoUp 			= 4000 - 1900;
				timeVilaoTwoDown 		= 3500 - 1900;
				timeAnimalOneUp 		= 4000 - 1900;
				timeAnimalOneDown 		= 4500 - 1900;
			end

			if controlePonto > 2300 and controlePonto < 2500 then
				timeVilaoOneUp 			= 4500 - 2000;
				timeVilaoOneDown 		= 4500 - 2000;
				timeVilaoTwoUp 			= 4000 - 2000;
				timeVilaoTwoDown 		= 3500 - 2000;
				timeAnimalOneUp 		= 4000 - 2000;
				timeAnimalOneDown 		= 4500 - 2000;
			end

			if controlePonto > 2500 and controlePonto < 2700 then
				timeVilaoOneUp 			= 4500 - 2100;
				timeVilaoOneDown 		= 4500 - 2100;
				timeVilaoTwoUp 			= 4000 - 2100;
				timeVilaoTwoDown 		= 3500 - 2100;
				timeAnimalOneUp 		= 4000 - 2100;
				timeAnimalOneDown 		= 4500 - 2100;
			end

			if controlePonto > 2700 then
				timeVilaoOneUp 			= 4500 - 2300;
				timeVilaoOneDown 		= 4500 - 2300;
				timeVilaoTwoUp 			= 4000 - 2300;
				timeVilaoTwoDown 		= 3500 - 2300;
				timeAnimalOneUp 		= 4000 - 2300;
				timeAnimalOneDown 		= 4500 - 2300;
			end

		end

-------------------------------------------------------------------------------------------------------------------------------
-- MAIN ->
--
-- Chama as funções responsáveis pelo funcionamento do jogo.
-------------------------------------------------------------------------------------------------------------------------------
	
	-- PERSONAGENS
		vilaoOneUp();
		vilaoTwoUp();
		animalOneUp();
	
	-- ATIVA EVENTOS
		imgHunterOne:addEventListener("tap", imgHunterOne);
		imgHunterTwo:addEventListener("tap", imgHunterTwo);
		imgAnimalOne:addEventListener("tap", imgAnimalOne);

	return scene;