% Upsolving · Binary Search Tree
%
% 3 de Septiembre, 2014

# Binary Search Tree

[Foro de
discusión](http://redprogramacioncompetitiva.com/forum/viewforum.php?f=755).

## Problema

Tenemos una lista ordenada de $N$ elementos, que representan probabilidades de
la ocurrencia de ciertos símbolos, en donde la suma de todos los valores es
igual a 1.

Se desea formar un árbol binario a partir de esa lista, minimizando el *costo
esperado* de encontrar un símbolo en ese árbol. El costo de alcanzar un
símbolo determinado es igual al nivel del nodo correspondiente (la raíz tiene
costo 1, los hijos de la raíz tienen costo 2, los hijos de los hijos tienen
costo 3, etc).

Ejemplo:
$$
p = (0.20, 0.45, 0.10, 0.20, 0.05)
$$

Este es un caso en donde hay 5 símbolos. No se sabe cuáles son los símbolos
(ladridos en lenguaje de perros), pero se sabe que ahí están en orden (el
símbolo 1 es menor lexicográficamente que el símbolo 2, el 2 es menor que el
3, etc). Los números en esta lista son las probabilidades de que el símbolo
correspondiente sea elegido al azar.

Hay muchas formas de armar árboles binarios a partir de 5 símbolos. Por
ejemplo:

<div class="container">
![](bst01.png)
![](bst02.png)
![](bst03.png)
</div>

El último de estos grafos resulta ser el BST óptimo para este ejemplo. El
*costo esperado* de búsqueda en este árbol se calcula multiplicando el valor
$p_i$ por el costo de cada nodo, y sumando todos esos valores.
$$
C_E = (0.2 \times 2) + (0.45 \times 1) + (0.1 \times 3) + (0.2 \times 2) + (0.05
\times 3) = 1.7
$$

<div p>
Ejercicio

Verificar a mano con algunos otros árboles, que no es posible
encontrar un BST con un costo esperado de búsqueda menor a $1.7$.
</div>

## Estrategia

Los árboles binarios tienen muchas propiedades maravillosas. Se prestan muy
bien para aplicar métodos recursivos, y construir soluciones a problemas
grandes a partir de problemas más pequeños.

Tomemos el ejemplo anterior. Sabemos que el BST óptimo se forma con el nodo
2 en la raíz, y el nodo 4 a la derecha del 2. Ese sub-árbol con 4 como raíz
puede verse como un sub-problema del problema más grande, en donde en lugar de
considerar todo el rango $[1 : 5]$ del arreglo, solo se considera el rango
$[3 : 5]$. De hecho, la solución óptima para ese árbol con raíz 4 es:
$$
C_{E4} = (0.1 \times 2) + (0.2 \times 1) + (0.05 \times 2) = 0.5
$$

Obviaremos por ahora el detalle de que las probabilidades de este rango no
suman 1. Lo importante es que la estrategia para resolver el sub-problema
viene a ser la misma que para el problema grande.

¿Puede ver para dónde va esto?<span n>¿Roma?</span> Si está pensando
«programación dinámica», estamos sintonizados. Si aun no está familiarizado
con D.P., ahora sería un buen momento para leer un poco sobre el tema.

Ahora, aquí está la que me parece la observación clave: para un rango
arbitrario $[i:j]$ del arreglo, es posible encontrar el sub-árbol óptimo,
buscando una posición $k$ ($i \le k \le j$), que minimize una suma que de
alguna manera involucre a los valores $(R_{i,k-1}), (p_k), (R_{k+1, j})$, en
donde $R_{a,b}$ denota la solución para el rango $[a:b]$.

Veamos cómo; vamos de vuelta a nuestro ejemplo, y la solución para el
sub-árbol del rango $[3:5]$:

![](bst04.png)

Ahora veamos lo que sucede con ese sub-árbol cuando pasamos a la solución del
problema más grande, del rango $[1:5]$:

![](bst05.png)

¿Se ve el corazón del asunto?

Hemos dicho que $R_{a,b}$ denota la solución del problema para el rango
$[a:b]$, ahora denotemos como $S_{a,b}$ a la suma $p_a, p_{a+1}, \ldots,
p_{b}$. Entonces la solución para $R_{i, j}$, viene de encontrar un $k$ que
minimize la siguiente suma:
$$
(R_{i, k-1} + S_{i, k-1}) + p_k + (R_{k+1, j} + S_{k+1, j})
$$

<div p>
Pregunta

¿Para qué los términos $S$? ¿Qué tienen que ver con los árboles
pintados más arriba? (pista: concéntrese en los números coloreados).
</div>

Esto se traduce fácilmente a una solución de programación dinámica. El caso
base es considerar todos los rangos de longitud 1 ($R_{i, i}$ para cada $i$ de
la lista) y su valor es simplemente $p_i$, y luego se van calculando las
respuestas para los rangos de longitud 2, de longitud 3, etc, hasta llegar al
rango completo de longitud $N$.

## Solución

<div ascii="11709">
Hacia el final, me quedé un buen rato buscando un bug que tenía que ver con la
inicialización de una variable para el caso base.
</div>
