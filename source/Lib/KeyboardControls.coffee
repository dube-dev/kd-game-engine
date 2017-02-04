Emitter = require("events")

module.exports = class extends Emitter

	@KEYSTATE_DOWN: 'down'
	@KEYSTATE_UP: 'up'

	constructor: (controls) ->

		@paused = false

		@KEYSTATE_UP = @constructor.KEYSTATE_UP
		@KEYSTATE_DOWN = @constructor.KEYSTATE_DOWN

		# Store controls in two different ways for speed
		@controlsByName = {}
		@controlsByCode = {}
		# Store clicked controls here
		@controlsClicked = []
		@controlsOn = []

		for control of controls
			@assign_control control, controls[control]

	assign_control: (name, code) ->
		@controlsByCode[code] =
			name: name
			code: code
			state: @KEYSTATE_UP

	bind: (documentObject) ->
		self = @

		documentObject.addEventListener 'keydown', (e) ->
			if not self.paused
				self._process_key_event(e, self.KEYSTATE_DOWN)
		, false

		documentObject.addEventListener 'keyup', (e) ->
			if not self.paused
				self._process_key_event(e, self.KEYSTATE_UP)
		, false

	get_events: () ->
		clicked = @controlsClicked
		@controlsClicked = []
		return clicked

	# Stops listening and allows keyboard events to fall through.
	disable: () ->
		@paused = true
		# Release any keys currently being held down
		for control in @controlsOn by -1
			# Remove from list of active controls
			ƒ.remove_from_list control, @controlsOn
			# Update the state
			control.state = @KEYSTATE_UP
			# Update listeners
			@controlsClicked.push control
			@emit(control.name, control.state)
			@emit('any', control.name, control.state)
	# Resumes listening, preventing default key actions.
	enable:  () -> @paused = false

	_process_key_event: (e, state) ->
		# Ignore if keycode not present
		if e.keyCode not of @controlsByCode then return

		# Get control object
		control = @controlsByCode[e.keyCode]
		# If state has not changed, do nothing
		if control.state == state then return

		# Emit keyboard event
		@emit(control.name, state)
		@emit('any', control.name, state)

		# Set control state
		control.state = state
		# Add control to key events
		@controlsClicked.push control
		# Add or remove from keys being held down
		if state == @KEYSTATE_DOWN then @controlsOn.push control
		else @controlsOn.filter (test) -> test isnt control

		# Disable default keyboard handling
		e.preventDefault()
		return
