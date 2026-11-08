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

    var lineSpec = initImPlotSpec()
    lineSpec.lineColor = ImVec4(x:0.5f,y:0.5f,z:0.5f,w:1.0f)
    ipPlotLine_spec("##1", ys1.ptz, 21, 0.05f, 0, lineSpec)
    ipPlotLine_spec("##2", ys2.ptz, 21, 0.05f, 0, lineSpec)

    var spec = initImPlotSpec()
    spec.flags = cast[ImPlotItemFlags](flags)
    spec.fillAlpha = 0.25f
    spec.marker = ImPlotMarker.Auto
    ipPlotStairs_spec("Post Step (default)", ys1.ptz, 21, 0.05f, 0, spec)

    spec.flags = cast[ImPlotItemFlags](flags or ImPlotStairsFlags.PreStep)
    ipPlotStairs_spec("Pre Step", ys2.ptz, 21, 0.05f, 0, spec)

    ipEndPlot()
