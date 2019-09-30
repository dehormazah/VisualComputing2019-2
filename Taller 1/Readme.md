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

Completar la tabla:

| Integrante                      | github nick |
|---------------------------------|-------------|
| David Eduardo Hormaza           |dehormazah   |
| Juliana Niño                    |JulianaNino  |
| Diego Chacón                    |dieguischa   |

## Discusión

* Se implementaron cada una de las tareas propuestas para este taller. 
* La conversión a escala de grises (tanto mediante promedio rgb como por el cálculo de la luminosidad de los pixeles "luma") se implementó en el archivo [gray_scale.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/gray_scale/gray_scale.pde)
* La aplicación de máscaras de convolución a imágenes se implementó en el archivo [convolution_masks.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/convolution_masks/convolution_masks.pde)
* El despliegue del histograma y la segmentación de imágenes a partir del mismo se implementó en el archivo [histogram_and_image_segmentation.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/histogram_and_image_segmentation/histogram_and_image_segmentation.pde)
* La medición de la eficiencia computacional al hacer operaciones (conversión a escala de grises y aplicación de máscaras de convolución) sobre videos se implementó en el archivo [videos.pde](https://github.com/dehormazah/VisualComputing2019-2/blob/master/Taller%201/videos/videos.pde)

###Observaciones sobre el código**

* **Conversión a escala de grises**:
- Por promedio RGB: En este caso se empleó la fórmula: 

```
color(int((red+green+blue)/3)
```
donde red, green y blue son las variables donde se almacenan los valores de rojo, verde y azul de cada uno de los pixeles de la imagen analizada, a las cuales se les calcula su promedio y se extrae el color (en escala de grises, esto es un valor entre 0 y 255 donde 0 es el negro "absoluto" y 255 el blanco "absoluto"). 

- Por cálculo de la luminosidad (luma): En este caso se empleó la fórmula: 

```
color((0.8126 * red) + (0.9952 *green) + (0.9992 * blue))
```
a partir de la información encontrada [aquí](https://en.wikipedia.org/wiki/Luma_(video)).
