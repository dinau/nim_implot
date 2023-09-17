import std/[math]
import imgui
import implot
import utils

#--------------------------
# proc demo_StairstepPlots
#--------------------------
proc demo_StairstepPlots*() =
  var
    ys1{.global.}:array[21,cfloat]
    ys2{.global.}:array[21,cfloat]
  for i in 0..<21:
    ys1[i] = 0.75f + 0.2f * sin((10 * i).float32 * 0.05f)
    ys2[i] = 0.25f + 0.2f * sin((10 * i).float32 * 0.05f)

  var flags{.global.} = 0.ImPlotStairsFlags
  CHECKBOX_FLAG(flags, ImPlotStairsFlags.Shaded)
  if ipBeginPlot("Stairstep Plot"):
    ipSetupAxes("x","f(x)")
    ipSetupAxesLimits(0,1,0,1)

    ipPushStyleColor(ImPlotCol.Line, ImVec4(x:0.5f,y:0.5f,z:0.5f,w:1.0f))
    ipPlotLine("##1",addr ys1[0],21,0.05f)
    ipPlotLine("##2",addr ys2[0],21,0.05f)
    ipPopStyleColor()

    ipSetNextMarkerStyle(ImPlotMarker.Circle)
    ipSetNextFillStyle(IMPLOT_AUTO_COL, 0.25f)
    ipPlotStairs("Post Step (default)", addr ys1[0], 21, 0.05f, 0, flags)
    ipSetNextMarkerStyle(ImPlotMarker.Circle)
    ipSetNextFillStyle(IMPLOT_AUTO_COL, 0.25f)
    ipPlotStairs("Pre Step", addr ys2[0], 21, 0.05f, 0, (flags.int32 or ImPlotStairsFlags.PreStep.int32).ImPlotStairsFlags)

    ipEndPlot()

