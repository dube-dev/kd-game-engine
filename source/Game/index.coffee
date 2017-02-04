# This module provides an interface for the Game package
Entities = require "./Entities"

module.exports =
	Context: require "./Context"
	Engines: require "./Engines"
	Controllers: require "./Controllers"
	Instance: require "./Instance"
	API:
		Interfaces:
			EntityModel: Entities.EntityModel
			EntityFactory: Entities.SubEntityFactory
			Module: require "./BaseModule"
		Common: require "./Common"

