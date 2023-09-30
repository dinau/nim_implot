import std/[random]
import imgui
import implot
import utils

#--------------------
# demo_ScatterPlots()
#--------------------
proc demo_ScatterPlots*() =
  randomize(0) # srand(0) : C++
  var
    xs1{.global.}:array[100,cfloat]
    ys1{.global.}:array[100,cfloat]
  for i in 0..<100:
    xs1[i] = i.cfloat * 0.01f
    ys1[i] = xs1[i] + 0.1f * (rand(RAND_MAX).cfloat / RAND_MAX.cfloat)

  var
    xs2{.global.}:array[50,cfloat]
    ys2{.global.}:array[50,cfloat]
  for i in 0..<50:
    xs2[i] = 0.25f + 0.2f * (rand(RAND_MAX).cfloat / RAND_MAX.cfloat)
    ys2[i] = 0.75f + 0.2f * (rand(RAND_MAX).cfloat / RAND_MAX.cfloat)

  if ipBeginPlot("Scatter Plot"):
    ipPlotScatter("Data 1", xs1.ptz, ys1.ptz, 100)
    ipPushStyleVar(ImPlotStyleVar.FillAlpha, 0.25f)
    var fill = ImVec4()
    ipGetColormapColorNonUDT(addr fill,1)
    var weight = ImVec4()
    ipGetColormapColorNonUDT(addr weight,1)
    ipSetNextMarkerStyle(ImPlotMarker.Square    # Marker
                       , 6                      # size: float32
                       , fill                   # fill: ImVec4
                       , IMPLOT_AUTO            # weight: float32
                       , weight)                # outline: ImVec4
    ipPlotScatter("Data 2", xs2.ptz, ys2.ptz, 50)
    ipPopStyleVar()
    ipEndPlot()
