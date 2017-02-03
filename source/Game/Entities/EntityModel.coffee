deps = require "./depends"
Body = deps.Matter.Body # For body transformations
Lib = deps.Lib # For serializing body

# This class represents any entity in the game.
# An entity has a type, body, and id.
# Additionally, any entity is an emitter. This is so
# that game modules can send their own events to entities
# in such a way that allows for "soft dependancies". i.e.,
# an entity can provide extra functionality if it receives
# an event from a certain module, but if that module is not
# loaded the entity will still function as normal.
module.exports = class extends deps.Emitter

	constructor: (@type, @body, @uuid) ->

	get_type: () -> @type
	get_body: () -> @body

	set_position: (x, y) ->
		if typeof x is 'object'
			Body.setPosition(@body, x)
		else
			Body.setPosition(@body, {x:x,y:y})

	get_position: () -> @body.position

	# Serialize enough entity data to recreate on client
	serialize: () ->
		# Add one-time-only properties
		data =
			type: @type
		# Add every-time properties
		Object.assign data, @serialize_update()
		# Return object
		return data

	# Serialize enough entity data to update the client
	serialize_update: () ->
		data =
			uuid: @uuid,
			body_data: Lib.Body.serialize(@body)

	deserialize_update: (datum) ->
		dat  = datum.body_data
		Lib.Body.update_from_serialized_data @body, dat

	# @param deltaT time difference
	update: (deltaT) ->

	set_id: (@uuid) ->
	get_id: () -> @uuid
