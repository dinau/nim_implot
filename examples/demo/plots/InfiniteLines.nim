import implot

#----------------------
# demo_InfiniteLines()
#----------------------
proc demo_InfiniteLines*() =
  var
    vals{.global.} = [0.25, 0.5, 0.75]
  if ipBeginPlot("##Infinite"):
    ipSetupAxes(nullptr,nullptr,ImPlotAxisFlags.NoInitialFit,ImPlotAxisFlags.NoInitialFit)
    ipPlotInfLines("Vertical",vals.ptz,3)
    ipPlotInfLines("Horizontal",vals.ptz,3,ImPlotInfLinesFlags.Horizontal)
    ipEndPlot()
