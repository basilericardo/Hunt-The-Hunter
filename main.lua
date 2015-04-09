display.setStatusBar(display.HiddenStatusBar); -- DESABILITA A BARRA DE STATUS

local storyboard = require "storyboard";
storyboard.gotoScene("menu");

-- VARIÁVEL QUE IRÁ MOSTRAR A QUANTIDADE DE PONTOS QUE FOI OBTIDA
	scoreFinal = 0;
-- VARIÁVEL QUE IRÁ CONTAR QUANTOS CAÇADORES O JOGADOR PRENDEU
	hunterHunted = 0;
-- VARIÁVEL QUE IRÁ CONTAR QUANTOS CAÇADORES LIDER O JOGADOR PRENDEU
	masterHunterHunted = 0;