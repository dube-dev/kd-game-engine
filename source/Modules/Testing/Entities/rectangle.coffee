API = (require "../../../Game").API
Matter = require 'matter-js'

class Model extends API.Interfaces.EntityModel

class Factory extends API.Interfaces.EntityFactory

	make_model: (options, game, id) ->
		body = @_make_body options
		return new Model 'rectangle', body, id

	make_view: (options, game, model) ->
		body = model.get_body()
		return new API.Common.View.BodyRenderable body

	_make_body: (options) ->
		p = options

		# Fix for top-left positioning
		x = p.x + 0.5*p.w
		y = p.y + 0.5*p.h

		body = Matter.Bodies.rectangle(x, y, p.w, p.h)
		Matter.Body.setStatic(body, true)
		return body

module.exports = Factory
