import std/[math]
import imgui
import implot

#------------------
# demo_LinePlots()
#------------------
proc demo_LinePlots*() =
  var
    xs1{.global.}: array[1001, float]
    ys1{.global.}: array[1001, float]
  for i in 0..<1001:
    xs1[i] = i.float * 0.001f
    ys1[i] = 0.5f + 0.5f * sin(50 * (xs1[i] + igGetTime().float / 10))
  var
    xs2{.global.}: array[20, float64]
    ys2{.global.}: array[20, float64]
  for i in 0..<20:
    xs2[i] = i.float * 1/19.0f
    ys2[i] = xs2[i] * xs2[i]
  if ipBeginPlot("Line Plots"):
    defer: ipEndPlot()
    ipSetupAxes("x", "y")
    ipPlotLine("f(x)", addr xs1[0], addr ys1[0], 1001)
    ipSetNextMarkerStyle(Circle)
    ipPlotLine("g(x)", addr xs2[0], addr ys2[0], 20, Segments)

