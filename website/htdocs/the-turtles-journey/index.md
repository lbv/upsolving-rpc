% The Turtle's Journey
%
% 11 de Septiembre, 2014

# The Turtle's Journey

[Foro de
discusión](http://redprogramacioncompetitiva.com/forum/viewforum.php?f=757).

## Problema

Escribir un pequeño intérprete para un limitado subconjunto del lenguaje
[Logo](http://en.wikipedia.org/wiki/Logo_(programming_language)), llamado
MicroLogo.

El lenguaje solo cuenta con 4 operaciones, de las cuales la más interesante es
`repeat`, ya que introduce recursión en la gramática. Las otras instrucciones
mueven a la tortuga (hacia adelante cierto número de pasos, o girándola hacia
la izquierda o la derecha).

Se pide que, a partir de un programa de MicroLogo válido, se reporte el total
de pasos que avanza y la cantidad de grados que gira a la derecha e izquierda
la tortuga al ejecutarse el programa.

## Estrategia

Después de que terminó la maratón, salimos con algunos de los equipos que
estaban participando desde la U. Javeriana a comer pizza. Durante la
charla tuve una excelente conversación con dos integrantes del único equipo
que resolvió este problema en esa sede.

La charla fue algo así (disculpen si me tomo muchas libertades con el
parafraseo, mi memoria es horrible):

| Yo: Ahh.., ustedes fueron los que resolvieron el de la tortuga.
| Ellos: Sí.
| - Qué bueno, ¿cómo lo hicieron?
| - (sonrisas) Bueno, solamente hicimos funciones para manejar cada instrucción y... (detalles que no recuerdo muy bien)
| - ¿Entonces escribieron un parser recursivo?
| - (miradas extrañas) ehh, no, solamente escribimos unas funciones...
| - ¿No lo hicieron recursivo? ¿Usaron una pila?
| - No, no, solo escribimos cuatro funciones, una para cada instrucción, y...
| - Un momento, a ver si entendí.. ¿escribieron cuatro funciones? ¿una para cada instrucción?
| - Sí.
| - ¿Y la función para `repeat` no se llama a sí misma?
| - No. (una pausa..) Ah, no, sí, cuando encuentra otro `repeat` por dentro.
| - (una pausa, en la que tal vez se asustaron de mi cara de felicidad) Felicitaciones. Escribieron un parser recursivo. Ya saben cómo escribir compiladores.

Esta conversación me alegró enormemente. Hasta donde tengo entendido, mis
amigos con quienes estaba hablando apenas van en un tercio de su carrera, y no
han pasado por cursos de estructuras de datos ni teoría de compiladores. ¡Y
escribieron un parser recursivo sin saber ni siquiera el nombre que los
"teóricos"<span n>esos barbudos petulantes...</span> le dan a eso! Qué
felicidad me da.

Y hubo más. Luego me contaron de cómo recibieron AC solo después de unos
8 envíos, y solucionar varios bugs en el código. ¿Hay algo más delicioso que
recibir un AC después de muchos WA en una competencia?

En fin... Se debe escribir algún tipo de *parser*, y hay muchas formas de
hacerlo. La primera vez que solucioné este problema lo hice utilizando mi
plantilla de código para parsers de recursión descendente, pero para cambiar
un poco, esta vez intentaré resolverlo sin llamados recursivos y utilizando
una pila. Creo que el código resultará mucho más corto así. Vamos a ver.

La idea es simple. Usaremos tuplas del tipo `(fw, lt, rt, rep)` para llevar la
cuenta de pasos que ha avanzado la tortuga, de los grados que ha girado hacia
la izquierda o la derecha y, adicionalmente, del número de *repeticiones*.
Cada tupla de éstas describe un *contexto*, con lo que quiero decir, el nivel
de anidamiento en el que nos encontramos. Cada programa arranca en el contexto
global, con valores `fw: 0, lt: 0, rt: 0, rep: 1`, y por cada operación
`repeat N [ INST ]` que encontremos crearemos una nueva tupla con valores `fw:
0, lt: 0, rt: 0, rep: N`, que pondremos en la pila y se actualizará a medida
que se procesen las instrucciones en `INST`. Cuando el contexto se termine (al
haber encontrado el token de cierre `]`) tomamos el tope de la pila,
multiplicamos los valores `fw, lt, rt` por `rep`, y sumamos esos números al
contexto que queda como nuevo tope de la pila. ¿Tiene sentido lo que digo?

Puede ser que el párrafo anterior sea un poco difícil de entender para alguien
que no esté muy familiarizado con el procesamiento de texto---"*parseo*", si
se quiere<span n>yo quiero, es encantador conjugar el verbo *parsear*; yo
parseo, tu parseas, etc.</span>. Afortunadamente, problemas como éste son la
excusa perfecta para romper el hielo y familiarizarse con este tema.

### Simulación

La siguiente simulación ilustra el proceso de análisis sintáctico (*parsing*)
de un programa de MicroLogo, mostrando cómo se modifica la pila a medida que
se leen los tokens: <a href="sim/" target="sim">Simulación
<small><i class="fa fa-external-link"></i></small></a>.


## Solución

<div ascii="11711"></div>
