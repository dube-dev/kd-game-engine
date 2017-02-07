module.exports = class
	constructor: () ->
		# Initialize default platforms
		@aliases =
			rect: 'Testing.rectangle'
			poly: 'Testing.polygon'

	load_map: (game, data) ->
		
		# Process platforms section
		for item in data.platforms

			shape = item.type
			data = item.data

			# If shape is rectangle, create rectangular platform
			if shape == 'rect' then game.add_entity @aliases.rect,
				x: data[0]
				y: data[1]
				w: data[2]
				h: data[3]

			if shape == 'poly'
				game.add_entity @aliases.poly,
					points: @_user_points_to_matter_vector data.points
					pos: @_user_pos_to_object data.position

	_user_pos_to_object: (position) ->
		result =
			x: position[0]
			y: position[1]
	_user_points_to_matter_vector: (points) ->
		newArry = []
		for pair in points
			vector =
				x: pair[0]
				y: pair[1]
			newArry.push vector
		return newArry
