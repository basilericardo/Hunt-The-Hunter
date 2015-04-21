-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO MENU-HISTÓRIA E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD:

		local storyboard = require("storyboard");
		local scene = storyboard.newScene();

	-- ARQUIVOS DE ÁUDIO:

		local touchButton = audio.loadSound("Multimidia/Menu/Historia/song_touch_button.mp3");

	-- CONFIGURAÇÕES DA TELA:

		LAR = display.contentWidth; 	-- ALTURA
		ALT = display.contentHeight;	-- LARGURA

	-- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:
		function scene:createScene(event)
			local group = self.view;

			-- BACKGROUND:
				
				local imgBackground = display.newImageRect("Multimidia/Menu/Historia/img_bg.png", LAR, ALT);
					imgBackground.x = (LAR/2);
					imgBackground.y = (ALT/2);

				group:insert(imgBackground);

			-- TÍTULO:

				local imgTitle = display.newImage("Multimidia/Menu/Historia/img_history_title.png");
					imgTitle.xScale = 0.2;
					imgTitle.yScale = 0.2;

					imgTitle.x = (LAR/2);
					imgTitle.y = 30;

				group:insert(imgTitle);
				
		    -- BOTÃO VOLTAR:

			    returnButton = display.newImage("Multimidia/Menu/Historia/img_return_button.png");
				    returnButton.xScale = 0.7;
				    returnButton.yScale = 0.8;

				    returnButton.x = (LAR/2);
				    returnButton.y = ((ALT/2) + 120);

			    group:insert(returnButton);

		end

		scene:addEventListener("createScene", scene);

	-- FUNÇÕES DE CHAMADA DE CENAS PARA OS BOTÕES:	

		-- CENA MENU:
			
			function returnMenu()
				audio.play(touchButton);
				
				display.remove(imgBackground);
				display.remove(imgTitle);
				display.remove(returnButton);

				storyboard.gotoScene("menu");
			end

	-- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:		

		function scene:enterScene(event)
			local group = self.view;

			storyboard.removeScene("menu");

			returnButton:addEventListener("tap", returnMenu);
		end

		scene:addEventListener("enterScene", scene);

	-- FUNÇÃO QUE REMOVE OS OBJETOS AO SAIR DA CENA:
		
		function scene:exitScene(event)
			local group = self.view;

			returnButton:removeEventListener("tap", returnMenu);
		end

		scene:addEventListener("exitScene", scene);

	return scene;