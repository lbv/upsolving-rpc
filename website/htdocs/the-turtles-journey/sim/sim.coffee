el =
	input: $ '#input'
	sim: $ '#sim'

class Parser
	reBegin = /^begin/
	reBlockOpen = /^\[/
	reBlockClose = /^\]/
	reEnd = /^end/
	reForward = /^forward/
	reLeft = /^left/
	reRepeat = /^repeat/
	reRight = /^right/
	reValue = /^[1-9][0-9]*/
	reWS = /^\s+/
	MOD = 1000003

	constructor: (@prg) ->
		# indices of the last full instruction parsed
		@from = 0
		@to = 0

		@stack = []

		@match = null  # last match
		@idx = 0       # index for matching

	# See if the regular expression matches, and advances if that's the case
	read: (re) ->
		if @match = @prg.substr(@idx).match(re)?[0]
			@idx += @match.length
			return true
		false

	readStrict: (re) ->
		unless @read re
			throw new Error "Expected to match #{re} at #{@idx}"

	readValue: ->
		@readStrict reValue
		parseInt @match, 10

	mod: (x) ->
		if x < MOD then x else x % MOD

	next: ->
		@read reWS

		retVal = true

		if @read reBegin
			@stack.push { fw: 0, lt: 0, rt: 0, rep: 1 }

		else if @read reBlockClose
			p = @stack.pop()
			p.fw = @mod p.fw * p.rep
			p.lt = @mod p.lt * p.rep
			p.rt = @mod p.rt * p.rep

			top = @stack[-1..][0]
			top.fw = @mod top.fw + p.fw
			top.lt = @mod top.lt + p.lt
			top.rt = @mod top.rt + p.rt

		else if @read reEnd
			@stack.pop()
			retVal = false

		else if @read reForward
			@readStrict reWS
			top = @stack[-1..][0]
			top.fw = @mod top.fw + @readValue()

		else if @read reLeft
			@readStrict reWS
			top = @stack[-1..][0]
			top.lt = @mod top.lt + @readValue()

		else if @read reRepeat
			@readStrict reWS
			rep = @readValue()
			@readStrict reWS
			@readStrict reBlockOpen
			@stack.push { fw: 0, lt: 0, rt: 0, rep }

		else if @read reRight
			@readStrict reWS
			top = @stack[-1..][0]
			top.rt = @mod top.rt + @readValue()

		else
			throw new Error "No valid token at #{@idx}"

		@from = @to
		@to = @idx
		retVal

	render: ->
		prg = @prg.substring 0, @from
		prg += '<strong>'
		prg += @prg.substring @from, @to
		prg += '</strong>'
		prg += @prg.substring @to

		if @stack.length is 0
			stk = '<em>Vacía</em>'
		else
			stk = ''
			for i in [@stack.length-1 .. 0]
				ctx = @stack[i]

				fnElem = (key) ->
					"""
					<span class="elem">
						<span class="key">#{key}:</span>
						<span class="val">#{ctx[key]}</span>
					</span>
					"""
				stk += """
				<div class="stack-block">
					#{fnElem 'fw'}
					#{fnElem 'lt'}
					#{fnElem 'rt'}
					#{fnElem 'rep'}
				</div>
				"""

		section = $ """
		<section>
			<table>
				<tr>
					<th>Programa</th>
					<th>Pila</th>
				</tr>
				<tr>
					<td><pre>#{prg}</pre></td>
					<td>#{stk}</td>
				</tr>
			</table>
		</section>
		"""
		el.sim.append section

showError = (msg) ->
	el.sim.empty()
	el.sim.append $ """
	<h2>Ups..</h2>
	<p>Parece que hubo un error en el análisis sintáctico del programa</p>
	<pre>#{msg}</pre>
	<p>Verifique el código fuente, e intente de nuevo</p>
	"""

read = ->
	parser = new Parser el.input.val()
	el.sim.empty()
	parser.render()
	try
		parser.render() while parser.next()
		parser.render()
	catch e
		showError e.message

resetReveal = ->
	read()
	Reveal.initialize
		controls: true
		progress: true
		keyboard: true
		slideNumber: true

$ ->
	el.input.val '''
begin
  forward 20
  left 45
  repeat 4 [
    forward 10
    right 90
  ]
  right 45
end
'''

	resetReveal()
	$('#go').on 'click', -> resetReveal()
