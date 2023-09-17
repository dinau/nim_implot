<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Nim ImPlot binding](#nim-implot-binding)
- [Direct install from Web](#direct-install-from-web)
- [Runing test application](#runing-test-application)
- [Compiling application](#compiling-application)
- [Generating ImPlot binding](#generating-implot-binding)
- [Development](#development)
- [Tools info](#tools-info)
- [Example gallary written in Nim language](#example-gallary-written-in-nim-language)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


### Nim ImPlot binding

---

Notice: This project is highly under constructions at this moment.

1. This project uses the modified generator that derived from the achievement of [Nimgl/imgui](https://github.com/nimgl/imgui) and [nimgl-imgui](https://github.com/daniel-j/nimgl-imgui)(forked).
1. This project also uses [nim-imgui (ImGui v1.89.9)](https://github.com/dinau/nimgl-imgui) derived from [Nimgl/imgui](https://github.com/nimgl/imgui) and [nimgl-imgui](https://github.com/daniel-j/nimgl-imgui)(forked).

### Direct install from Web

---

```sh
nimble install https://github.com/dinau/nim_implot
```

### Runing test application

---

```bash
pwd 
nim_implot
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

### Generating ImPlot binding  

---

```bash
git clone --recursive https://github.com/dinau/nim_implot.git
cd nim_implot
nimble gen
```

Genarated file: [src/implot.nim](src/implot.nim)


### Development

---

It is currently being developed and tested on

* Windows 10
* Debian 12 Bookworm  

   ```sh
   $ sudo apt install xorg-dev libopengl-dev libgl1-mesa-dev
   ```

### Tools info

---
 
- Windows10
   - Nim Compiler Version 1.6.14 
   - gcc.exe (Rev2, Built by MSYS2 project) 13.2.0
   - git version 2.41.0.windows.3
- Debian 12 Bookworm 
   - Nim Compiler Version 1.6.14 
   - gcc (Debian 12.2.0-14) 12.2.0
   - git version 2.39.2

### Example gallery written in Nim language

---

- [DigitalPlots.nim](examples/DigitalPlots.nim)  
 ![DigitalPlots.png](img/DigitalPlots.png)  
- [HeatMaps.nim](examples/HeatMaps.nim)  
 ![HeatMaps.png](img/HeatMaps.png)  
- [HistoGram.nim](examples/HistoGram.nim)  
 ![HistoGram.png](img/HistoGram.png)  
- [ImPlotDemo.nim](examples/ImPlotDemo.nim)  
 ![ImPlotDemo.png](img/ImPlotDemo.png)  
- [LinePlots.nim](examples/LinePlots.nim)  
 ![LinePlots.png](img/LinePlots.png)  
- [PieCharts.nim](examples/PieCharts.nim)  
 ![PieCharts.png](img/PieCharts.png)  
- [SimpleImGui.nim](examples/SimpleImGui.nim)  
 ![SimpleImGui.png](img/SimpleImGui.png)  
- [SimplePlots.nim](examples/SimplePlots.nim)  
 ![SimplePlots.png](img/SimplePlots.png)  
- [StairstepPlots.nim](examples/StairstepPlots.nim)  
 ![StairstepPlots.png](img/StairstepPlots.png)  
- [StemPlots.nim](examples/StemPlots.nim)  
 ![StemPlots.png](img/StemPlots.png)  
