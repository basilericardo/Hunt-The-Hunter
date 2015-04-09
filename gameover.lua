-------------------------------------------------------------------------------------------------------------------------------
-- GERAL ->
--
-- ARQUIVO RESPONSÁVEL PELA FUNCIONALIDADE DO MENU-INFO E DE TODOS OS OBJETOS E FUNÇÕES NECESSÁRIAS.
-------------------------------------------------------------------------------------------------------------------------------

    -- CHAMADA DO STORYBOARD

        local storyboard = require("storyboard");
        local scene = storyboard.newScene();

    -- CONFIGURAÇÕES DA TELA

        LAR = display.contentWidth;     -- ALTURA
        ALT = display.contentHeight;    -- LARGURA

    -- FUNÇÃO RESPONSÁVEL POR CRIAR A CENA, CONTENDO TODOS OS OBJETOS DO MENU.
        function scene:createScene(event)
            local group = self.view;

            -- CÉU
                
                local imgBgCeu = display.newImageRect("Multimidia/Menu/Infos/img_bg_ceu.png", LAR, ALT);
                    imgBgCeu.x = LAR/2;
                    imgBgCeu.y = ALT/2;

                    group:insert(imgBgCeu);
      
            -- BOTÃO VOLTAR

                returnButton = display.newImage("Multimidia/Menu/Infos/img_return_button.png");
                    returnButton.xScale = 0.7;
                    returnButton.yScale = 0.8;

                    returnButton.x = LAR/2;
                    returnButton.y = (ALT/2 + 120);

                    group:insert(returnButton);

        end

    -- FUNÇÕES DE CHAMADA DE CENAS PARA OS BOTÕES   

        -- CENA "MENU"
            
            function startMenu()
                storyboard.gotoScene("menu");
            end

    -- FUNÇÃO QUE É CHAMADA AO ENTRAR NA CENA   

        function scene:enterScene(event)
            local group = self.view;

            storyboard.removeScene("game");

            returnButton:addEventListener("tap", startMenu);
        end

    -- FUNÇÃO QUE REMOVE OS OBJETOS AO SAIR DA CENA ATUAL
        
        function scene:exitScene(event)
            local group = self.view;

            returnButton:removeEventListener("tap", startMenu);
        end

-------------------------------------------------------------------------------------------------------------------------------
-- MAIN ->
--
-- Chama os eventos responsáveis pelo funcionamento da cena.
-------------------------------------------------------------------------------------------------------------------------------

    -- ATIVA OS EVENTOS

        scene:addEventListener("createScene", scene);
        scene:addEventListener("enterScene", scene);
        scene:addEventListener("exitScene", scene);

    return scene;