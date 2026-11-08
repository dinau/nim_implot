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
    xs1{.global.}: array[100, cfloat]
    ys1{.global.}: array[100, cfloat]
  for i in 0..<100:
    xs1[i] = i.cfloat * 0.01f
    ys1[i] = xs1[i] + 0.1f * (rand(RAND_MAX).cfloat / RAND_MAX.cfloat)
  var
    xs2{.global.}: array[50, cfloat]
    ys2{.global.}: array[50, cfloat]
  for i in 0..<50:
    xs2[i] = 0.25f + 0.2f * (rand(RAND_MAX).cfloat / RAND_MAX.cfloat)
    ys2[i] = 0.75f + 0.2f * (rand(RAND_MAX).cfloat / RAND_MAX.cfloat)

  if ipBeginPlot("Scatter Plot"):
    ipPlotScatter("Data 1", xs1.ptz, ys1.ptz, 100)
    var col: ImVec4
    ipGetColormapColorNonUDT(addr col, 1)
    var spec = initImPlotSpec()
    spec.marker = ImPlotMarker.Square
    spec.markerSize = 6
    spec.lineColor = col
    spec.fillColor = col
    spec.fillAlpha = 0.25f
    ipPlotScatter_spec("Data 2", xs2.ptz, ys2.ptz, 50, spec)
    ipEndPlot()
