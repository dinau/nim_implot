import std/[math]
import imgui
import implot

#-----------------------------
# demo_Tools_DragLines()
#-----------------------------
proc demo_Tools_DragLines*() =
  igBulletText("Click and drag the horizontal and vertical lines.")
  var
    x1 {.global.} = 0.2.cdouble
    x2 {.global.} = 0.8.cdouble
    y1 {.global.} = 0.25.cdouble
    y2 {.global.} = 0.75.cdouble
    f {.global.} = 0.1.cdouble
    flags{.global.} = ImPlotDragToolFlags.None
  igCheckboxFlags("NoCursors", flags.pu32, ImPlotDragToolFlags.NoCursors.uint32); igSameLine()
  igCheckboxFlags("NoFit", flags.pu32, ImPlotDragToolFlags.NoFit.uint32); igSameLine()
  igCheckboxFlags("NoInput", flags.pu32, ImPlotDragToolFlags.NoInputs.uint32)
  if ipBeginPlot("##lines", ImVec2(x: -1, y: 0)):
    defer: ipEndPlot()
    ipSetupAxesLimits(0, 1, 0, 1)
    ipDragLineX(0, x1.addr, ImVec4(x: 1, y: 1, z: 1, w: 1), 1, flags)
    ipDragLineX(1, x2.addr, ImVec4(x: 1, y: 1, z: 1, w: 1), 1, flags)
    ipDragLineY(2, y1.addr, ImVec4(x: 1, y: 1, z: 1, w: 1), 1, flags)
    ipDragLineY(3, y2.addr, ImVec4(x: 1, y: 1, z: 1, w: 1), 1, flags)
    var
      xs: array[1000, cdouble]
      ys: array[1000, cdouble]
    for i in 0..<1000:
      xs[i] = (x2+x1)/2+abs(x2-x1)*(i.cfloat/1000.0f - 0.5f)
      ys[i] = (y1+y2)/2+abs(y2-y1)/2*sin(f*i.cfloat/10)
    ipPlotLine("Interactive Data", xs.ptz, ys.ptz, 1000)
    ipDragLineY(120482, f.addr, ImVec4(x: 1, y: 0.5f, z: 1, w: 1), 1, flags)
