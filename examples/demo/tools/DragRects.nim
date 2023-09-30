import std/[math]
import imgui
import implot

#-----------------------
# demo_Tools_DragRects()
#-----------------------
proc demo_Tools_DragRects*() =
  var
    x_data {.global.}: array[512, cfloat]
    y_data1{.global.}: array[512, cfloat]
    y_data2{.global.}: array[512, cfloat]
    y_data3{.global.}: array[512, cfloat]
    sampling_freq{.global.} = 44100.cfloat
    freq {.global.} = 500.cfloat

  for i in 0..<512:
    let t = i.cfloat / sampling_freq
    x_data[i] = t
    let arg = 2 * 3.14f * freq * t
    y_data1[i] = sin(arg)
    y_data2[i] = y_data1[i] * -0.6f + sin(2 * arg) * 0.4f
    y_data3[i] = y_data2[i] * -0.6f + sin(3 * arg) * 0.4f
  igBulletText("Click and drag the edges, corners, and center of the rect.")
  var
    rx = ImPlotRange(min: 0.0025, max: 0.0045)
    ry = ImPlotRange(min: 0, max: 0.5)
    rect{.global.} : ImPlotRect
    flags{.global.} = ImPlotDragToolFlags.None
  once:
    rect = ImPlotRect(x: rx , y: ry)

  igCheckboxFlags("NoCursors", flags.pu32, ImPlotDragToolFlags.NoCursors.uint32); igSameLine()
  igCheckboxFlags("NoFit", flags.pu32, ImPlotDragToolFlags.NoFit.uint32); igSameLine()
  igCheckboxFlags("NoInput", flags.pu32, ImPlotDragToolFlags.NoInputs.uint32)

  if ipBeginPlot("##Main", ImVec2(x: -1, y: 150)):
    defer: ipEndPlot()
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoTickLabels, ImPlotAxisFlags.NoTickLabels)
    ipSetupAxesLimits(0, 0.01, -1, 1)
    ipPlotLine("Signal 1", x_data.ptz, y_data1.ptz, 512)
    ipPlotLine("Signal 2", x_data.ptz, y_data2.ptz, 512)
    ipPlotLine("Signal 3", x_data.ptz, y_data3.ptz, 512)
    ipDragRect(0, rect.x.min.addr, rect.y.min.addr, rect.x.max.addr, rect.y.max.addr, ImVec4(x: 1, y: 0, z: 1, w: 1), flags)
  if ipBeginPlot("##rect", ImVec2(x: -1, y: 150), ImPlotFlags.CanvasOnly):
    defer: ipEndPlot()
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(rect.x.min, rect.x.max, rect.y.min, rect.y.max, ImPlotCond.Always)
    ipPlotLine("Signal 1", x_data.ptz, y_data1.ptz, 512)
    ipPlotLine("Signal 2", x_data.ptz, y_data2.ptz, 512)
    ipPlotLine("Signal 3", x_data.ptz, y_data3.ptz, 512)
