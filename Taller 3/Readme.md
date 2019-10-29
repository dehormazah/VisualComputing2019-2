# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

## Integrantes

| Integrante                      | github nick |
|---------------------------------|-------------|
| David Eduardo Hormaza           |dehormazah   |
| Juliana Niño                    |JulianaNino  |
| Diego Chacón                    |dieguischa   |


## Discusión

* Se emplearon las coordenadas baricéntricas y una edge function a partir de las referencias encontradas [aquí](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage) para rasterizar el triángulo y sombrear su superficie según los colores de sus vértices.
* Para la implementación del anti-aliasing se empleó la estrategia de división de los pixeles en subpixeles a partir del método descrito [aquí](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation).
