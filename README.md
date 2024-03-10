# Proyecto 1 Arquitectura de Computadores

## Dirección al proyecto github
- https://github.com/fabianchs/arqui_proy1

## Descripción del diseño de software realizado en el proyecto

- En primera instancia, se realizó la creación del código para la lectura del archivo .txt. Esto con el fin de asegurar la manipulación de los datos dentro del programa. Posteriomente se investigó sobre la manipulación de memoria, algoritmos de sorting, e impresiones sobre línea de comandos.
- El proceso dispuesto para este proyecto implica la lectura de los archivos de texto, posteriormente leer los txt de requerimientos, crear las funciones respectivas a cada tipo de ordenamiento, al cumplir los requisitos de manejo de memoria, se crea el histograma con los requerimientos dispuestos para este proyecto.

### ¿Cuáles fueron los principales retos a resolver y cómo se resolvieron?

 - Realización del proyecto de manera simultánea a los primeros pasos en el lenguaje de programación
    - La manera de resolver este factor se realiza mediante la práctica constante y la comprensión del lenguaje de programación, además del seguimiento correcto de instrucciones dentro del proyecto. En este caso el tiempo dispuesto paralelamente con la solución del proyecto no fue suficiente para subsanar los conocimientos necesarios para este proyecto, por lo cual no fue entregado de manera completa, la capacidad de abstracción para el lenguaje de programación ensamblador requiere de práctica y un verdadero conocimiento del manejo relacionado a ciclos, manejo de variables, registros, contadores, lógica booleana, jumps, el funcionamiento de cada tipo de registro presente en ensamblador. Del mismo modo se requiere un seguimiento o una ruta para comprender a fondo las jerarquías en ensamblador.
- Un reto dentro de la comprensión de ensamblador es la utilización de un código de ejemplo presentado en [1] para leer un archivo txt, el cual tiene en su primera línea `include linux64.inc`, de este modo la línea de comandos encontró el error `unable to open include file`, a pesar de estar presente en el instructivo, este no logró funcionar. Se utilizó un total de dos horas en la búsqueda para la solución de este error, la propuesta inicial fue buscar el archivo en las carpetas fuente de linux,  simulando la búsqueda de una biblioteca tal como se hace en otros lenguajes de programación, del mismo modo se consultó material bibliográfico relacionado a este error. La solución fue crear el archivo directamente en la carpeta de diseño con los parámetros vistos en un video tutorial y página web [2].

### ¿Cuáles mejoras se sugieren para el programa y cómo se harían?
 - El proyecto requiere la implementación de las funciones de sorting a la vez que de manipulación de memoria. A su vez implica la creación del histograma con los respectivos requerimientos dispuestos en el instructivo.

### Conclusiones respecto a los ensambladores

- Es notoria la diferencia entre líneas de código que requiere un código realizado en ensamblador en comparación con otros lenguajes de mayor nivel, la lectura de un archivo txt en lenguajes como python requieren de pocas instrucciones, en comparación con la cantidad de líneas que se debe disponer en ensamblador.

### Referencias Bibliográficas

[1] R. García. "Guía de inicio: Lenguaje ensamblador x86_64 para Linux Parte 1: Ensamblado del primer programa". Instituto Tecnológico de Costa Rica.

[2] Kupala. "x86_64 Linux Assembly #12 - Reading Files", https://www.youtube.com/watch?v=BljOGzRP_Ws  
