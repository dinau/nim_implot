import std/[random, sugar, sequtils]
import implot

#-------------------
# demo_SimplePlot()
#-------------------
proc demo_SimplePlot*() =
  var
    bar_data{.global.}:seq[cint]
    x_data{.global.}:seq[cint]
    y_data{.global.}:seq[cint]
  once:
    discard initRand()
    bar_data = collect(for i in 0..10: rand(100).cint)
    x_data = collect(for i in 0..10: i.cint)
    y_data = x_data.mapIt((it * it).cint) # y = x^2

  if ipBeginPlot("My Plot"):
    defer: ipEndPlot()
    ipPlotBars("My Bar Plot", bar_data.ptz, bar_data.len)
    ipPlotLine("My Line Plot", x_data.ptz, y_data.ptz, xdata.len)
