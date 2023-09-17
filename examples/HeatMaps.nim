import std/[random]
import imgui
import implot
import utils


#-----------------
# demo_Heatmaps()
#-----------------
proc demo_Heatmaps*() =
  var
    values1{.global.} = [ [0.8f, 2.4f, 2.5f, 3.9f, 0.0f, 4.0f, 0.0f],
                          [2.4f, 0.0f, 4.0f, 1.0f, 2.7f, 0.0f, 0.0f],
                          [1.1f, 2.4f, 0.8f, 4.3f, 1.9f, 4.4f, 0.0f],
                          [0.6f, 0.0f, 0.3f, 0.0f, 3.1f, 0.0f, 0.0f],
                          [0.7f, 1.7f, 0.6f, 2.6f, 2.2f, 6.2f, 0.0f],
                          [1.3f, 1.2f, 0.0f, 0.0f, 0.0f, 3.2f, 5.1f],
                          [0.1f, 2.0f, 0.0f, 1.4f, 0.0f, 1.9f, 6.3f]]
    scale_min{.global.} = 0.float32
    scale_max{.global.} = 6.3.float32
    xlabels{.global.} = ["C1".cstring, "C2", "C3", "C4", "C5", "C6", "C7"]
    ylabels{.global.} = ["R1".cstring, "R2", "R3", "R4", "R5", "R6", "R7"]

    map{.global.} = ImPlotColormap.Viridis

  if ipColormapButton(ipGetColormapName(map), ImVec2(x: 225, y: 0), map):
    map = ((map.int + 1) mod ipGetColormapCount()).ImPlotColormap
    #// We bust the color cache of our plots so that item colors will
    #// resample the new colormap in the event that they have already
    #// been created. See documentation in implot.h.
    ipBustColorCache("##Heatmap1".cstring)
    ipBustColorCache("##Heatmap2".cstring)

  igSameLine()
  igLabelText("##Colormap Index", "%s", "Change Colormap")
  igSetNextItemWidth(225)
  igDragFloatRange2("Min / Max", addr scale_min, addr scale_max, 0.01f, -20, 20)

  var hm_flags{.global.} = 0.ImPlotHeatmapFlags.int32

  igCheckboxFlags("Column Major", addr hm_flags, ImPlotHeatmapFlags.ColMajor.int32)

  var axes_flags{.global.} = cast[ImPlotAxisFlags](ImPlotAxisFlags.Lock.int32 or
                              ImPlotAxisFlags.NoGridLines.int32 or
                              ImPlotAxisFlags.NoTickMarks.int32)

  ipPushColormap(map)

  if ipBeginPlot("##Heatmap1", ImVec2(x: 225, y: 225)
    , (ImPlotFlags.NoLegend.int32 or ImPlotFlags.NoMouseText.int32).ImPlotFlags):
    ipSetupAxes(nullptr, nullptr, axes_flags, axes_flags)
    ipSetupAxisTicks(ImAxis.X1, 0 + 1.0/14.0, 1 - 1.0/14.0, 7, addr xlabels[0])
    ipSetupAxisTicks(ImAxis.Y1, 1 - 1.0/14.0, 0 + 1.0/14.0, 7, addr ylabels[0])
    ipPlotHeatmap("heat", addr values1[0][0], 7, 7, scale_min, scale_max
      , "%g", ImPlotPoint(x: 0, y: 0), ImPlotPoint(x: 1, y: 1), hm_flags.ImPlotHeatmapFlags)
    ipEndPlot()

  igSameLine()
  ipColormapScale("##HeatScale", scale_min, scale_max, ImVec2(x: 60, y: 225))

  igSameLine()

  const size = 80
  var values2{.global.}: array[size*size, cfloat64]
  randomize((igGetTime()*1000000).int64)
  for i in 0..<(size * size):
    values2[i] = RandomRange(0.0, 1.0)
  if ipBeginPlot("##Heatmap2", ImVec2(x: 225, y: 225)):
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(-1, 1, -1, 1)
    ipPlotHeatmap("heat1", addr values2[0], size, size, 0, 1, nullptr)
    ipPlotHeatmap("heat2", addr values2[0], size, size, 0, 1, nullptr
      , ImPlotPoint(x: -1, y: -1)
      , ImPlotPoint(x: 0, y: 0))
    ipEndPlot()

  ipPopColormap()

