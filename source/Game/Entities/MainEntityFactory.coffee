uuid = require 'node-uuid'

deps = require './depends'
Context         = deps.Context
FactoryTemplate = deps.Base.FactoryTemplate

module.exports = class extends FactoryTemplate

	# Creates a game entity of the given type.
	#
	# Creation of the entity is delegated to a sub-factory
	# registered for the given type by an installed game module.
	#
	# @param [String] type  Type of the entity
	# @param [Object] props  Properties of entity (specific to type)
	# @param [String] uuid  Unique identifier for entity (should be a UUID)
	make: (type, options={}, id) ->
		# If no id is passed, make a v1 uuid
		if not id? then id = uuid.v1()
		options.id = id

		if type of @available
			factory =  @available[type]
			entity = {}

			entity.model = factory.make_model(options, @game, id)
			if game.get_context().env == Context.ENV_CLIENT:
				entity.view = factory.make_view(options, @game, entity.model)

			return entity
		else
			throw new Error "Type '"+type+"' requested but not" +
				" provided by this factory."

	# Creates a game entity using an object, which is useful
	# in multiplayer scenarios.
	#
	# @param [Object] data  Object with entity information 
	# @option data [String] type     Type of the entity
	# @option data [Object] options  Properties of entity (specific to type)
	# @option data [String] uuid     Unique identifier for entity (should be a UUID)
	deserialize: (data) ->
		entity = @make(data.type, data.options, data.uuid)
		return entity
