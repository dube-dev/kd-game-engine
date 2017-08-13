# This class provides a common structure for extensible factories.
module.exports = class

	# @param [Object] api  API available to sub-factories
	constructor: (@context) ->
		@available = {}

	# Add a sub-factory to be called in order to create an object
	# of type `type`
	#
	# @param [String] type  name of the type made by this factory
	# @param [Object] factory  sub-factory to create this type
	add_factory: (type, factory) ->
		@available[type] = factory
		return null

	# Create an object using the sub-factory designated for
	# type `type`
	#
	# @param [String] type  name of type to create
	# @param [Object] options  options to pass to sub-factory
	make: (type, options={}) ->
		if type of @available
			return @available[type].make(options, @context)
		else
			throw new Error "Type '"+type+"' requested but not" +
				" provided by this factory."
