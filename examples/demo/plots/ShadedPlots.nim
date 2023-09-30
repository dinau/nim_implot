import std/[random,math]
import imgui
import implot
import utils

#----------------------
# demo_ShadedPlots()
#----------------------
proc demo_ShadedPlots*() =
  var
    xs{.global.}:  array[1001, cfloat]
    ys{.global.}:  array[1001, cfloat]
    ys1{.global.}: array[1001, cfloat]
    ys2{.global.}: array[1001, cfloat]
    ys3{.global.}: array[1001, cfloat]
    ys4{.global.}: array[1001, cfloat]

  randomize(0) # srand(0) : C++
  for  i in 0..<1001:
    xs[i]  = i.cfloat * 0.001f
    ys[i]  = 0.25f + 0.25f * sin(25 * xs[i]) * sin(5 * xs[i]) + RandomRange(-0.01f, 0.01f)
    ys1[i] = ys[i] + RandomRange(0.1f, 0.12f)
    ys2[i] = ys[i] - RandomRange(0.1f, 0.12f)
    ys3[i] = 0.75f + 0.2f * sin(25 * xs[i])
    ys4[i] = 0.75f + 0.1f * cos(25 * xs[i])

  var alpha{.global.} = 0.25.cfloat
  igDragFloat("Alpha",addr alpha,0.01f,0,1)

  if ipBeginPlot("Shaded Plots"):
    ipPushStyleVar(ImPlotStyleVar.FillAlpha, alpha)
    ipPlotShaded("Uncertain Data",xs.ptz, ys1.ptz, ys2.ptz,1001)
    ipPlotLine("Uncertain Data"  ,xs.ptz, ys.ptz, 1001)
    ipPlotShaded("Overlapping"   ,xs.ptz, ys3.ptz,ys4.ptz,1001)
    ipPlotLine("Overlapping"     ,xs.ptz, ys3.ptz,1001)
    ipPlotLine("Overlapping"     ,xs.ptz, ys4.ptz,1001)
    ipPopStyleVar()
    ipEndPlot()
