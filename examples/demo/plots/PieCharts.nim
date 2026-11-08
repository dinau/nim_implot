import imgui
import implot
import utils

#-----------------
# demo_PieCharts()
#-----------------
proc demo_PieCharts*() =
  var labels1 = ["Frogs".cstring, "Hogs", "Dogs", "Logs"]
  var
    data1{.global.} = [0.15.float32, 0.30, 0.2, 0.05]
    flags{.global.} = ImPlotPieChartFlags.None

  igSetNextItemWidth(250)
  igDragFloat4("Values".cstring, data1, 0.01'f32, 0, 1)
  CHECKBOX_FLAG(flags, ImPlotPieChartFlags.Normalize)
  CHECKBOX_FLAG(flags, ImPlotPieChartFlags.IgnoreHidden)
  CHECKBOX_FLAG(flags, ImPlotPieChartFlags.Exploding)
  CHECKBOX_FLAG(flags, ImPlotPieChartFlags.NoSliceBorder)

  if ipBeginPlot("##Pie1", ImVec2(x: 250, y: 250) , ImPlotFlags.Equal or ImPlotFlags.NoMouseText):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, 1, 0, 1)
    var spec = initImPlotSpec()
    spec.flags = cast[ImPlotItemFlags](flags)
    ipPlotPieChart_spec(labels1.ptz, data1.ptz, 4, 0.5, 0.5, 0.4, "%.2f".cstring, 90, spec)
    ipEndPlot()
  igSameLine()

  var labels2 = ["A".cstring, "B", "C", "D", "E"]
  var data2{.global.} = [1.int32, 1, 2, 3, 5]

  ipPushColormap(ImPlotColormap.Pastel)
  if ipBeginPlot("##Pie2", ImVec2(x: 250, y: 250) , ImPlotFlags.Equal or ImPlotFlags.NoMouseText):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, 1, 0, 1)
    var spec = initImPlotSpec()
    spec.flags = cast[ImPlotItemFlags](flags)
    ipPlotPieChart_spec(labels2.ptz, data2.ptz, 5, 0.5, 0.5, 0.4, "%.0f".cstring, 180, spec)
    ipEndPlot()
  ipPopColormap()
