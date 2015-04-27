-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO MENU E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD:

		local storyboard = require("storyboard");
		local scene = storyboard.newScene();

	-- ARQUIVOS DE ÁUDIO:

		local ambianceSound = audio.loadStream('Multimidia/Menu/song_menu.wav');

		touchButton = audio.loadSound("Multimidia/Menu/song_touch_button.mp3");
		
	-- CONFIGURAÇÕES DA TELA:

		LAR = display.contentWidth; 	-- ALTURA
		ALT = display.contentHeight;	-- LARGURA

	-- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:
		function scene:createScene(event)
			local group = self.view;

			-- BACKGROUND:
				
				local imgBackground = display.newImageRect("Multimidia/Menu/img_bg_menu.png", LAR, ALT);
					imgBackground.x = (LAR/2);
					imgBackground.y = (ALT/2);

				group:insert(imgBackground);
				
			-- LOGO:

		    	local imgLogo = display.newImageRect("Multimidia/Menu/img_logo.png", LAR, ALT);
		    		imgLogo.x = (LAR/2);
		    		imgLogo.y = (ALT/2 - 40);

		    		imgLogo.xScale = 0.4;
		    		imgLogo.yScale = 0.6;

		    	group:insert(imgLogo);

		    		function mostrarNomeJogoUp()
						transition.to(imgLogo, {time = 1000, alpha = 1, x = (LAR/2), y = (ALT/2 - 40), xScale = 0.3, yScale = 0.5, onComplete = moveNomeJogoDown});
					end

					function moveNomeJogoDown()
						imgLogo.alpha = 1;
						transition.to(imgLogo, {time = 1000, alpha = 1, x = (LAR/2), y = (ALT/2 - 40), xScale = 0.4, yScale = 0.6, onComplete = mostrarNomeJogoUp});
					end

				mostrarNomeJogoUp();

		    -- BOTÃO HISTORIA:

			    historyButton = display.newImage("Multimidia/Menu/img_history_button.png");
				    historyButton.xScale = 0.6;
				    historyButton.yScale = 0.6;

				    historyButton.x = (LAR/2 - 150);
				    historyButton.y = (ALT/2 + 130);

			    group:insert(historyButton);

		    -- BOTÃO INSTRUÇÕES:

			    instruButton = display.newImage("Multimidia/Menu/img_instru_button.png");
				    instruButton.xScale = 0.6;
				    instruButton.yScale = 0.6;

				    instruButton.x = (LAR/2 - 50);
				    instruButton.y = (ALT/2 + 130)

			    group:insert(instruButton);

			-- BOTÃO INFORMAÇÕES:

			    infoButton = display.newImage("Multimidia/Menu/img_info_button.png");
				    infoButton.xScale = 0.6;
				    infoButton.yScale = 0.6;

				    infoButton.x = (LAR/2 + 50);
				    infoButton.y = (ALT/2 + 130);

				group:insert(infoButton);

			-- BOTÃO JOGAR:

			    playButton = display.newImage("Multimidia/Menu/img_play_button.png");
				    playButton.xScale = 0.6;
				    playButton.yScale = 0.6;

				    playButton.x = (LAR/2 + 150);
				    playButton.y = (ALT/2 + 130);

				group:insert(playButton);
		end

		scene:addEventListener("createScene", scene);

	-- FUNÇÕES DE CHAMADA DE CENAS PARA OS BOTÕES:

		-- CENA GAME:
			
			function startGame()
				audio.stop();

				display.remove(imgBackground);
				display.remove(imgLogo);
				transition.cancel(imgLogo);
				display.remove(playButton);
				display.remove(infoButton);
				display.remove(instruButton);
				display.remove(historyButton);

				storyboard.gotoScene("game", transicaoCena);
			end

		-- CENA INFO:

			function startInfo()
				audio.play(touchButton);

				display.remove(imgBackground);
				display.remove(imgLogo);
				transition.cancel(imgLogo);
				display.remove(playButton);
				display.remove(infoButton);
				display.remove(instruButton);
				display.remove(historyButton);

				storyboard.gotoScene("info", transicaoCena);
			end

		-- CENA INSTRUÇÕES:

			function startInstru()
				audio.play(touchButton);

				display.remove(imgBackground);
				display.remove(imgLogo);
				transition.cancel(imgLogo);
				display.remove(playButton);
				display.remove(infoButton);
				display.remove(instruButton);
				display.remove(historyButton);

				storyboard.gotoScene("instru", transicaoCena);
			end

		-- CENA HISTÓRIA:

			function startHistoria()
				audio.play(touchButton);

				display.remove(imgBackground);
				display.remove(imgLogo);
				transition.cancel(imgLogo);
				display.remove(playButton);
				display.remove(infoButton);
				display.remove(instruButton);
				display.remove(historyButton);

				storyboard.gotoScene("historia", transicaoCena);
			end
		
	-- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:

		function scene:enterScene(event)
			local group = self.view;

			ambianceSoundChannelMenu = audio.play(ambianceSound, {channel = 1, loops = -1});

			storyboard.removeScene("instru");
			storyboard.removeScene("info");
			storyboard.removeScene("historia");
			storyboard.removeScene("gameover");
			storyboard.removeScene("game");

			playButton:addEventListener("tap", startGame);
			infoButton:addEventListener("tap", startInfo);
			instruButton:addEventListener("tap", startInstru);
			historyButton:addEventListener("tap", startHistoria);
		end

		scene:addEventListener("enterScene", scene);

	-- FUNÇÃO QUE REMOVE OS OBJETOS AO SAIR DA CENA:
		
		function scene:exitScene(event)
			local group = self.view;

			playButton:removeEventListener("tap", startGame);
			infoButton:removeEventListener("tap", startInfo);
			instruButton:removeEventListener("tap", startInstru);
			historyButton:removeEventListener("tap", startHistoria);
		end

		scene:addEventListener("exitScene", scene);

	return scene;