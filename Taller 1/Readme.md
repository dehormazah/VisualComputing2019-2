# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

## Integrantes

| Integrante                      | github nick |
|---------------------------------|-------------|
| David Eduardo Hormaza           |dehormazah   |
| Juliana Niño                    |JulianaNino  |
| Diego Chacón                    |dieguischa   |

## Discusión

* Se implementaron cada una de las tareas propuestas para este taller. 
* La conversión a escala de grises (tanto mediante promedio rgb como por el cálculo de la luminosidad de los pixeles "luma") se implementó en el archivo [gray_scale.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/gray_scale/gray_scale.pde).
* La aplicación de máscaras de convolución a imágenes se implementó en el archivo [convolution_masks.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/convolution_masks/convolution_masks.pde).
* El despliegue del histograma y la segmentación de imágenes a partir del mismo se implementó en el archivo [histogram_and_image_segmentation.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/histogram_and_image_segmentation/histogram_and_image_segmentation.pde).
* La medición de la eficiencia computacional al hacer operaciones (conversión a escala de grises y aplicación de máscaras de convolución) sobre videos se implementó en el archivo [videos.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/videos/videos.pde).

### Observaciones sobre el código

#### Conversión a escala de grises:
- Por promedio RGB: En este caso se empleó la fórmula: 

```
color(int((red+green+blue)/3)
```
donde red, green y blue son las variables donde se almacenan los valores de rojo, verde y azul de cada uno de los pixeles de la imagen analizada, a las cuales se les calcula su promedio y se extrae el color en escala de grises (esto es un valor entre 0 y 255 donde 0 es el negro "absoluto" y 255 el blanco "absoluto"). 

- Por cálculo de la luminosidad (luma): En este caso se empleó la fórmula:
``` 
color((0.8126 * red) + (0.9952 *green) + (0.9992 * blue))
```
a partir de la información encontrada [aquí](https://en.wikipedia.org/wiki/Luma_(video)).

#### Aplicación de máscaras de convolución sobre imágenes:
- Se aplicaron máscaras de convolución para obtener efectos de enfoque (sharpen), desenfoque (blur) y detección de bordes (edges) a partir del uso de kernels (matrices) que al ser operadas con los pixeles de las imágenes producen los efectos nombrados anteriormente. Se usó como soporte la información encontrada [aquí](https://en.wikipedia.org/wiki/Kernel_(image_processing)).

#### Despliegue de histograma y segmentación de imágenes:
- Se construyó el histograma de escala de grises (valores entre 0 y 255) para un conjunto de imágenes, se dividió en 4 grupos (cada uno de 64 valores posibles) y a cada grupo se le asignó un color distinto para la segmentación de la imagen en regiones de acuerdo al valor nuevo que adquiere cada pixel en la imagen resultante según la distribución del valor original en el histograma realizado.

#### Medición de la eficiencia computacional:
- Se hizo conversión a escala de grises (mediante promedio rgb y luma) de cada uno de los frames de un video y también se aplicaron máscaras de convolución (las mismas aplicadas a las imágenes) para medir la cantidad de fps (frames por segundo) que podía ser procesada en un instante dado.

- Partiendo de un valor inicial de ```frameRate = 100``` (es decir, 100 frames por segundo), al hacer conversión a escala de grises dicho valor se mantiene entre los 80 y 90 fps, mientras que al aplicar alguna de las máscaras de convolución baja y se mantiene en el orden de los 40 fps.

- Lo anterior permite concluir que al hacer operaciones mucho más complejas para aplicar las máscaras de convolución la cantidad de fps que pueden ser procesados disminuye considerablemente, mientras que al realizar operaciones sencillas como las necesarias para la conversión a escala de grises la cantidad de fps es muy cercana a la obtenida con una reproducción corriente del video (sin aplicar operación alguna).
