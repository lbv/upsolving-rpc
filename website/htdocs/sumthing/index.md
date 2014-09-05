% Sumthing
%
% 3 de Septiembre, 2014

# Sumthing

[Foro de
discusión](http://redprogramacioncompetitiva.com/forum/viewforum.php?f=756).

## Problema

Se nos pide calcular cierta suma que parece un poco peluda<span n>y quizás un
poco barbuda</span>.

En realidad, lo cosa no está tan mal como puede parecer de entrada. Luego de
un buen rato de estar mirando esas sumatorias anidadas, la función
$S(k)$ se puede traducir a:

> $2^{k-1}$ por la suma de los productos de todos los subconjuntos de tamaño
> $k$.

*Ejemplo:*
$$
A=(10, 20, 30, 40)
$$

La lista $A$ tiene 4 elementos, así que hay cuatro valores de $S$ por
calcular:
$$
\begin{align*}
\mathrm{S}(1) &= 2^0 \times (10 + 20 + 30 + 40) = 100 \\
\mathrm{S}(2) &= 2^1 \times (10\cdot20 + 10\cdot30 + 10\cdot40 + 20\cdot30
+ 20\cdot40 + 30\cdot40) = 7000\\
\mathrm{S}(3) &= 2^2 \times (10\cdot20\cdot30 + 10\cdot20\cdot40
+ 10\cdot30\cdot40 + 20\cdot30\cdot40) = 2 \times 10^5 \\
\mathrm{S}(4) &= 2^3 \times 10\cdot20\cdot30\cdot40 = 1.92 \times 10^6
\end{align*}
$$

Y el resultado de sumar todos esos $S$ es:
$$
\Phi = \sum_{k=1}^{n} \mathrm{S}(k) = 2127100
$$

## Estrategia

No puedo evitar acordarme de un profesor que tuve, al que uno le llegaba a la
oficina con algún problema matématico o de programación, y él sonreía,
desocupaba el escritorio, sacaba una hoja y un lapicero, y comenzaba
a charlarlos con uno. Qué tiempos aquellos...

Ese tipo de sesiones en las que nos sentábamos a resolver algún problema
solían seguir un patrón común. Uno le explicaba el problema a mi profesor,
mientras él tomaba notas en la hoja. Cuando ya el problema estaba explicado,
comomenzaba un ciclo: él empezaba diciendo algo como "bueno, comencemos desde
el principio", y procedía a re-escribir las mismas cosas que ya había escrito
más arriba en la hoja. Y luego una pausa, tal vez una o dos sugerencias salían
a flote. Y luego el ciclo volvía a repetirse. Después de cierto número de
iteraciones podía que llegáramos a una respuesta, o al punto en el que mi
profesor nos decía que tenía que salir, pero que lo siguiéramos discutiendo
después (y así era... nadie tenía más interés en resolver el problema que mi
profesor).

A lo que voy con esta historia, es que una de las cosas que me quedó grabada
en la memoria fue ver a mi profesor escribir y reescribir números
correspondientes a los "casos base" de un problema, hasta que eventualmente
dábamos con la perspectiva correcta. O como lo decía mi profesor, no era
cuestión de mirar al problema de frente, sino como "de lado", apretando los
ojos un poquito. Y ahí es cuando el problema toma un aire de belleza que uno
no le encontraba antes; ahí es cuando el problema se deja querer.

Vamos a ver si lo que estoy diciendo resulta claro cuando explique la
estrategia para este problema. Dijimos que la suma *parece* un poco peluda.
Pero las apariencias pueden engañar...

Vamos a los casos base. ¿Cómo luce $\Phi$ si tenemos una lista $A$ con un solo
elementos (digamos, $a$)?
$$
\Phi = a
$$

Bien, y podemos seguir haciendo esto con tras listas un poco más largas. Con
listas de 2 o 3 elementos, la cosa luce así:
$$
\begin{align*}
\Phi_1 &= a \\
\Phi_2 &= a + b + 2ab \\
\Phi_3 &= a + b + c + 2ab +2ac +2bc + 4abc
\end{align*}
$$

Y así podríamos seguir. Pero concentrémonos en estos tres casos. Uno podría
aquí quedarse un buen rato mirando estas igualdades, tratando de encontrarle
la cara amable. Eventualmente, la magia ocurre.

La pregunta es, ¿qué se necesita para convertir a $\Phi_1$ en $\Phi_2$? ¿y qué
se necesita para convertir a $\Phi_2$ en $\Phi_3$?

¿Ya lo ve? Recuerde, mírelo de lado, y apriete los ojos un
poquito<span n>si los aprieta completamente ahí ya no ve nada</span>.

Analicemos parte por parte la expresión para $\Phi_2$:

![](sumthing01.png)

¿Ahora se ve más claro? ¿Cómo describiría el término adicional (con el signo
de interrogación)?

<div p>
Ejercicio

Pruebe que el mismo razonamiento de cómo transformar a $\Phi_1$ en $\Phi_2$
sirve para ir de $\Phi_2$ a $\Phi_3$.
</div>

## Solución

<div ascii="11710">
A mitad de camino me dí cuenta de que no necesitaba un arreglo para almacenar
la lista $A$.
</div>
