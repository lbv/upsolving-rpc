scast_msg = """
<div class="panel-body screencast-aviso">
  <p>
    <em>Aviso:</em> Detrás de este botón se encuentra una grabación que
    muestra el proceso de escribir una posible solución a este problema. Mi
    sugerencia es que siga adelante solo tras haberse tomado su tiempo con
    las secciones anteriores.  Ante todo, le recomiendo encarecidamente que
    no me permita arrebatarle la oportunidad de tener la maravillosa
    experiencia <em>Eureka</em> de entender y resolver un problema.
  </p>
  <p><button type="button"
  class="btn btn-info open-screencast">Continuar</button></p>
</div>
"""

setupScreencast = ->
	return if $('.asciinema').length == 0
	asciiID = $('.asciinema')[0].dataset['id']
	$('.screencast').hide().after $(scast_msg)
	$('.open-screencast').on 'click', ->
		$('.screencast-aviso').hide()
		$('.screencast').show()

		script =
			"<sc" + "ript type=\"text/javascript\" " +
			"src=\"https://asciinema.org/a/#{asciiID}.js\" " +
			"id=\"asciicast-#{asciiID}\" async></s" + "cript>"
		$('.asciinema').append $(script)

setupMath = ->
	return unless MathJax?
	MathJax.Hub.Config {
		"HTML-CSS":
			availableFonts: []
			preferredFont: null
			webFont: "Neo-Euler"
	}

$ ->
	setupMath()
	setupScreencast()
