API = (require "../../../Game").API
Matter = require 'matter-js'

class Model extends API.Interfaces.EntityModel

class Factory extends API.Interfaces.EntityFactory

	make_model: (options, game, id) ->
		body = @_make_body options
		return new Model 'polygon', body, id

	make_view: (options, game, model) ->
		body = model.get_body()
		return new API.Common.View.BodyRenderable body

	_make_body: (options) ->
		p = options

		# Fix for top-left positioning
		x = 0
		y = 0

		# Create body
		vertices = Matter.Vertices.create(options.points)
		body = Matter.Bodies.fromVertices(0, 0, vertices)

		# Position body
		bounds = body.bounds
		x = options.pos.x - bounds.min.x
		y = options.pos.y - bounds.min.y

		console.log
			title: "This thing"
			optx: options.pos.x
			boux: bounds.min.x

		Matter.Body.setPosition body,
			x: x
			y: y

		Matter.Body.setStatic(body, true)

		return body

module.exports = Factory
