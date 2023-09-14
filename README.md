<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Nim ImPlot binding](#nim-implot-binding)
- [Generating ImPlot binding](#generating-implot-binding)
- [Runing test application](#runing-test-application)
- [Compiling application](#compiling-application)
- [Development](#development)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


### Nim ImPlot binding

---

Notice: This project is highly under constructions at this moment.

1. This project uses the modified generator that derived from the achievement of [Nimgl/imgui](https://github.com/nimgl/imgui) and [nimgl-imgui](https://github.com/daniel-j/nimgl-imgui)(forked).
1. This project also uses [nim-imgui (ImGui v1.89.9)](https://github.com/dinau/nimgl-imgui) derived from [Nimgl/imgui](https://github.com/nimgl/imgui) and [nimgl-imgui](https://github.com/daniel-j/nimgl-imgui)(forked).

### Generating ImPlot binding  

---

```bash
git clone --recursive https://github.com/dinau/nim_implot.git
cd nim_implot
nimble gen
```

Genarated file: [src/implot.nim](src/implot.nim)

### Runing test application

---

```bash
pwd 
nim_implot
nimble install
nimble test
```

Test source: [tests/imPlotTest.nim](tests/imPlotTest.nim)

![alt](img/nim_implot-demo.png)


### Compiling application

---

It must be used **cpp** backend at compilation for example,

```sh
pwd
nim_implot
cd tests
nim cpp -r imPlotTest.nim 
```

**C** backend is no supported.

### Development

---

It is currently being developed and tested on

* Windows 10
* Debian 12 Bookworm  

   ```sh
   $ sudo apt install xorg-dev libopengl-dev libgl1-mesa-dev
   ```




