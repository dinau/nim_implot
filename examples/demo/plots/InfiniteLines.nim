import imgui
import implot

#----------------------
# demo_InfiniteLines()
#----------------------
proc demo_InfiniteLines*() =
  var
    vals{.global.} = [0.25, 0.5, 0.75]
    labels = ["x = 0.25".cstring, "x = 0.50", "x = 0.75"]
  igBulletText("Toggle \"Vertical\" in the legend: its text labels hide with it.")
  if ipBeginPlot("##Infinite"):
    ipSetupAxes(nullptr,nullptr,ImPlotAxisFlags.NoInitialFit,ImPlotAxisFlags.NoInitialFit)
    ipPlotInfLines("Vertical",vals.ptz,3)
    # PlotText is not a legend item, so skip it when its lines are hidden
    if not ipIsLastItemHidden():
      for i in 0..<3:
        var spec = initImPlotSpec()
        spec.flags = cast[ImPlotItemFlags](ImPlotItemFlags.NoFit)
        ipPlotText_spec(labels[i], vals[i], 0.9, ImVec2(x: 36, y: 0), spec)
    var spec = initImPlotSpec()
    spec.flags = cast[ImPlotItemFlags](ImPlotInfLinesFlags.Horizontal)
    ipPlotInfLines_spec("Horizontal",vals.ptz,3,spec)
    ipEndPlot()
