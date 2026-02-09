# test-precompute-quarto

This is an example of a precomputed vignette in Quarto

``` r
library("ggplot2")

ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density))
```

![A plot with a long caption here](./plot_quarto-1.png)

A plot with a long caption here

See here some text:

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer
efficitur massa risus, eu tincidunt magna finibus id. Donec quis
tincidunt est, sed commodo leo. Donec nec varius lacus. Mauris tempor
nisi ipsum, id tincidunt ipsum porta vel. Sed blandit est sit amet
bibendum egestas. Integer facilisis tortor viverra pellentesque
efficitur. Sed non magna placerat, volutpat felis ac, iaculis mauris.
Morbi tempor nulla vel enim tristique tristique. Nam sed purus aliquet,
facilisis ligula vitae, accumsan metus. Integer porta nisi iaculis massa
consequat, quis mollis tellus ultricies. Vestibulum vehicula lacinia
eros, eu aliquam neque. Pellentesque hendrerit metus et nulla tristique,
non sollicitudin odio mollis. Mauris vel eros vitae ipsum viverra
sollicitudin imperdiet sed nibh. Nullam vel metus luctus, maximus elit
eu, feugiat lectus.

Fusce ac massa sed lorem convallis suscipit sed vitae neque. Duis
condimentum ante dolor, congue dictum ligula ullamcorper vitae. Praesent
eros neque, dictum sit amet venenatis et, suscipit vitae diam. Praesent
venenatis, dui sit amet euismod luctus, dolor velit tempus neque, at
elementum ante sapien eget nisi. Fusce at tempus orci, et porttitor
elit. Donec dapibus enim sem, at interdum ligula dapibus quis. In sit
amet commodo arcu. Aliquam sit amet porta eros, at porta felis. Nullam
consectetur hendrerit elit nec pulvinar. Praesent nec imperdiet nulla,
sed pellentesque mi. Donec facilisis orci est, vitae aliquam tortor
elementum id. Nunc nec porta dolor, id aliquet sem. Pellentesque ac
elementum nisl. Donec faucibus arcu arcu, nec semper sapien interdum id.
Curabitur a sollicitudin tortor.

Mauris a nisi metus. Sed sollicitudin, nisi et condimentum facilisis,
elit neque pretium mauris, et varius erat nulla vitae purus. Nullam sed
tellus ac nulla laoreet cursus. In ultricies, leo ut pharetra egestas,
purus enim placerat turpis, in gravida leo nisi non ligula. Aenean
blandit ligula sit amet diam posuere, vestibulum euismod tortor dapibus.
Pellentesque ligula purus, condimentum nec luctus vel, feugiat id leo.
Quisque viverra a erat ac scelerisque. Nunc bibendum ac neque et congue.

Vestibulum gravida, elit sit amet molestie luctus, enim arcu fringilla
odio, at malesuada mauris purus sed metus. Nunc lorem tortor, fringilla
quis maximus vel, aliquet ut orci. Aliquam pulvinar sodales magna,
consequat fermentum arcu consectetur non. Donec et ligula leo.
Vestibulum porttitor porttitor est id mattis. Phasellus non vulputate
ante. Aenean maximus orci orci, et dignissim urna finibus in. Cras
tortor est, feugiat et urna quis, interdum sodales metus. Pellentesque
neque est, aliquet volutpat condimentum ac, gravida in mi.

In hac habitasse platea dictumst. In hac habitasse platea dictumst.
Maecenas finibus, enim ac tristique ornare, velit turpis gravida erat,
sed mattis libero elit vel dolor. Phasellus sem tortor, mattis id
efficitur eget, tristique ut odio. Sed bibendum vehicula lacus, non
elementum magna tempor a. Phasellus id est pulvinar, porta arcu vel,
venenatis urna. Suspendisse quis consequat arcu. Quisque auctor lacus in
nisl tristique volutpat. Suspendisse non placerat leo. Praesent
pellentesque velit at lectus malesuada, at convallis quam aliquam.
Nullam sit amet sem risus. Sed maximus consectetur dui at lacinia.
Suspendisse posuere accumsan vestibulum. Maecenas vel sem placerat
mauris imperdiet placerat nec vel erat. Duis accumsan felis sit amet
purus efficitur, et lobortis urna feugiat. Curabitur tincidunt lectus
eget enim efficitur, quis accumsan neque luctus.

