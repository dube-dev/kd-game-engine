module.exports = class
	# @param [Object] game  object passed by Game class
	depends: () -> []
	install: (game) -> throw new Error "Module has no install method!"
