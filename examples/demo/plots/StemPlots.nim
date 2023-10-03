import implot
import std/[math]

#-----------------
# Demo_StemPlots*()
#-----------------
proc demo_StemPlots*() =
  var
    xs{.global.}:array[51,double]
    ys1{.global.}:array[51,double]
    ys2{.global.}:array[51,double]
  for i in 0..<51:
    xs[i] = i.double * 0.02
    ys1[i] = 1.0 + 0.5 * sin(25*xs[i])*cos(2*xs[i])
    ys2[i] = 0.5 + 0.25  * sin(10*xs[i]) * sin(xs[i])
  if ipBeginPlot("Stem Plots"):
      ipSetupAxisLimits(ImAxis.X1,0,1.0)
      ipSetupAxisLimits(ImAxis.Y1,0,1.6)
      ipPlotStems("Stems 1", xs.ptz, ys1.ptz,51)
      ipSetNextMarkerStyle(ImPlotMarker.Circle)
      ipPlotStems("Stems 2", xs.ptz, ys2.ptz,51)
      ipEndPlot()
