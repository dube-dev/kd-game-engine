# The game class provides an interface to game modules.
Emitter = require "events"

Parts =
	Instance: require "./Instance"
	Stage: require "./Stage"
	Entities: require "./Entities"
	Base: require "./Base"

module.exports = class extends Emitter
	constructor: (@context) ->
		@events = new Emitter # Events emitted by engines or modules

		@stage = new Parts.Stage

		@entities = new Parts.Entities.MainEntityFactory @context
		@actions  = new Parts.Base.FactoryTemplate @context
		@triggers = new Parts.Base.FactoryTemplate @context

		@modules = {}

	add_engine: (engine) ->
		engine_i =
			events: @events
			context: @context
			stage: @stage
		engine.activate engine_i

	install_module: (name, module) ->
		@modules[name] = module
		module.install @

	get_context: () -> @context

	add_entity_factory: (type, factory) ->
		@entities.add_factory(type, factory)

	add_entity: (type, options) ->
		# Create entity
		entity = @entities.make type, options
		# Add entity to the stage
		@stage.add_entity entity
		# Return the entity
		return entity

	start: () -> @emit 'init'
