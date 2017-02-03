# The game class provides an interface to game modules.
Emitter = require "events"

Parts =
	Instance: require "./Instance"
	Stage: require "./Stage"
	Entities: require "./Entities"
	Base: require "./Base"

module.exports = class
	constructor: (@context) ->
		@events = new Emitter # Events emitted by engines or modules

		@stage = new Parts.Stage

		@entities = new Parts.Entities.MainEntityFactory @
		@actions  = new Parts.Base.FactoryTemplate @
		@triggers = new Parts.Base.FactoryTemplate @

		@modules = {}

	add_engine: (engine) ->
		engine_i =
			events: @events
			context: @context
			stage: @stage
		engine.activate engine_i

	install_module: (module) ->
		modules.append module
		module.install @

	get_context: () -> @context