Generated 5 paragraphs, 523 words, 3547 bytes of Lorem ipsum dolor sit
amet, consectetur adipiscing elit. Integer efficitur massa risus, eu
tincidunt magna finibus id. Donec quis tincidunt est, sed commodo leo.
Donec nec varius lacus. Mauris tempor nisi ipsum, id tincidunt ipsum
porta vel. Sed blandit est sit amet bibendum egestas. Integer facilisis
tortor viverra pellentesque efficitur. Sed non magna placerat, volutpat
felis ac, iaculis mauris. Morbi tempor nulla vel enim tristique
tristique. Nam sed purus aliquet, facilisis ligula vitae, accumsan
metus. Integer porta nisi iaculis massa consequat, quis mollis tellus
ultricies. Vestibulum vehicula lacinia eros, eu aliquam neque.
Pellentesque hendrerit metus et nulla tristique, non sollicitudin odio
mollis. Mauris vel eros vitae ipsum viverra sollicitudin imperdiet sed
nibh. Nullam vel metus luctus, maximus elit eu, feugiat lectus.

Fusce ac massa sed lorem convallis suscipit sed vitae neque. Duis
condimentum ante dolor, congue dictum ligula ullamcorper vitae. Praesent
eros neque, dictum sit amet venenatis et, suscipit vitae diam. Praesent
venenatis, dui sit amet euismod luctus, dolor velit tempus neque, at
elementum ante sapien eget nisi. Fusce at tempus orci, et porttitor
elit. Donec dapibus enim sem, at interdum ligula dapibus quis. In sit
amet commodo arcu. Aliquam sit amet porta eros, at porta felis. Nullam
consectetur hendrerit elit nec pulvinar. Praesent nec imperdiet nulla,
sed pellentesque mi. Donec facilisis orci est, vitae aliquam tortor
elementum id. Nunc nec porta dolor, id aliquet sem. Pellentesque ac
elementum nisl. Donec faucibus arcu arcu, nec semper sapien interdum id.
Curabitur a sollicitudin tortor.

Mauris a nisi metus. Sed sollicitudin, nisi et condimentum facilisis,
elit neque pretium mauris, et varius erat nulla vitae purus. Nullam sed
tellus ac nulla laoreet cursus. In ultricies, leo ut pharetra egestas,
purus enim placerat turpis, in gravida leo nisi non ligula. Aenean
blandit ligula sit amet diam posuere, vestibulum euismod tortor dapibus.
Pellentesque ligula purus, condimentum nec luctus vel, feugiat id leo.
Quisque viverra a erat ac scelerisque. Nunc bibendum ac neque et congue.

Vestibulum gravida, elit sit amet molestie luctus, enim arcu fringilla
odio, at malesuada mauris purus sed metus. Nunc lorem tortor, fringilla
quis maximus vel, aliquet ut orci. Aliquam pulvinar sodales magna,
consequat fermentum arcu consectetur non. Donec et ligula leo.
Vestibulum porttitor porttitor est id mattis. Phasellus non vulputate
ante. Aenean maximus orci orci, et dignissim urna finibus in. Cras
tortor est, feugiat et urna quis, interdum sodales metus. Pellentesque
neque est, aliquet volutpat condimentum ac, gravida in mi.

In hac habitasse platea dictumst. In hac habitasse platea dictumst.
Maecenas finibus, enim ac tristique ornare, velit turpis gravida erat,
sed mattis libero elit vel dolor. Phasellus sem tortor, mattis id
efficitur eget, tristique ut odio. Sed bibendum vehicula lacus, non
elementum magna tempor a. Phasellus id est pulvinar, porta arcu vel,
venenatis urna. Suspendisse quis consequat arcu. Quisque auctor lacus in
nisl tristique volutpat. Suspendisse non placerat leo. Praesent
pellentesque velit at lectus malesuada, at convallis quam aliquam.
Nullam sit amet sem risus. Sed maximus consectetur dui at lacinia.
Suspendisse posuere accumsan vestibulum. Maecenas vel sem placerat
mauris imperdiet placerat nec vel erat. Duis accumsan felis sit amet
purus efficitur, et lobortis urna feugiat. Curabitur tincidunt lectus
eget enim efficitur, quis accumsan neque luctus.

**Generated 5 paragraphs, 523 words, 3547 bytes of [Lorem
Ipsum](https://www.lipsum.com/)**.
