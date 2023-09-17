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
  igDragFloat4("Values", data1, 0.01f, 0, 1)
  if data1[0] + data1[1] + data1[2] + data1[3] < 1:
    igSameLine()
    CHECKBOX_FLAG(flags, ImPlotPieChartFlags.Normalize)

  if ipBeginPlot("##Pie1", ImVec2(x: 250, y: 250)
    , (ImPlotFlags.Equal.int32 or ImPlotFlags.NoMouseText.int32).ImPlotFlags):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, 1, 0, 1)
    ipPlotPieChart(addr labels1[0]
      , addr data1[0]  # float32
      , 4              # int
      , 0.5, 0.5       # x,y:cfloat64
      , 0.4            # radius: cfloat64
      , "%.2f".cstring # cstring
      , 90             # angle: cfloat64
      , flags)         # ImPlotPieChartFlags
    ipEndPlot()
  igSameLine()

  var labels2 = ["A".cstring, "B", "C", "D", "E"]
  var data2{.global.} = [1.int32, 1, 2, 3, 5]

  ipPushColormap(ImPlotColormap.Pastel)
  if ipBeginPlot("##Pie2", ImVec2(x: 250, y: 250)
    , (ImPlotFlags.Equal.int32 or ImPlotFlags.NoMouseText.int32).ImPlotFlags):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, 1, 0, 1)
    ipPlotPieChart(addr labels2[0], addr data2[0], 5, 0.5, 0.5, 0.4, "%.0f", 180, flags)
    ipEndPlot()
  ipPopColormap()
