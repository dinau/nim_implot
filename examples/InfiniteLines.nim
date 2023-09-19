import implot

#----------------------
# demo_InfiniteLines()
#----------------------
proc demo_InfiniteLines*() =
  var
    vals{.global.} = [0.25, 0.5, 0.75]
  if ipBeginPlot("##Infinite"):
    ipSetupAxes(nullptr,nullptr,ImPlotAxisFlags.NoInitialFit,ImPlotAxisFlags.NoInitialFit)
    ipPlotInfLines("Vertical",addr vals[0],3)
    ipPlotInfLines("Horizontal",addr vals[0],3,ImPlotInfLinesFlags.Horizontal)
    ipEndPlot()
