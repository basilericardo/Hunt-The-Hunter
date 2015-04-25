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

					local scoreName = display.newText('Score:', 20, 9, native.systemFont, 12);
					
					group:insert(scoreName);

					local scoreCount = display.newText('0', 43, 9, native.systemFont, 12);
						
					group:insert(scoreCount);

				-- PONTOS DE VIDA:					
					
					local lifeOne = display.newImage("Multimidia/Game/img_life_1.png", 445, 10);
						lifeOne.xScale = 0.3;
						lifeOne.yScale = 0.3;

					group:insert(lifeOne);

					local lifeTwo = display.newImage("Multimidia/Game/img_life_2.png", 445, 10);
						lifeTwo.xScale = 0.3;
						lifeTwo.yScale = 0.3;

					group:insert(lifeTwo);

					local lifeThree = display.newImage("Multimidia/Game/img_life_3.png", 445, 10);
						lifeThree.xScale = 0.3;
						lifeThree.yScale = 0.3;

					group:insert(lifeThree);

				-- BOTÃO DE MENU:

					local pauseButton = display.newImage("Multimidia/Game/img_pause_button.png", 465, 33);
						pauseButton.xScale = 0.1;
						pauseButton.yScale = 0.1;

					group:insert(pauseButton);

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

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 43;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 46;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 49;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 52;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 55;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 59;
							end

							if controlePonto > 999999 then
								scoreCount.x = 61;
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

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 43;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 46;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 49;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 52;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 55;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 59;
							end

							if controlePonto > 999999 then
								scoreCount.x = 61;
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

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 43;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 46;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 49;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 52;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 55;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 59;
							end

							if controlePonto > 999999 then
								scoreCount.x = 61;
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

						-- CONTROLE DE POSIÇÃO DA PONTUAÇÃO

							if controlePonto >= 0 and controlePonto < 10 then
								scoreCount.x = 43;
							end

							if controlePonto > 9 and controlePonto < 100 then
								scoreCount.x = 46;
							end

							if controlePonto > 99 and controlePonto < 1000 then
								scoreCount.x = 49;
							end 
							
							if controlePonto > 999 and controlePonto < 10000 then
								scoreCount.x = 52;
							end

							if controlePonto > 9999 and controlePonto < 100000 then
								scoreCount.x = 55;
							end

							if controlePonto > 99999 and controlePonto < 1000000 then
								scoreCount.x = 59;
							end

							if controlePonto > 999999 then
								scoreCount.x = 61;
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
							timeVilaoThreeUp 		= 2000 - 500;
							timeVilaoThreeDown 		= 3000 - 1500;
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

							if controlePonto == 630 then
								animalTwoExist = 1;
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

							if controlePonto == 840 then
								liderExists = 1;
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

						if controlePonto > 2700 and controlePonto < 2900 then
							timeVilaoOneUp 			= 4500 - 2200;
							timeVilaoOneDown 		= 4500 - 2200;
							timeVilaoTwoUp 			= 4000 - 2200;
							timeVilaoTwoDown 		= 3500 - 2200;
							timeAnimalOneUp 		= 4000 - 2200;
							timeAnimalOneDown 		= 4500 - 2200;
						end

						if controlePonto > 2900 and controlePonto < 3100 then
							timeVilaoOneUp 			= 4500 - 2300;
							timeVilaoOneDown 		= 4500 - 2300;
							timeVilaoTwoUp 			= 4000 - 2300;
							timeVilaoTwoDown 		= 3500 - 2300;
							timeAnimalOneUp 		= 4000 - 2300;
							timeAnimalOneDown 		= 4500 - 2300;
						end

						if controlePonto > 3100 and controlePonto < 3300 then
							timeVilaoOneUp 			= 4500 - 2400;
							timeVilaoOneDown 		= 4500 - 2400;
							timeVilaoTwoUp 			= 4000 - 2400;
							timeVilaoTwoDown 		= 3500 - 2400;
							timeAnimalOneUp 		= 4000 - 2400;
							timeAnimalOneDown 		= 4500 - 2400;
						end
					end

			-- FUNÇÕES PARA MENU DO JOGO:

				function pauseGame()
					pauseButton.alpha = 0;
					resumeButton.alpha = 1;
					restartButton.alpha = 1;
					returnMenuButton.alpha = 1;

					audio.pause(ambianceSoundChannel);
					transition.pause();

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
					resumeButton.alpha = 0;
					restartButton.alpha = 0;
					returnMenuButton.alpha = 0;
					pauseButton.alpha = 1;

					audio.resume(ambianceSoundChannel);
					transition.resume();

					resumeButton:removeEventListener("tap", resumeGame);
					restartButton:removeEventListener("tap", restartGame);
					returnMenuButton:removeEventListener("tap", returnGame);

					pauseButton:addEventListener("tap", pauseGame);

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
					audio.stop();

					imgHunterOne:removeEventListener("tap", imgHunterOne);
					imgHunterTwo:removeEventListener("tap", imgHunterTwo);
					imgHunterThree:removeEventListener("tap", imgHunterThree);
					imgHunterLider:removeEventListener("tap", imgHunterLider);
					imgAnimalOne:removeEventListener("tap", imgAnimalOne);
					imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
												
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
					audio.stop();

					imgHunterOne:removeEventListener("tap", imgHunterOne);
					imgHunterTwo:removeEventListener("tap", imgHunterTwo);
					imgHunterThree:removeEventListener("tap", imgHunterThree);
					imgHunterLider:removeEventListener("tap", imgHunterLider);
					imgAnimalOne:removeEventListener("tap", imgAnimalOne);
					imgAnimalTwo:removeEventListener("tap", imgAnimalTwo);
												
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

			-- CHAMADA DOS EVENTOS:

				imgHunterOne:addEventListener("tap", imgHunterOne);
				imgHunterTwo:addEventListener("tap", imgHunterTwo);
				imgAnimalOne:addEventListener("tap", imgAnimalOne);
				pauseButton:addEventListener("tap", pauseGame);
		end

		scene:addEventListener("createScene", scene);

	-- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:

		function scene:enterScene(event)
			local group = self.view;

			ambianceSoundChannel = audio.play(ambianceSound, {channel = 4, loops = -1});

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
			display.remove(scoreName);
			display.remove(scoreCount);
			display.remove(lifeOne);
			display.remove(lifeTwo);
			display.remove(lifeThree);
			display.remove(pauseButton);
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