import std/[math]
import imgui
import implot

#------------------
# demo_LogScale() {
#------------------
proc demo_LogScale*() =
  var
    xs {.global.} : array[1001,cdouble]
    ys1{.global.} : array[1001,cdouble]
    ys2{.global.} : array[1001,cdouble]
    ys3{.global.} : array[1001,cdouble]

  for i in 0..<1001:
    xs[i]  = i.float32 * 0.1f
    ys1[i] = sin(xs[i]) + 1
    ys2[i] = log(xs[i],10)
    ys3[i] = pow(10.0, xs[i])

  if ipBeginPlot("Log Plot", ImVec2(x: -1,y: 0)):
    ipSetupAxisScale(ImAxis.X1, ImPlotScale.Log10)
    ipSetupAxesLimits(0.1, 100, 0, 10)
    ipPlotLine("f(x) = x",        addr xs[0], addr xs[0],  1001)
    ipPlotLine("f(x) = sin(x)+1", addr xs[0], addr ys1[0], 1001)
    ipPlotLine("f(x) = log(x)",   addr xs[0], addr ys2[0], 1001)
    ipPlotLine("f(x) = 10^x",     addr xs[0], addr ys3[0], 21)
    ipEndPlot()

