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
    ipPlotBars("My Bar Plot", addr bar_data[0], bar_data.len)
    ipPlotLine("My Line Plot", addr x_data[0], addr y_data[0], xdata.len)
