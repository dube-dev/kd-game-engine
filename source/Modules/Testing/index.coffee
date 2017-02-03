API = (require "../../Game").API
Entities = require "./Entities"

class ThisModule extends API.Interfaces.Module

	install: (game) ->
		# Add entity subfactories
		for type of Entities
			factory = new Entities[type]
			game.add_entity_factory 'Testing.'+type, factory

module.exports = new ThisModule
