-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DA CENA GAMEOVER.
-------------------------------------------------------------------------------------------------------------------------------

    -- CHAMADA DO STORYBOARD:

        local storyboard = require("storyboard");
        local scene = storyboard.newScene();

    -- ARQUIVOS DE ÁUDIO:

        local gameoverSound = audio.loadSound('Multimidia/Menu/Gameover/song_gameover.mp3');
        
    -- CONFIGURAÇÕES DA TELA:

        LAR = display.contentWidth;     -- ALTURA
        ALT = display.contentHeight;    -- LARGURA

    -- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:

        function scene:createScene(event)
            local group = self.view;

            -- BACKGROUND:
                
                local imgBackground = display.newImageRect("Multimidia/Menu/Gameover/img_bg.png", LAR, ALT);
                    imgBackground.x = (LAR/2);
                    imgBackground.y = (ALT/2);

                group:insert(imgBackground);

            -- TÍTULO:

                local imgTitle = display.newImage("Multimidia/Menu/Gameover/img_gameover_title.png");
                    imgTitle.xScale = 0.2;
                    imgTitle.yScale = 0.2;

                    imgTitle.x = (LAR/2);
                    imgTitle.y = 30;

                group:insert(imgTitle);

            -- RESULTADO:

                scoreFinal = (scoreFinal - (hunterLost * 10));

                local pontuacaoFinal = display.newText(scoreFinal, 360, 95, native.systemFont, 21);
                    
                group:insert(pontuacaoFinal);

                local cacadoresCacados = display.newText(hunterHunted, 361, 141, native.systemFont, 21);

                group:insert(cacadoresCacados);
                
                local cacadoresperdidos = display.newText(hunterLost, 360, 187, native.systemFont, 21);

                group:insert(cacadoresperdidos);

                local lideresCacados = display.newText(masterHunterHunted, 360, 233, native.systemFont, 21);
                
                group:insert(lideresCacados);

            -- BOTÃO JOGAR NOVAMENTE:

                playAgainButton = display.newImage("Multimidia/Menu/Gameover/img_play_again_button.png");
                    playAgainButton.xScale = 0.6;
                    playAgainButton.yScale = 0.6;

                    playAgainButton.x = ((LAR/2) + 50);
                    playAgainButton.y = ((ALT/2) + 130);

                group:insert(playAgainButton);

            -- BOTÃO VOLTAR:

                returnButton = display.newImage("Multimidia/Menu/Gameover/img_menu_button.png");
                    returnButton.xScale = 0.6;
                    returnButton.yScale = 0.6;

                    returnButton.x = ((LAR/2) - 50);
                    returnButton.y = ((ALT/2) + 130);

                group:insert(returnButton);
        end

        scene:addEventListener("createScene", scene);

    -- FUNÇÕES DE CHAMADA DE CENAS PARA OS BOTÕES:   

        -- CENA MENU:
            
            function returnMenu()
                audio.play(touchButton);

                storyboard.gotoScene("menu", transicaoCena);

                scoreFinal = 0;
                hunterHunted = 0;
                hunterLost = 0;
                hunterLostPoint = 0;
                masterHunterHunted = 0;
                
                display.remove(imgBackground);
                display.remove(imgTitle);
                display.remove(returnButton);
                display.remove(playAgainButton);
                display.remove(pontuacaoFinal);
                display.remove(cacadoresCacados);
                display.remove(cacadoresperdidos);
                display.remove(lideresCacados);
            end

        -- CENA GAME:

            function playAgain()
                audio.play(touchButton);

                storyboard.gotoScene("game", transicaoCena);

                scoreFinal = 0;
                hunterHunted = 0;
                hunterLost = 0;
                hunterLostPoint = 0;
                masterHunterHunted = 0;

                display.remove(imgBackground);
                display.remove(imgTitle);
                display.remove(returnButton);
                display.remove(playAgainButton);
                display.remove(pontuacaoFinal);
                display.remove(cacadoresCacados);
                display.remove(cacadoresperdidos);
                display.remove(lideresCacados);
            end

    -- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:   

        function scene:enterScene(event)
            local group = self.view;

            audio.play(gameoverSound);

            returnButton:addEventListener("tap", returnMenu);
            playAgainButton:addEventListener("tap", playAgain);

            storyboard.removeScene("game");
        end

        scene:addEventListener("enterScene", scene);

    -- FUNÇÃO QUE REMOVE OS OBJETOS AO SAIR DA CENA:
        
        function scene:exitScene(event)
            local group = self.view;

            audio.stop();

            returnButton:removeEventListener("tap", returnMenu);
            playAgainButton:removeEventListener("tap", playAgain);
        end

        scene:addEventListener("exitScene", scene);

    return scene;