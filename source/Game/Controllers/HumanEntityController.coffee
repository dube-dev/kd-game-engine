deps = require './depends'
KControls = deps.Lib.KeyboardControls

# This class listens to control events and converts them
# into actions that an entity model will understand.
module.exports = class
	constructor: (@controls, @creature) ->

		console.log @creature
		if 'model' of @creature then @creature = @creature.model

		@walking = 'halted'

		S = @

		@controls.on 'walk.left', (state) ->

			# If walking left and let go of left
			if S.walking == 'left' and state == KControls.KEYSTATE_UP
				S.walking = 'halted'
				S.creature.perform_action 'walk.halt'

			# If started holding left
			else if state is KControls.KEYSTATE_DOWN
				S.walking = 'left'
				S.creature.perform_action 'walk.left'

		@controls.on 'walk.right', (state) ->

			# if walking right and let go of right
			if S.walking == 'right' and state == KControls.KEYSTATE_UP
				S.walking = 'halted'
				S.creature.perform_action 'walk.halt'

			# If started holding right
			else if state is KControls.KEYSTATE_DOWN
				S.walking = 'right'
				S.creature.perform_action 'walk.right'

		@controls.on 'walk.jump', (state) ->
			if state == KControls.KEYSTATE_UP
				S.creature.perform_action 'walk.jump'
