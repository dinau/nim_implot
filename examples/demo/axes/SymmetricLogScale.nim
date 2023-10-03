import std/[math]
import imgui
import implot

#------------------------------
# demo_Axis_SymmetricLogScale()
#------------------------------
proc demo_Axes_SymmetricLogScale*() =
  var
    xs {.global.}:array[1001,cdouble]
    ys1{.global.}:array[1001,cdouble]
    ys2{.global.}:array[1001,cdouble]

  for i in 0..<1001:
    xs[i]  = i.cfloat * 0.1f - 50.cfloat
    ys1[i] = sin(xs[i])
    ys2[i] = i.cfloat * 0.002 - 1.cfloat
  if ipBeginPlot("SymLog Plot", ImVec2(x: -1,y: 0)):
    ipSetupAxisScale(ImAxis.X1, ImPlotScale.SymLog)
    ipPlotLine("f(x) = a*x+b",xs.ptz,ys2.ptz,1001)
    ipPlotLine("f(x) = sin(x)",xs.ptz,ys1.ptz,1001)
    ipEndPlot()
