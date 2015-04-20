-- CHAMADA DO STORYBOARD:
	local storyboard = require "storyboard";
	storyboard.gotoScene("menu");

-- TRANSIÇÃO DE CENAS:
	
	-- TRANSIÇÃO PADRÃO:

		transicaoCena = {
			effect = "crossFade",
			time = 500,
			params = {
				someKey = "someValue",
				someOtherKey = 10
			}
		}

	-- TRANSIÇÃO GAME OVER:
		
		transicaoGameOver = {
			effect = "zoomOutInFade",
			time = 300,
			params = {
				someKey = "someValue",
				someOtherKey = 10
			}
		}		