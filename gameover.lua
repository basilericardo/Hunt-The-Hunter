-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DA CENA GAMEOVER.
-------------------------------------------------------------------------------------------------------------------------------

    -- CHAMADA DO STORYBOARD:

        local storyboard = require("storyboard");
        local scene = storyboard.newScene();

    -- ARQUIVOS DE ÁUDIO:

        
    -- CONFIGURAÇÕES DA TELA:

        LAR = display.contentWidth;     -- ALTURA
        ALT = display.contentHeight;    -- LARGURA

    -- FUNÇÃO RESPONSÁVEL POR CRIAR OS OBJETOS DA CENA:

        function scene:createScene(event)
            local group = self.view;

            -- BACKGROUND:
                
                local imgBackground = display.newImageRect("Multimidia/Menu/Gameover/img_bg.png", LAR, ALT);
                    imgBackground.x = LAR/2;
                    imgBackground.y = ALT/2;

                group:insert(imgBackground);
      
            -- BOTÃO VOLTAR:

                returnButton = display.newImage("Multimidia/Menu/Gameover/img_menu_button.png");
                    returnButton.xScale = 0.7;
                    returnButton.yScale = 0.8;

                    returnButton.x = LAR/2;
                    returnButton.y = (ALT/2 + 120);

                group:insert(returnButton);

            -- RESULTADO:

                local pontuacaoFinal = display.newText(scoreFinal, 350, 90, native.systemFont, 20);
                    
                group:insert(pontuacaoFinal);

                local cacadoresCacados = display.newText(hunterHunted, 350, 130, native.systemFont, 20);

                group:insert(cacadoresCacados);
                
                local lideresCacados = display.newText(masterHunterHunted, 350, 170, native. systemFont, 20);
                
                group:insert(lideresCacados);

        end

        scene:addEventListener("createScene", scene);

    -- FUNÇÕES DE CHAMADA DE CENAS PARA OS BOTÕES:   

        -- CENA MENU:
            
            function returnMenu()
                display.remove(imgBackground);
                display.remove(returnButton);

                storyboard.gotoScene("menu");
            end

    -- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA:   

        function scene:enterScene(event)
            local group = self.view;

            storyboard.removeScene("game");

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