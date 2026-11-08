import imgui
import implot

#------------------------
# demo_Tools_DragPoints()
#------------------------
proc demo_Tools_DragPoints*() =
  igBulletText("Click and drag each point.")
  var  flags{.global.} = ImPlotDragToolFlags.None
  igCheckboxFlags("NoCursors", flags.pu32, ImPlotDragToolFlags.NoCursors.uint32); igSameLine()
  igCheckboxFlags("NoFit", flags.pu32, ImPlotDragToolFlags.NoFit.uint32); igSameLine()
  igCheckboxFlags("NoInput", flags.pu32, ImPlotDragToolFlags.NoInputs.uint32); igSameLine()
  igCheckboxFlags("NoMove", flags.pu32, ImPlotDragToolFlags.NoMove.uint32)
  var
    clicked{.global.} = [false, false, false, false]
    hovered{.global.} = [false, false, false, false]
    held{.global.}    = [false, false, false, false]
  var ax_flags = ImPlotAxisFlags.NoTickLabels or ImPlotAxisFlags.NoTickMarks
  if ipBeginPlot("##Bezier",ImVec2(x: -1,y: 0),ImPlotFlags.CanvasOnly):
    defer: ipEndPlot()
    ipSetupAxes(nullptr,nullptr,ax_flags,ax_flags)
    ipSetupAxesLimits(0,1,0,1)
    var P{.global.} = [ImPlotPoint(x: 0.05f,y: 0.05f), ImPlotPoint(x: 0.2,y: 0.4),  ImPlotPoint(x: 0.8,y: 0.6),  ImPlotPoint(x: 0.95f,y: 0.95f)]
    ipDragPoint(0,P[0].x.addr,P[0].y.addr, ImVec4(x: 0,y: 0.9f,z: 0,w: 1),4,flags, clicked[0].addr, hovered[0].addr, held[0].addr)
    ipDragPoint(1,P[1].x.addr,P[1].y.addr, ImVec4(x: 1,y: 0.5f,z: 1,w: 1),4,flags, clicked[1].addr, hovered[1].addr, held[1].addr)
    ipDragPoint(2,P[2].x.addr,P[2].y.addr, ImVec4(x: 0,y: 0.5f,z: 1,w: 1),4,flags, clicked[2].addr, hovered[2].addr, held[2].addr)
    ipDragPoint(3,P[3].x.addr,P[3].y.addr, ImVec4(x: 0,y: 0.9f,z: 0,w: 1),4,flags, clicked[3].addr, hovered[3].addr, held[3].addr)

    var B{.global.}: array[100,ImPlotPoint]
    for i in 0..<100:
      var t :cdouble = i.float / 99.0
      var u :cdouble = 1 - t
      var w1:cdouble = u * u * u
      var w2:cdouble = 3 * u * u * t
      var w3:cdouble = 3 * u * t * t
      var w4:cdouble = t * t * t
      B[i] = ImPlotPoint(x: w1*P[0].x + w2*P[1].x + w3*P[2].x + w4*P[3].x, y: w1*P[0].y + w2*P[1].y + w3*P[2].y + w4*P[3].y)

    var spec = initImPlotSpec()
    spec.stride = sizeof(ImPlotPoint).cint  # data is interleaved ImPlotPoint array
    spec.lineColor = ImVec4(x: 1,y: 0.5f,z: 1,w: 1)
    spec.lineWeight = if hovered[1] or held[1]: 2.0f else: 1.0f
    ipPlotLine_spec("##h1",P[0].x.addr, P[0].y.addr, 2, spec)
    spec.lineColor = ImVec4(x: 0,y: 0.5f,z: 1,w: 1)
    spec.lineWeight = if hovered[2] or held[2]: 2.0f else: 1.0f
    ipPlotLine_spec("##h2",P[2].x.addr, P[2].y.addr, 2, spec)
    spec.lineColor = ImVec4(x: 0,y: 0.9f,z: 0,w: 1)
    spec.lineWeight = if hovered[0] or held[0] or hovered[3] or held[3]: 3.0f else: 2.0f
    ipPlotLine_spec("##bez",B[0].x.addr, B[0].y.addr, 100, spec)
