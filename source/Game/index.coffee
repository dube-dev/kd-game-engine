# This module provides an interface for the Game package
module.exports =
	Context: require "./Context"
	Engines: require "./Engines"
	Instance: require "./Instance"
	API:
		Interfaces:
			EntityModel: Parts.Entities.EntityModel
			EntityFactory: Parts.Entities.SubEntityFactory
			Module: require "./BaseModule"
		Common: require "./Common"

