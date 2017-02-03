Game = require "./Game"
Modules = require "./Modules"

module.exports = class
	constructor: () ->

	build_client: (canvas, _window) ->
		context =
			env: Game.Context.ENV_CLIENT
		game = Game.make_new_instance context
		# Add engines here based on @context
		game.add_engine new Game.Engines.Physics
		game.add_engine new Game.Engines.Render canvas, _window
		# Install default modules here
		@install_all_modules game, Modules

		return game

	install_all_modules: (game, modules) ->

		# Empty list to track installed modules
		# (for when a module was a dependancy)
		installed = []

		# Loop through all modules
		for mod of modules
			# Skip if already added
			if mod in installed then continue

			module = modules[mod]

			# Loop through module dependancies
			for dmod in module.depends()
				# Skip if already added
				if dmod in installed then continue

				# Install dependancy
				dmodule = modules[dmod]
				game.install_module dmodule
				installed.push dmod

			# Install module
			game.install_module module
			installed.push mod
