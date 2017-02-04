API = (require "../../../Game").API
Matter = require 'matter-js'

class Model extends API.Interfaces.EntityModel
	init: () ->
		@walking = 0

	perform_action: (action, params=null) ->
		super action, params

		console.log action

		if action == 'walk.left'
			@walking = -1

		if action == 'walk.right'
			@walking = 1

		if action == 'walk.halt'
			@walking = 0

	update: (deltaT) ->
		console.log @walking
		
		av = @body.angularVelocity
		av += @walking*0.5*(deltaT/1000)
		Matter.Body.setAngularVelocity(@body, av)

class Factory extends API.Interfaces.EntityFactory

	make_model: (options, game, id) ->
		body = @_make_body options
		return new Model 'ball', body, id

	make_view: (options, game, model) ->
		body = model.get_body()
		return new API.Common.View.BodyRenderable body

	_make_body: (options) ->
		body = Matter.Bodies.circle(
			options.x, options.y,
			options.radius
		)
		return body

module.exports = Factory
