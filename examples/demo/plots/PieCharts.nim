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
  if data1[0] + data1[1] + data1[2] + data1[3] < 1:
    igSameLine()
    CHECKBOX_FLAG(flags, ImPlotPieChartFlags.Normalize)

  if ipBeginPlot("##Pie1", ImVec2(x: 250, y: 250) , ImPlotFlags.Equal or ImPlotFlags.NoMouseText):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, 1, 0, 1)
    ipPlotPieChart(labels1.ptz
      , data1.ptz  # float32
      , 4              # int
      , 0.5, 0.5       # x,y:cdouble
      , 0.4            # radius: cdouble
      , "%.2f".cstring # cstring
      , 90             # angle: cdouble
      , flags)         # ImPlotPieChartFlags
    ipEndPlot()
  igSameLine()

  var labels2 = ["A".cstring, "B", "C", "D", "E"]
  var data2{.global.} = [1.int32, 1, 2, 3, 5]

  ipPushColormap(ImPlotColormap.Pastel)
  if ipBeginPlot("##Pie2", ImVec2(x: 250, y: 250) , ImPlotFlags.Equal or ImPlotFlags.NoMouseText):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, 1, 0, 1)
    ipPlotPieChart(labels2.ptz, data2.ptz, 5, 0.5, 0.5, 0.4, "%.0f", 180, flags)
    ipEndPlot()
  ipPopColormap()
