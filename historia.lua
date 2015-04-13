-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO MENU-HISTÓRIA E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD:

		local storyboard = require("storyboard");
		local scene = storyboard.newScene();

	-- CONFIGURAÇÕES DA TELA:

		LAR = display.contentWidth; 	-- ALTURA
		ALT = display.contentHeight;	-- LARGURA

	-- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:
		function scene:createScene(event)
			local group = self.view;

			-- BACKGROUND:
				
				local imgBackground = display.newImageRect("Multimidia/Menu/Historia/img_bg.png", LAR, ALT);
					imgBackground.x = LAR/2;
					imgBackground.y = ALT/2;

				group:insert(imgBackground);

			-- TEXTO DESCRITIVO

				local descricao = display.newImage("Multimidia/Menu/Historia/img_descricao.png");
					descricao.xScale = 0.2;
					descricao.yScale = 0.3;

					descricao.x = LAR/2;
					descricao.y = ALT/2;

				group:insert(descricao);
				
		    -- BOTÃO VOLTAR:

			    returnButton = display.newImage("Multimidia/Menu/Historia/img_return_button.png");
				    returnButton.xScale = 0.7;
				    returnButton.yScale = 0.8;

				    returnButton.x = LAR/2;
				    returnButton.y = (ALT/2 + 120);

			    group:insert(returnButton);

		end

		scene:addEventListener("createScene", scene);

	-- FUNÇÕES DE CHAMADA DE CENAS PARA OS BOTÕES:	

		-- CENA MENU:
			
			function returnMenu()
				display.remove(imgBackground);
				display.remove(returnButton);
				display.remove(descricao);

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