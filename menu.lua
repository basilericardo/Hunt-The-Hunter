-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO MENU E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD:

		local storyboard = require("storyboard");
		local scene = storyboard.newScene();

	-- ARQUIVOS DE ÁUDIO:

		local ambianceSound = audio.loadStream('Multimidia/Menu/song_menu.mp3');
		
	-- CONFIGURAÇÕES DA TELA:

		LAR = display.contentWidth; 	-- ALTURA
		ALT = display.contentHeight;	-- LARGURA

	-- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:
		function scene:createScene(event)
			local group = self.view;

			-- BACKGROUND:
				
				local imgBackground = display.newImageRect("Multimidia/Menu/img_bg_ceu.png", LAR, ALT);
					imgBackground.x = LAR/2;
					imgBackground.y = ALT/2;

				group:insert(imgBackground);
				
			-- LOGO:

		    	local imgLogo = display.newImageRect("Multimidia/Menu/img_logo.png", LAR, ALT);
		    		imgLogo.x = LAR/2;
		    		imgLogo.y = (ALT/2 - 40);

		    		imgLogo.xScale = 0.4;
		    		imgLogo.yScale = 0.6;

		    	group:insert(imgLogo);

		    		function mostrarNomeJogoUp()
						transition.to(imgLogo, {time = 1000, alpha = 1, x = LAR/2, y = (ALT/2 - 40), xScale = 0.3, yScale = 0.5, onComplete = moveNomeJogoDown});
					end

					function moveNomeJogoDown()
						imgLogo.alpha = 1;
						transition.to(imgLogo, {time = 1000, alpha = 1, x = LAR/2, y = (ALT/2 - 40), xScale = 0.4, yScale = 0.6, onComplete = mostrarNomeJogoUp});
					end

				mostrarNomeJogoUp();		

		    -- BOTÃO JOGAR:

			    playButton = display.newImage("Multimidia/Menu/img_play_button.png");
				    playButton.xScale = 0.7;
				    playButton.yScale = 0.8;

				    playButton.x = LAR/2;
				    playButton.y = (ALT/2 + 120);

				group:insert(playButton);

			-- BOTÃO INFORMAÇÕES:

			    infoButton = display.newImage("Multimidia/Menu/img_info_button.png");
				    infoButton.xScale = 0.7;
				    infoButton.yScale = 0.8;

				    infoButton.x = (LAR/2 - 100);
				    infoButton.y = (ALT/2 + 120);

				group:insert(infoButton);

			-- BOTÃO INSTRUÇÕES:

			    instruButton = display.newImage("Multimidia/Menu/img_instru_button.png");
				    instruButton.xScale = 0.7;
				    instruButton.yScale = 0.8;

				    instruButton.x = (LAR/2 + 100);
				    instruButton.y = (ALT/2 + 120);

			    group:insert(instruButton);

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
				
				storyboard.gotoScene("game");
			end

		-- CENA INFO:

			function startInfo()
				display.remove(imgBackground);
				display.remove(imgLogo);
				transition.cancel(imgLogo);
				display.remove(playButton);
				display.remove(infoButton);
				display.remove(instruButton);

				storyboard.gotoScene("info");
			end

		-- CENA INSTRUÇÕES:

			function startInstru()
				display.remove(imgBackground);
				display.remove(imgLogo);
				transition.cancel(imgLogo);
				display.remove(playButton);
				display.remove(infoButton);
				display.remove(instruButton);

				storyboard.gotoScene("instru");
			end
		
	-- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:

		function scene:enterScene(event)
			local group = self.view;

			ambianceSoundChannel = audio.play(ambianceSound, {channel = 1, loops = -1});

			storyboard.removeScene("instru");
			storyboard.removeScene("info");
			storyboard.removeScene("gameover");

			playButton:addEventListener("tap", startGame);
			infoButton:addEventListener("tap", startInfo);
			instruButton:addEventListener("tap", startInstru);
		end

		scene:addEventListener("enterScene", scene);

	-- FUNÇÃO QUE REMOVE OS OBJETOS AO SAIR DA CENA:
		
		function scene:exitScene(event)
			local group = self.view;

			playButton:removeEventListener("tap", startGame);
			infoButton:removeEventListener("tap", startInfo);
			instruButton:removeEventListener("tap", startInstru);
		end

		scene:addEventListener("exitScene", scene);

	return scene;