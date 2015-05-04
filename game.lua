-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO JOGO.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD:

		local storyboard = require("storyboard");
		local scene = storyboard.newScene();

	-- ARQUIVOS DE ÁUDIO:

		local hit = audio.loadSound('Multimidia/Game/song_hit_all.mp3');

		local hitCat = audio.loadSound('Multimidia/Game/song_hit_cat.mp3');

		local ambianceSound = audio.loadStream('Multimidia/Game/song_game.wav');
		
	-- CONFIGURAÇÕES DA TELA:

		LAR = display.contentWidth; 	-- ALTURA
		ALT = display.contentHeight;	-- LARGURA

	-- VARIÁVEIS:

		-- CONTROLE DE JOGABILIDADE:

			local controlePonto = 0; 	-- CONTROLE DE PONTUAÇÃO PARA UTILIZAÇÃO NA FUNÇÃO "controleVelocidade()"
			local controleLife = 3; 	-- CONTROLE DE VIDA

		-- PONTOS OBTIDOS:
			scoreFinal = 0;

		-- CAÇADORES PRESOS:
			hunterHunted = 0;

		-- CAÇADORES PERDIDOS:
			hunterLost = 0;

		-- CAÇADORES LIDER PRESOS:
			masterHunterHunted = 0;

		-- IDENTIFICADOR DE EXISTÊNCIA DO TERCEIRO CAÇADOR
			local hunterThreeExist = 0;

		-- IDENTIFICADOR DE EXISTÊNCIA DO LÍDER:
			local liderExists = 0;

		-- IDENTIFICADOR DE EXISTÊNCIA DO SEGUNDO ANIMAL:
			local animalTwoExist = 0;

		-- IDENTIFICADOR SE O SOM FOI PARADO PELO USUÁRIO:
			local soundPaused = 0;

	-- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:
		function scene:createScene(event)
			local group = self.view;

			-------------------------------------------------------------------------------------------------------------------------------
			-- BACKGROUND ->
			--
			-- Composto de 5 camadas, na qual a ordem é: 
			-- (1. Céu), (2. Nuvem), (3. Terra/Árvores), (4. Barra de Status), (5. personagens), (6. Arbustos).
			-------------------------------------------------------------------------------------------------------------------------------

				-- CÉU (1/6):

					local imgBgCeu = display.newImageRect("Multimidia/Game/img_bg_ceu.png", LAR, ALT);
						imgBgCeu.x = (LAR/2);
						imgBgCeu.y = (ALT/2);

					group:insert(imgBgCeu);

				-- NUVENS (2/6):

					local rolagem = 0.4; -- Velocidade da rolagem

					local imgBgNuvem = display.newImageRect("Multimidia/Game/img_bg_nuvem.png", LAR, ALT);
						imgBgNuvem.x = (LAR/2);
						imgBgNuvem.y = (ALT/2);

					group:insert(imgBgNuvem);

					local imgBgNuvem2 = display.newImageRect("Multimidia/Game/img_bg_nuvem.png", LAR, ALT);
						imgBgNuvem2.x = (imgBgNuvem.x + (LAR - 0.2));
						imgBgNuvem2.y = (ALT/2);

					group:insert(imgBgNuvem2);

					local imgBgNuvem3 = display.newImageRect("Multimidia/Game/img_bg_nuvem.png", LAR, ALT);
						imgBgNuvem3.x = (imgBgNuvem2.x + (LAR - 0.3));
						imgBgNuvem3.y = (ALT/2);

					group:insert(imgBgNuvem3);

					local function imgBgNuvemRolagem(event)
						imgBgNuvem.x = (imgBgNuvem.x - rolagem);
						imgBgNuvem2.x = (imgBgNuvem2.x - rolagem);
						imgBgNuvem3.x = (imgBgNuvem3.x - rolagem);	

						if (imgBgNuvem.x + imgBgNuvem.contentWidth) < 0 then
							imgBgNuvem:translate((LAR * 3), 0);
						end
						if (imgBgNuvem2.x + imgBgNuvem2.contentWidth) < 0 then
							imgBgNuvem2:translate((LAR * 3), 0);
						end
						if (imgBgNuvem3.x + imgBgNuvem3.contentWidth) < 0 then
							imgBgNuvem3:translate((LAR * 3), 0);
						end		
					end

					Runtime:addEventListener("enterFrame", imgBgNuvemRolagem);	

				-- TERRA, ÁRVORES (3/6):

					local imgBgTerra = display.newImageRect("Multimidia/Game/img_bg_terra.png", LAR, ALT);
						imgBgTerra.x = (LAR/2);
						imgBgTerra.y = (ALT/2);

					group:insert(imgBgTerra);

				-- PERSONAGENS (5/6):

					local imgHunterOne = display.newImage("Multimidia/Game/img_person_vilao.png");
						imgHunterOne.y = 600;

					group:insert(imgHunterOne);

					local imgHunterTwo = display.newImage("Multimidia/Game/img_person_vilao_2.png");
						imgHunterTwo.y = 600;

					group:insert(imgHunterTwo);

					local imgHunterThree = display.newImage("Multimidia/Game/img_person_vilao_3.png");
						imgHunterThree.y = 600;

					group:insert(imgHunterThree);

					local imgHunterLider = display.newImage("Multimidia/Game/img_person_vilao_lider.png");
						imgHunterLider.y = 600;

					group:insert(imgHunterLider);

					local imgAnimalOne = display.newImage("Multimidia/Game/img_animal_one.png");
						imgAnimalOne.y = 600;

					group:insert(imgAnimalOne);

					local imgAnimalTwo = display.newImage("Multimidia/Game/img_animal_two.png");
						imgAnimalTwo.y = 600;

					group:insert(imgAnimalTwo);

				-- ARBUSTO (6/6):

					local bgArbusto = display.newImageRect("Multimidia/Game/img_bg_arbustos.png", LAR, (ALT * 0.70));
						bgArbusto.x = (LAR/2);
						bgArbusto.y = (ALT);

					group:insert(bgArbusto);

				-- PONTUAÇÃO:

					local scoreCount = display.newText('0', 468, 20, "Paljain jaloin", 20);
										
					group:insert(scoreCount);

				-- VISOR DE VELOCIDADE DOS PERSONAGENS:

					local velocidadeZero = display.newImage("Multimidia/Game/img_velocidade_0.png", 70, 20);
						velocidadeZero.xScale = 0.7;
						velocidadeZero.yScale = 0.7;
						velocidadeZero.alpha =1;

					group:insert(velocidadeZero);

					local velocidadeUm = display.newImage("Multimidia/Game/img_velocidade_1.png", 70, 20);
						velocidadeUm.xScale = 0.7;
						velocidadeUm.yScale = 0.7;
						velocidadeUm.alpha =0;

					group:insert(velocidadeUm);

					local velocidadeDois = display.newImage("Multimidia/Game/img_velocidade_2.png", 70, 20);
						velocidadeDois.xScale = 0.7;
						velocidadeDois.yScale = 0.7;
						velocidadeDois.alpha =0;

					group:insert(velocidadeDois);

					local velocidadeTres = display.newImage("Multimidia/Game/img_velocidade_3.png", 70, 20);
						velocidadeTres.xScale = 0.7;
						velocidadeTres.yScale = 0.7;
						velocidadeTres.alpha =0;

					group:insert(velocidadeTres);

					local velocidadeQuatro = display.newImage("Multimidia/Game/img_velocidade_4.png", 70, 20);
						velocidadeQuatro.xScale = 0.7;
						velocidadeQuatro.yScale = 0.7;
						velocidadeQuatro.alpha =0;

					group:insert(velocidadeQuatro);

					local velocidadeCinco = display.newImage("Multimidia/Game/img_velocidade_5.png", 70, 20);
						velocidadeCinco.xScale = 0.7;
						velocidadeCinco.yScale = 0.7;
						velocidadeCinco.alpha =0;

					group:insert(velocidadeCinco);

					local velocidadeSeis = display.newImage("Multimidia/Game/img_velocidade_6.png", 70, 20);
						velocidadeSeis.xScale = 0.7;
						velocidadeSeis.yScale = 0.7;
						velocidadeSeis.alpha =0;

					group:insert(velocidadeSeis);

					local velocidadeSete = display.newImage("Multimidia/Game/img_velocidade_7.png", 70, 20);
						velocidadeSete.xScale = 0.7;
						velocidadeSete.yScale = 0.7;
						velocidadeSete.alpha =0;

					group:insert(velocidadeSete);

					local velocidadeOito = display.newImage("Multimidia/Game/img_velocidade_8.png", 70, 20);
						velocidadeOito.xScale = 0.7;
						velocidadeOito.yScale = 0.7;
						velocidadeOito.alpha =0;

					group:insert(velocidadeOito);

					local velocidadeNove = display.newImage("Multimidia/Game/img_velocidade_9.png", 70, 20);
						velocidadeNove.xScale = 0.7;
						velocidadeNove.yScale = 0.7;
						velocidadeNove.alpha =0;

					group:insert(velocidadeNove);

					local velocidadeDez = display.newImage("Multimidia/Game/img_velocidade_10.png", 70, 20);
						velocidadeDez.xScale = 0.7;
						velocidadeDez.yScale = 0.7;
						velocidadeDez.alpha =0;

					group:insert(velocidadeDez);

					local velocidadeOnze = display.newImage("Multimidia/Game/img_velocidade_11.png", 70, 20);
						velocidadeOnze.xScale = 0.7;
						velocidadeOnze.yScale = 0.7;
						velocidadeOnze.alpha =0;

					group:insert(velocidadeOnze);

					local velocidadeDoze = display.newImage("Multimidia/Game/img_velocidade_12.png", 70, 20);
						velocidadeDoze.xScale = 0.7;
						velocidadeDoze.yScale = 0.7;
						velocidadeDoze.alpha =0;

					group:insert(velocidadeDoze);

					local velocidadeTreze = display.newImage("Multimidia/Game/img_velocidade_13.png", 70, 20);
						velocidadeTreze.xScale = 0.7;
						velocidadeTreze.yScale = 0.7;
						velocidadeTreze.alpha =0;

					group:insert(velocidadeTreze);

					local velocidadeCatorze = display.newImage("Multimidia/Game/img_velocidade_14.png", 70, 20);
						velocidadeCatorze.xScale = 0.7;
						velocidadeCatorze.yScale = 0.7;
						velocidadeCatorze.alpha =0;

					group:insert(velocidadeCatorze);

					local velocidadeQuinze = display.newImage("Multimidia/Game/img_velocidade_15.png", 70, 20);
						velocidadeQuinze.xScale = 0.7;
						velocidadeQuinze.yScale = 0.7;
						velocidadeQuinze.alpha =0;

					group:insert(velocidadeQuinze);

					local velocidadeDezesseis = display.newImage("Multimidia/Game/img_velocidade_16.png", 70, 20);
						velocidadeDezesseis.xScale = 0.7;
						velocidadeDezesseis.yScale = 0.7;
						velocidadeDezesseis.alpha =0;

					group:insert(velocidadeDezesseis);

					local velocidadeDezessete = display.newImage("Multimidia/Game/img_velocidade_17.png", 70, 20);
						velocidadeDezessete.xScale = 0.7;
						velocidadeDezessete.yScale = 0.7;
						velocidadeDezessete.alpha =0;

					group:insert(velocidadeDezessete);

					local velocidadeDezoito = display.newImage("Multimidia/Game/img_velocidade_18.png", 70, 20);
						velocidadeDezoito.xScale = 0.7;
						velocidadeDezoito.yScale = 0.7;
						velocidadeDezoito.alpha =0;

					group:insert(velocidadeDezoito);

					local velocidadeDezenove = display.newImage("Multimidia/Game/img_velocidade_19.png", 70, 20);
						velocidadeDezenove.xScale = 0.7;
						velocidadeDezenove.yScale = 0.7;
						velocidadeDezenove.alpha =0;

					group:insert(velocidadeDezenove);

					local velocidadeVinte = display.newImage("Multimidia/Game/img_velocidade_20.png", 70, 20);
						velocidadeVinte.xScale = 0.7;
						velocidadeVinte.yScale = 0.7;
						velocidadeVinte.alpha =0;

					group:insert(velocidadeVinte);

					local velocidadeVinteUm = display.newImage("Multimidia/Game/img_velocidade_21.png", 70, 20);
						velocidadeVinteUm.xScale = 0.7;
						velocidadeVinteUm.yScale = 0.7;
						velocidadeVinteUm.alpha =0;

					group:insert(velocidadeVinteUm);

					local velocidadeVinteDois = display.newImage("Multimidia/Game/img_velocidade_22.png", 70, 20);
						velocidadeVinteDois.xScale = 0.7;
						velocidadeVinteDois.yScale = 0.7;
						velocidadeVinteDois.alpha =0;

					group:insert(velocidadeVinteDois);

				-- PONTOS DE VIDA:					
					
					local lifeOne = display.newImage("Multimidia/Game/img_life_1.png", 101, 36);
						lifeOne.xScale = 0.3;
						lifeOne.yScale = 0.3;

					group:insert(lifeOne);

					local lifeTwo = display.newImage("Multimidia/Game/img_life_2.png", 101, 36);
						lifeTwo.xScale = 0.3;
						lifeTwo.yScale = 0.3;

					group:insert(lifeTwo);

					local lifeThree = display.newImage("Multimidia/Game/img_life_3.png", 101, 36);
						lifeThree.xScale = 0.3;
						lifeThree.yScale = 0.3;

					group:insert(lifeThree);

				-- BOTÃO DE MENU:

					local pauseButton = display.newImage("Multimidia/Game/img_pause_button.png", 468, 55);
						pauseButton.xScale = 0.1;
						pauseButton.yScale = 0.1;

					group:insert(pauseButton);

					local pauseButton2 = display.newImage("Multimidia/Game/img_pause_button2.png", 468, 55);
						pauseButton2.xScale = 0.1;
						pauseButton2.yScale = 0.1;

						pauseButton2.alpha = 0;

					group:insert(pauseButton2);

					local soundOnButton = display.newImage("Multimidia/Game/img_soundOn_button.png", 468, 80);
						soundOnButton.xScale = 0.1;
						soundOnButton.yScale = 0.1;

						soundOnButton.alpha = 0;

					group:insert(soundOnButton);

					local soundOffButton = display.newImage("Multimidia/Game/img_soundOff_button.png", 468, 80);
						soundOffButton.xScale = 0.1;
						soundOffButton.yScale = 0.1;

						soundOffButton.alpha = 1;

					group:insert(soundOffButton);

					local resumeButton = display.newImage("Multimidia/Game/img_resume_button.png");
						resumeButton.alpha = 0;
						resumeButton.x = (LAR/2);
						resumeButton.y = ((ALT/2) - 50);
						resumeButton.xScale = 0.5;
						resumeButton.yScale = 0.5;

					group:insert(resumeButton);

					local restartButton = display.newImage("Multimidia/Game/img_restart_button.png");
						restartButton.alpha = 0;
						restartButton.x = (LAR/2);
						restartButton.y = (ALT/2);
						restartButton.xScale = 0.5;
						restartButton.yScale = 0.5;

					group:insert(restartButton);

					local returnMenuButton = display.newImage("Multimidia/Game/img_returnMenu_button.png");
						returnMenuButton.alpha = 0;
						returnMenuButton.x = (LAR/2);
						returnMenuButton.y = ((ALT/2) + 50);
						returnMenuButton.xScale = 0.5;
						returnMenuButton.yScale = 0.5;

					group:insert(returnMenuButton);					

			-------------------------------------------------------------------------------------------------------------------------------
			-- FUNÇÕES:
			--
			-- TRANSIÇÃO DE OBJETOS (VILÕES E ANIMAIS) E CONTROLE DE JOGABILIDADE
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

				-- VILÕES:

					function vilaoOneUp()
						imgHunterOne.alpha = 1;

						imgHunterOne.x = math.random(20, 450);

						transition.to(imgHunterOne, {time = timeVilaoOneUp, x = imgHunterOne.x, y = 220, onComplete = vilaoOneDown});
					end

					function vilaoOneDown()
						hunterLost = (hunterLost + 1);

						transition.to(imgHunterOne, {time = timeVilaoOneDown, x = imgHunterOne.x, y = 600, onComplete = vilaoOneUp});
					end

					function vilaoTwoUp()
						imgHunterTwo.alpha = 1;

						imgHunterTwo.x = math.random(20, 450);

						transition.to(imgHunterTwo, {time = timeVilaoTwoUp, x = imgHunterTwo.x, y = 220, onComplete = vilaoTwoDown});
					end

					function vilaoTwoDown()
						hunterLost = (hunterLost + 1);

						transition.to(imgHunterTwo, {time = timeVilaoTwoDown, x = imgHunterTwo.x, y = 600, onComplete = vilaoTwoUp});
					end

					function vilaoThreeUp()
						imgHunterThree.alpha = 1;

						imgHunterThree.x = math.random(20, 450);

						transition.to(imgHunterThree, {time = timeVilaoTwoUp, x = imgHunterThree.x, y = 220, onComplete = vilaoThreeDown});
					end

					function vilaoThreeDown()
						hunterLost = (hunterLost + 1);

						transition.to(imgHunterThree, {time = timeVilaoTwoDown, x = imgHunterThree.x, y = 600, onComplete = vilaoThreeUp});
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

						scoreCount.text = tostring(tonumber(scoreCount.text) + 30);
						controlePonto = tonumber(scoreCount.text);
						scoreFinal = tonumber(scoreCount.text);
						hunterHunted = (hunterHunted + 1);

						if hunterLost > 0 then
							hunterLost = (hunterLost - 1);
						end

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO DEFAULT 468

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 468;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 465;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 462;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 459;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 456;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 452;
							end

							if controlePonto > 999999 then
								scoreCount.x = 650;
							end

						controleVelocidade();
					end

					function imgHunterTwo:tap(event)
						audio.play(hit);

						imgHunterTwo.alpha = 0;

						scoreCount.text = tostring(tonumber(scoreCount.text) + 30);
						controlePonto = tonumber(scoreCount.text);
						scoreFinal = tonumber(scoreCount.text);
						hunterHunted = (hunterHunted + 1);

						if hunterLost > 0 then
							hunterLost = (hunterLost - 1);
						end

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO DEFAULT 468

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 468;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 465;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 462;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 459;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 456;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 452;
							end

							if controlePonto > 999999 then
								scoreCount.x = 650;
							end

						controleVelocidade();
					end

					function imgHunterThree:tap(event)
						audio.play(hit);

						imgHunterThree.alpha = 0;

						scoreCount.text = tostring(tonumber(scoreCount.text) + 30);
						controlePonto = tonumber(scoreCount.text);
						scoreFinal = tonumber(scoreCount.text);
						hunterHunted = (hunterHunted + 1);

						if hunterLost > 0 then
							hunterLost = (hunterLost - 1);
						end

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO DEFAULT 468

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 468;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 465;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 462;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 459;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 456;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 452;
							end

							if controlePonto > 999999 then
								scoreCount.x = 650;
							end

						controleVelocidade();
					end

					function imgHunterLider:tap(event)
						audio.play(hit);

						imgHunterLider.alpha = 0;

						scoreCount.text = tostring(tonumber(scoreCount.text) + 55);
						controlePonto = tonumber(scoreCount.text);
						scoreFinal = tonumber(scoreCount.text);
						masterHunterHunted = (masterHunterHunted + 1);

						if hunterLost > 0 then
							hunterLost = (hunterLost - 1);
						end

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO DEFAULT 468

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 468;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 465;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 462;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 459;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 456;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 452;
							end

							if controlePonto > 999999 then
								scoreCount.x = 650;
							end

						controleVelocidade();
					end

				-- ANIMAIS:

					function animalOneUp()
						imgAnimalOne.alpha = 1;

						imgAnimalOne.x = math.random(20, 450);

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

						if controleLife == 2 then
							display.remove(lifeThree);
						end

						if controleLife == 1 then
							display.remove(lifeTwo);
						end

						if controleLife == 0 then
							audio.stop();

							imgHunterOne:removeEventListener("tap", imgHunterOne);
							imgHunterTwo:removeEventListener("tap", imgHunterTwo);
							imgHunterThree:removeEventListener("tap", imgHunterThree);
							imgHunterLider:removeEventListener("tap", imgHunterLider);
							imgAnimalOne:removeEventListener("tap", imgAnimalOne);
							imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
							if soundPaused == 1 then
								soundOnButton:removeEventListener("tap", resumeSound);
							end
							if soundPaused == 0 then
								soundOffButton:removeEventListener("tap", pauseSound);
							end
														
							transition.cancel(imgHunterOne);
							transition.cancel(imgHunterTwo);
							transition.cancel(imgAnimalOne);
							if hunterThreeExist == 1 then
								transition.cancel(imgHunterThree);
							end
							if liderExists == 1 then
								transition.cancel(imgHunterLider);
							end
							if animalTwoExist == 1 then
								transition.cancel(imgAnimalTwo);
							end

							Runtime:removeEventListener("enterFrame", imgBgNuvemRolagem);

							storyboard.gotoScene("gameover", transicaoCena);
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

						if controleLife == 2 then
							display.remove(lifeThree);
						end

						if controleLife == 1 then
							display.remove(lifeTwo);
						end

						if controleLife == 0 then
							audio.stop();

							imgHunterOne:removeEventListener("tap", imgHunterOne);
							imgHunterTwo:removeEventListener("tap", imgHunterTwo);
							imgHunterThree:removeEventListener("tap", imgHunterThree);
							imgHunterLider:removeEventListener("tap", imgHunterLider);
							imgAnimalOne:removeEventListener("tap", imgAnimalOne);
							imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
							pauseButton:removeEventListener("tap", pauseGame);
							if soundPaused == 1 then
								soundOnButton:removeEventListener("tap", resumeSound);
							end
							if soundPaused == 0 then
								soundOffButton:removeEventListener("tap", pauseSound);
							end
														
							transition.cancel(imgHunterOne);
							transition.cancel(imgHunterTwo);
							transition.cancel(imgAnimalOne);
							if hunterThreeExist == 1 then
								transition.cancel(imgHunterThree);
							end
							if liderExists == 1 then
								transition.cancel(imgHunterLider);
							end
							if animalTwoExist == 1 then
								transition.cancel(imgAnimalTwo);
							end

							Runtime:removeEventListener("enterFrame", imgBgNuvemRolagem);

							storyboard.gotoScene("gameover", transicaoCena);
						end			
					end

				-- CONTROLE DA VELOCIDADE DE TRANSIÇÃO:

					function controleVelocidade()
						if controlePonto > 0 and controlePonto < 50 then
							timeVilaoOneUp 			= 4500;
							timeVilaoOneDown 		= 4500;
							timeVilaoTwoUp 			= 4000;
							timeVilaoTwoDown 		= 3500;
							timeAnimalOneUp 		= 4000;
							timeAnimalOneDown 		= 4500;

							velocidadeZero.alpha = 1;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 50 and controlePonto < 100 then
							timeVilaoOneUp 			= 4500 - 500;
							timeVilaoOneDown 		= 4500 - 500;
							timeVilaoTwoUp 			= 4000 - 500;
							timeVilaoTwoDown 		= 3500 - 500;
							timeAnimalOneUp 		= 4000 - 500;
							timeAnimalOneDown 		= 4500 - 500;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 1;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 100 and controlePonto < 200 then
							if controlePonto == 180 then
								hunterThreeExist = 1;
								vilaoThreeUp();
								imgHunterThree:addEventListener("tap", imgHunterThree);
							end
							timeVilaoOneUp 			= 4500 - 600;
							timeVilaoOneDown 		= 4500 - 600;
							timeVilaoTwoUp 			= 4000 - 600;
							timeVilaoTwoDown 		= 3500 - 600;
							timeAnimalOneUp 		= 4000 - 600;
							timeAnimalOneDown 		= 4500 - 600;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 1;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 200 and controlePonto < 300 then
							timeVilaoOneUp 			= 4500 - 700;
							timeVilaoOneDown 		= 4500 - 700;
							timeVilaoTwoUp 			= 4000 - 700;
							timeVilaoTwoDown 		= 3500 - 700;
							timeAnimalOneUp 		= 4000 - 700;
							timeAnimalOneDown 		= 4500 - 700;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 1;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 300 and controlePonto < 400 then
							timeVilaoOneUp 			= 4500 - 800;
							timeVilaoOneDown 		= 4500 - 800;
							timeVilaoTwoUp 			= 4000 - 800;
							timeVilaoTwoDown 		= 3500 - 800;
							timeAnimalOneUp 		= 4000 - 800;
							timeAnimalOneDown 		= 4500 - 800;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 1;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 400 and controlePonto < 500 then
							timeVilaoOneUp 			= 4500 - 900;
							timeVilaoOneDown 		= 4500 - 900;
							timeVilaoTwoUp 			= 4000 - 900;
							timeVilaoTwoDown 		= 3500 - 900;
							timeVilaoThreeUp 		= 2000 - 500;
							timeVilaoThreeDown 		= 3000 - 1500;
							timeAnimalOneUp 		= 4000 - 900;
							timeAnimalOneDown 		= 4500 - 900;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 1;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 500 and controlePonto < 600 then
							timeVilaoOneUp 			= 4500 - 1000;
							timeVilaoOneDown 		= 4500 - 1000;
							timeVilaoTwoUp 			= 4000 - 1000;
							timeVilaoTwoDown 		= 3500 - 1000;
							timeAnimalOneUp 		= 4000 - 1000;
							timeAnimalOneDown 		= 4500 - 1000;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 1;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 600 and controlePonto < 700 then
							timeVilaoOneUp 			= 4500 - 1100;
							timeVilaoOneDown 		= 4500 - 1100;
							timeVilaoTwoUp 			= 4000 - 1100;
							timeVilaoTwoDown 		= 3500 - 1100;
							timeAnimalOneUp 		= 4000 - 1100;
							timeAnimalOneDown 		= 4500 - 1100;

							if controlePonto == 630 then
								animalTwoExist = 1;
								animalTwoUp();
								imgAnimalTwo:addEventListener("tap", imgAnimalTwo);
							end

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 1;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 700 and controlePonto < 800 then
							timeVilaoOneUp 			= 4500 - 1200;
							timeVilaoOneDown 		= 4500 - 1200;
							timeVilaoTwoUp 			= 4000 - 1200;
							timeVilaoTwoDown 		= 3500 - 1200;
							timeAnimalOneUp 		= 4000 - 1200;
							timeAnimalOneDown 		= 4500 - 1200;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 1;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 800 and controlePonto < 900 then
							timeVilaoOneUp 			= 4500 - 1300;
							timeVilaoOneDown 		= 4500 - 1300;
							timeVilaoTwoUp 			= 4000 - 1300;
							timeVilaoTwoDown 		= 3500 - 1300;
							timeAnimalOneUp 		= 4000 - 1300;
							timeAnimalOneDown 		= 4500 - 1300;

							if controlePonto == 840 then
								liderExists = 1;
								vilaoLiderUp();
								imgHunterLider:addEventListener("tap", imgHunterLider);
							end

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 1;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 900 and controlePonto < 1100 then
							timeVilaoOneUp 			= 4500 - 1300;
							timeVilaoOneDown 		= 4500 - 1300;
							timeVilaoTwoUp 			= 4000 - 1300;
							timeVilaoTwoDown 		= 3500 - 1300;
							timeAnimalOneUp 		= 4000 - 1300;
							timeAnimalOneDown 		= 4500 - 1300;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 1;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 1100 and controlePonto < 1300 then
							timeVilaoOneUp 			= 4500 - 1400;
							timeVilaoOneDown 		= 4500 - 1400;
							timeVilaoTwoUp 			= 4000 - 1400;
							timeVilaoTwoDown 		= 3500 - 1400;
							timeAnimalOneUp 		= 4000 - 1400;
							timeAnimalOneDown 		= 4500 - 1400;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 1;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 1300 and controlePonto < 1500 then
							timeVilaoOneUp 			= 4500 - 1500;
							timeVilaoOneDown 		= 4500 - 1500;
							timeVilaoTwoUp 			= 4000 - 1500;
							timeVilaoTwoDown 		= 3500 - 1500;
							timeAnimalOneUp 		= 4000 - 1500;
							timeAnimalOneDown 		= 4500 - 1500;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 1;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 1500 and controlePonto < 1700 then
							timeVilaoOneUp 			= 4500 - 1600;
							timeVilaoOneDown 		= 4500 - 1600;
							timeVilaoTwoUp 			= 4000 - 1600;
							timeVilaoTwoDown 		= 3500 - 1600;
							timeAnimalOneUp 		= 4000 - 1600;
							timeAnimalOneDown 		= 4500 - 1600;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 1;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 1700 and controlePonto < 1900 then
							timeVilaoOneUp 			= 4500 - 1700;
							timeVilaoOneDown 		= 4500 - 1700;
							timeVilaoTwoUp 			= 4000 - 1700;
							timeVilaoTwoDown 		= 3500 - 1700;
							timeAnimalOneUp 		= 4000 - 1700;
							timeAnimalOneDown 		= 4500 - 1700;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 1;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 1900 and controlePonto < 2100 then
							timeVilaoOneUp 			= 4500 - 1800;
							timeVilaoOneDown 		= 4500 - 1800;
							timeVilaoTwoUp 			= 4000 - 1800;
							timeVilaoTwoDown 		= 3500 - 1800;
							timeAnimalOneUp 		= 4000 - 1800;
							timeAnimalOneDown 		= 4500 - 1800;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 1;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 2100 and controlePonto < 2300 then
							timeVilaoOneUp 			= 4500 - 1900;
							timeVilaoOneDown 		= 4500 - 1900;
							timeVilaoTwoUp 			= 4000 - 1900;
							timeVilaoTwoDown 		= 3500 - 1900;
							timeAnimalOneUp 		= 4000 - 1900;
							timeAnimalOneDown 		= 4500 - 1900;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 1;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 2300 and controlePonto < 2500 then
							timeVilaoOneUp 			= 4500 - 2000;
							timeVilaoOneDown 		= 4500 - 2000;
							timeVilaoTwoUp 			= 4000 - 2000;
							timeVilaoTwoDown 		= 3500 - 2000;
							timeAnimalOneUp 		= 4000 - 2000;
							timeAnimalOneDown 		= 4500 - 2000;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 1;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 2500 and controlePonto < 2700 then
							timeVilaoOneUp 			= 4500 - 2100;
							timeVilaoOneDown 		= 4500 - 2100;
							timeVilaoTwoUp 			= 4000 - 2100;
							timeVilaoTwoDown 		= 3500 - 2100;
							timeAnimalOneUp 		= 4000 - 2100;
							timeAnimalOneDown 		= 4500 - 2100;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 1;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 2700 and controlePonto < 2900 then
							timeVilaoOneUp 			= 4500 - 2200;
							timeVilaoOneDown 		= 4500 - 2200;
							timeVilaoTwoUp 			= 4000 - 2200;
							timeVilaoTwoDown 		= 3500 - 2200;
							timeAnimalOneUp 		= 4000 - 2200;
							timeAnimalOneDown 		= 4500 - 2200;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 1;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 2900 and controlePonto < 3100 then
							timeVilaoOneUp 			= 4500 - 2300;
							timeVilaoOneDown 		= 4500 - 2300;
							timeVilaoTwoUp 			= 4000 - 2300;
							timeVilaoTwoDown 		= 3500 - 2300;
							timeAnimalOneUp 		= 4000 - 2300;
							timeAnimalOneDown 		= 4500 - 2300;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 1;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 3100 and controlePonto < 3300 then
							timeVilaoOneUp 			= 4500 - 2400;
							timeVilaoOneDown 		= 4500 - 2400;
							timeVilaoTwoUp 			= 4000 - 2400;
							timeVilaoTwoDown 		= 3500 - 2400;
							timeAnimalOneUp 		= 4000 - 2400;
							timeAnimalOneDown 		= 4500 - 2400;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 1;
							velocidadeVinteDois.alpha = 0;
						end

						if controlePonto > 3300 then
							timeVilaoOneUp 			= 4500 - 2500;
							timeVilaoOneDown 		= 4500 - 2500;
							timeVilaoTwoUp 			= 4000 - 2500;
							timeVilaoTwoDown 		= 3500 - 2500;
							timeAnimalOneUp 		= 4000 - 2500;
							timeAnimalOneDown 		= 4500 - 2500;

							velocidadeZero.alpha = 0;
							velocidadeUm.alpha = 0;
							velocidadeDois.alpha = 0;
							velocidadeTres.alpha = 0;
							velocidadeQuatro.alpha = 0;
							velocidadeCinco.alpha = 0;
							velocidadeSeis.alpha = 0;
							velocidadeSete.alpha = 0;
							velocidadeOito.alpha = 0;
							velocidadeNove.alpha = 0;
							velocidadeDez.alpha = 0;
							velocidadeOnze.alpha = 0;
							velocidadeDoze.alpha = 0;
							velocidadeTreze.alpha = 0;
							velocidadeCatorze.alpha = 0;
							velocidadeQuinze.alpha = 0;
							velocidadeDezesseis.alpha = 0;
							velocidadeDezessete.alpha = 0;
							velocidadeDezoito.alpha = 0;
							velocidadeDezenove.alpha = 0;
							velocidadeVinte.alpha = 0;
							velocidadeVinteUm.alpha = 0;
							velocidadeVinteDois.alpha = 1;
						end
					end

			-- FUNÇÕES PARA MENU E BOTÕES DO JOGO:

				function pauseGame()
					audio.play(touchButton);
					audio.pause(ambianceSoundChannelGame);
					
					pauseButton.alpha = 0;
					pauseButton2.alpha = 1;
					resumeButton.alpha = 1;
					restartButton.alpha = 1;
					returnMenuButton.alpha = 1;

					transition.pause();

					soundOffButton:removeEventListener("tap", pauseSound);
					pauseButton:removeEventListener("tap", pauseGame);
					
					resumeButton:addEventListener("tap", resumeGame);
					restartButton:addEventListener("tap", restartGame);
					returnMenuButton:addEventListener("tap", returnGame);

					imgHunterOne:removeEventListener("tap", imgHunterOne);
					imgHunterTwo:removeEventListener("tap", imgHunterTwo);
					imgAnimalOne:removeEventListener("tap", imgAnimalOne);
					if hunterThreeExist == 1 then
						imgHunterThree:removeEventListener("tap", imgHunterThree);
					end
					if animalTwoExist == 1 then
						imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
					end
					if liderExists == 1 then
						imgHunterLider:removeEventListener("tap", imgHunterLider);
					end
				end

				function resumeGame()
					audio.play(touchButton);

					pauseButton.alpha = 1;
					pauseButton2.alpha = 0;
					resumeButton.alpha = 0;
					restartButton.alpha = 0;
					returnMenuButton.alpha = 0;

					if soundPaused == 0 then
						audio.resume(ambianceSoundChannelGame);
					end
					
					transition.resume();

					resumeButton:removeEventListener("tap", resumeGame);
					restartButton:removeEventListener("tap", restartGame);
					returnMenuButton:removeEventListener("tap", returnGame);

					pauseButton:addEventListener("tap", pauseGame);

					soundOffButton:addEventListener("tap", pauseSound);
					imgHunterOne:addEventListener("tap", imgHunterOne);
					imgHunterTwo:addEventListener("tap", imgHunterTwo);
					imgAnimalOne:addEventListener("tap", imgAnimalOne);
					if hunterThreeExist == 1 then
						imgHunterThree:addEventListener("tap", imgHunterThree);
					end
					if animalTwoExist == 1 then
						imgAnimalTwo:addEventListener("tap", imgAnimalTwo);
					end
					if liderExists == 1 then
						imgHunterLider:addEventListener("tap", imgHunterLider);
					end
				end

				function restartGame()
					audio.play(touchButton);
					audio.stop(ambianceSoundChannelGame);

					imgHunterOne:removeEventListener("tap", imgHunterOne);
					imgHunterTwo:removeEventListener("tap", imgHunterTwo);
					imgHunterThree:removeEventListener("tap", imgHunterThree);
					imgHunterLider:removeEventListener("tap", imgHunterLider);
					imgAnimalOne:removeEventListener("tap", imgAnimalOne);
					imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
					if soundPaused == 1 then
						soundOnButton:removeEventListener("tap", resumeSound);
					end
					if soundPaused == 0 then
						soundOffButton:removeEventListener("tap", pauseSound);
					end
												
					transition.cancel(imgHunterOne);
					transition.cancel(imgHunterTwo);
					transition.cancel(imgAnimalOne);
					if hunterThreeExist == 1 then
						transition.cancel(imgHunterThree);
					end
					if liderExists == 1 then
						transition.cancel(imgHunterLider);
					end
					if animalTwoExist == 1 then
						transition.cancel(imgAnimalTwo);
					end

					Runtime:removeEventListener("enterFrame", imgBgNuvemRolagem);

					storyboard.gotoScene("gameover", transicaoCena);					
				end

				function returnGame()
					audio.play(touchButton);
					audio.stop(ambianceSoundChannelGame);

					imgHunterOne:removeEventListener("tap", imgHunterOne);
					imgHunterTwo:removeEventListener("tap", imgHunterTwo);
					imgHunterThree:removeEventListener("tap", imgHunterThree);
					imgHunterLider:removeEventListener("tap", imgHunterLider);
					imgAnimalOne:removeEventListener("tap", imgAnimalOne);
					imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
					if soundPaused == 1 then
						soundOnButton:removeEventListener("tap", resumeSound);
					end
					if soundPaused == 0 then
						soundOffButton:removeEventListener("tap", pauseSound);
					end
												
					transition.cancel(imgHunterOne);
					transition.cancel(imgHunterTwo);
					transition.cancel(imgAnimalOne);
					if hunterThreeExist == 1 then
						transition.cancel(imgHunterThree);
					end
					if liderExists == 1 then
						transition.cancel(imgHunterLider);
					end
					if animalTwoExist == 1 then
						transition.cancel(imgAnimalTwo);
					end

					Runtime:removeEventListener("enterFrame", imgBgNuvemRolagem);

					storyboard.gotoScene("menu", transicaoCena);
				end

				function pauseSound()
					audio.play(touchButton);
					audio.pause(ambianceSoundChannelGame);
					
					soundOffButton.alpha = 0;
					soundOnButton.alpha = 1;

					soundOffButton:removeEventListener("tap", pauseSound);
					soundOnButton:addEventListener("tap", resumeSound);

					soundPaused = 1;
				end

				function resumeSound()
					audio.play(touchButton);
					audio.resume(ambianceSoundChannelGame);

					soundOffButton.alpha = 1;
					soundOnButton.alpha = 0;
					
					soundOnButton:removeEventListener("tap", resumeSound);
					soundOffButton:addEventListener("tap", pauseSound);

					soundPaused = 0;
				end

			-- CHAMADA DOS EVENTOS:

				imgHunterOne:addEventListener("tap", imgHunterOne);
				imgHunterTwo:addEventListener("tap", imgHunterTwo);
				imgAnimalOne:addEventListener("tap", imgAnimalOne);
				pauseButton:addEventListener("tap", pauseGame);
				soundOffButton:addEventListener("tap", pauseSound);
		end

		scene:addEventListener("createScene", scene);

	-- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:

		function scene:enterScene(event)
			local group = self.view;

			ambianceSoundChannelGame = audio.play(ambianceSound, {channel = 4, loops = -1});

			storyboard.removeScene("menu");
			storyboard.removeScene("gameover");

			local int timeVilaoOneUp = 4500;
			local int timeVilaoOneDown = 4500;
			local int timeVilaoTwoUp = 4000;
			local int timeVilaoTwoDown = 3500;
			local int timeVilaoThreeUp = 2000;
			local int timeVilaoThreeDown = 3000;
			local int timeVilaoLiderUp = 1000;
			local int timeVilaoLiderDown = 1500;
			local int timeAnimalOneUp = 3500;
			local int timeAnimalOneDown = 4500;
			local int timeAnimalTwoUp = 1800;
			local int timeAnimalTwoDown = 2500;

			vilaoOneUp();
			vilaoTwoUp();
			animalOneUp();
		end

		scene:addEventListener("enterScene", scene);

	-- FUNÇÃO QUE REMOVE OS OBJETOS AO SAIR DA CENA:
		
		function scene:exitScene(event)
			local group = self.view;

			audio.stop(ambianceSoundChannel);

			display.remove(imgBgCeu);
			display.remove(imgBgNuvem);
			display.remove(imgBgNuvem2);
			display.remove(imgBgNuvem3);
			display.remove(imgBgTerra);
			display.remove(imgHunterOne);
			display.remove(imgHunterTwo);
			display.remove(imgAnimalOne);
			display.remove(bgArbusto);
			display.remove(velocidadeZero);
			display.remove(velocidadeUm);
			display.remove(velocidadeDois);
			display.remove(velocidadeTres);
			display.remove(velocidadeQuatro);
			display.remove(velocidadeCinco);
			display.remove(velocidadeSeis);
			display.remove(velocidadeSete);
			display.remove(velocidadeOito);
			display.remove(velocidadeNove);
			display.remove(velocidadeDez);
			display.remove(velocidadeOnze);
			display.remove(velocidadeDoze);
			display.remove(velocidadeTreze);
			display.remove(velocidadeCatorze);
			display.remove(velocidadeQuinze);
			display.remove(velocidadeDezesseis);
			display.remove(velocidadeDezessete);
			display.remove(velocidadeDezoito);
			display.remove(velocidadeDezenove);
			display.remove(velocidadeVinte);
			display.remove(velocidadeVinteUm);
			display.remove(velocidadeVinteDois);
			display.remove(scoreCount);
			display.remove(lifeOne);
			display.remove(lifeTwo);
			display.remove(lifeThree);
			display.remove(pauseButton);
			display.remove(pauseButton2);
			display.remove(soundOnButton);
			display.remove(soundOffButton);
			display.remove(resumeButton);
			display.remove(restartButton);
			display.remove(returnMenuButton);
			if hunterThreeExist == 1 then
				display.remove(imgHunterThree);
			end
			if liderExists == 1 then
			    display.remove(imgHunterLider);
			end
			if animalTwoExist == 1 then
			    display.remove(imgAnimalTwo);
			end
		end

		scene:addEventListener("exitScene", scene);

	return scene;