-- CHAMADA DO STORYBOARD:
	local storyboard = require "storyboard";
	storyboard.gotoScene("menu");


-- TRANSIÇÃO GAME OVER:
	
	transicaoCena = {
		effect = "fade",
		time = 300,
		params = {
			someKey = "someValue",
			someOtherKey = 10
		}
	}