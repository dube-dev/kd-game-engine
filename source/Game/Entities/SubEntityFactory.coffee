deps = require "./depends"
Context = deps.Context

# Base class for entity subfactory
module.exports = class
	# @param [Object] context  contains information about the running instance
	# @option context [Number] env  constant of Context for environment
	constructor: (@context) ->

	make_model: (options, game, id) -> throw new Error "No implementation for make_model"
	make_view: (options, game, model) -> throw new Error "No implementation for make_view"
