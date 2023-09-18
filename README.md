<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Nim ImPlot binding](#nim-implot-binding)
- [Direct install from Web](#direct-install-from-web)
- [Runing test application](#runing-test-application)
- [Compiling application](#compiling-application)
- [Generating ImPlot binding for development](#generating-implot-binding-for-development)
- [Development](#development)
- [Tools info](#tools-info)
- [Example gallery written in Nim language](#example-gallery-written-in-nim-language)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


### Nim ImPlot binding

---

Note: This project is highly under constructions at this moment.

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
git clone --recursive https://github.com/dinau/nim_implot
cd nim_implot
nimble test
```

Test source: [examples/ImPlotDemo.nim](examples/ImPlotDemo.nim)

### Compiling application

---

It must be used **cpp** backend at compilation for example,

```sh
pwd
nim_implot
cd examples
nim cpp -r ImPlotDemo.nim 
```

**Note**: **C** backend is not supported.

### Generating ImPlot binding for development

---

```bash
pwd
nim_implot
nimble gen
```

Genarated file: [src/implot.nim](src/implot.nim)


### Development

---

It is currently being developed and tested on

* Windows 10
* (Debian 12 Bookworm)  

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

- [LinePlots.nim](examples/LinePlots.nim)  
![LinePlots.png](img/LinePlots.png)  

- [FilledLinePlots.nim](examples/FilledLinePlots.nim)  
![FilledLinePlots.png](img/FilledLinePlots.png)  

- [ShadedPlots.nim](examples/ShadedPlots.nim)  
![ShadedPlots.png](img/ShadedPlots.png)  

- [ScatterPlots.nim](examples/ScatterPlots.nim)  
![ScatterPlots.png](img/ScatterPlots.png)  

- [RealtimePlots.nim](examples/RealtimePlots.nim)  
![RealtimePlots.png](img/RealtimePlots.png)  

- [StairstepPlots.nim](examples/StairstepPlots.nim)  
![StairstepPlots.png](img/StairstepPlots.png)  

- [BarStacks.nim](examples/BarStacks.nim)  
![BarStacks.png](img/BarStacks.png)  

- [StemPlots.nim](examples/StemPlots.nim)  
![StemPlots.png](img/StemPlots.png)  

- [PieCharts.nim](examples/PieCharts.nim)  
![PieCharts.png](img/PieCharts.png)  

- [HeatMaps.nim](examples/HeatMaps.nim)  
![HeatMaps.png](img/HeatMaps.png)  

- [Histogram.nim](examples/Histogram.nim)  
![Histogram.png](img/Histogram.png)  

- [DigitalPlots.nim](examples/DigitalPlots.nim)  
![DigitalPlots.png](img/DigitalPlots.png)  

- [SimplePlots.nim](examples/SimplePlots.nim)  
![SimplePlots.png](img/SimplePlots.png)  





