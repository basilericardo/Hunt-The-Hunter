-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO MENU E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.
-------------------------------------------------------------------------------------------------------------------------------

	-- CHAMADA DO STORYBOARD

		local storyboard = require( "storyboard" )
		local scene = storyboard.newScene()

	-- ARQUIVOS DE ÁUDIO

		local ambianceSound = audio.loadStream('Multimidia/Menu/song_menu.mp3')
		
	-- CONFIGURAÇÕES DA TELA

		LAR = display.contentWidth 	-- ALTURA
		ALT = display.contentHeight	-- LARGURA
		display.setStatusBar(display.HiddenStatusBar) -- DESABILITA A BARRA DE STATUS

	-- FUNÇÃO RESPONSÁVEL POR CRIAR A CENA, CONTENDO TODOS OS OBJETOS DO MENU.
		function scene:createScene( event )
			local group = self.view

			-- CÉU
				
				local imgBgCeu = display.newImageRect ("Multimidia/Menu/img_bg_ceu.png", LAR, ALT)
					imgBgCeu.x = LAR/2
					imgBgCeu.y = ALT/2
					group:insert(imgBgCeu)
				
			-- LOGO

		    	local imgLogo = display.newImageRect ("Multimidia/Menu/img_logo.png", LAR, ALT)
		    		imgLogo.x = LAR/2
		    		imgLogo.y = ALT/2 - 40
		    		imgLogo.xScale = 0.4
		    		imgLogo.yScale = 0.6
		    		group:insert(imgLogo)

		    		function mostrarNomeJogoUp()
						transition.to ( imgLogo, {time = 1000, alpha = 1, x = LAR/2, y = ALT/2 - 40, xScale = 0.3, yScale = 0.5, onComplete = moveNomeJogoDown} )
					end

					function moveNomeJogoDown()
						imgLogo.alpha = 1
						transition.to ( imgLogo, {time = 1000, alpha = 1 , x = LAR/2, y = ALT/2 - 40, xScale = 0.4 , yScale = 0.6, onComplete = mostrarNomeJogoUp} )
					end

				mostrarNomeJogoUp()   		

		    -- BOTÃO JOGAR

			    playButton = display.newImage( "Multimidia/Menu/img_play_button.png" )
				    playButton.xScale = 0.7
				    playButton.yScale = 0.8
				    playButton.x = LAR/2
				    playButton.y = (ALT/2 + 120)
				    group:insert(playButton)

			-- BOTÃO INFORMAÇÕES

			    infoButton = display.newImage( "Multimidia/Menu/img_info_button.png" )
				    infoButton.xScale = 0.7
				    infoButton.yScale = 0.8
				    infoButton.x = LAR/2 - 100
				    infoButton.y = (ALT/2 + 120)
				    group:insert(infoButton)

			-- BOTÃO INSTRUÇÕES

			    instruButton = display.newImage( "Multimidia/Menu/img_instru_button.png" )
				    instruButton.xScale = 0.7
				    instruButton.yScale = 0.8
				    instruButton.x = LAR/2 + 100
				    instruButton.y = (ALT/2 + 120)
				    group:insert(instruButton)

		end

	-- FUNÇÕES DE CHAMADA DE CENAS	

		-- CENA "GAME"
			
			function startGame()
				 storyboard.gotoScene("game")
			end

		-- CENA "INFO"

			function startInfo()
				storyboard.gotoScene("info")
			end

		-- CENA "INSTRU"

			function startInstru()
				storyboard.gotoScene("instru")
			end
		
	-- FUNÇÃO DE CHAMADA DE CENA AO CLICAR NO BOTÃO		

		function scene:enterScene( event )
			local group = self.view

			ambianceSoundChannel = audio.play(ambianceSound, {channel = 1, loops = -1})
			playButton:addEventListener("tap", startGame)
			infoButton:addEventListener("tap", startInfo)
			instruButton:addEventListener("tap", startInstru)
		end

	-- REMOVE TODA A CENA ANTERIOR E PARA A MÚSICA AO CLICAR NO BOTÃO
		
		function scene:exitScene( event )
			local group = self.view

			playButton:removeEventListener("tap", startGame)
			infoButton:removeEventListener("tap", startInfo)
			instruButton:removeEventListener("tap", startInstru)
			
			audio.stop( )
		end

-------------------------------------------------------------------------------------------------------------------------------
-- MAIN ->
--
-- Chama os eventos responsáveis pelo funcionamento do menu.
-------------------------------------------------------------------------------------------------------------------------------

	-- ATIVA OS EVENTOS

		scene:addEventListener( "createScene", scene )
		scene:addEventListener( "enterScene", scene )
		scene:addEventListener( "exitScene", scene )

	return scene