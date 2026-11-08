import imgui
import implot
import utils

#----------------------
# demo_RealtimePlots()
#----------------------
proc demo_RealtimePlots*() =
  igBulletText("Move your mouse to change the data!")
  igBulletText("This example assumes 60 FPS. Higher FPS requires larger buffer size.")
  var
    sdata1{.global.} : ScrollingBuffer
    sdata2{.global.} : ScrollingBuffer
    rdata1{.global.} : RollingBuffer
    rdata2{.global.} : RollingBuffer
    mouse:ImVec2
    t{.global.} = 0f
  once:
    sdata1 = newScrollingBuffer()
    sdata2 = newScrollingBuffer()
    rdata1 = newRollingBuffer()
    rdata2 = newRollingBuffer()


  mouse = igGetMousePosNonUDT()
  t += igGetIO().deltaTime
  sdata1.AddPoint(t, mouse.x * 0.0005f)
  rdata1.AddPoint(t, mouse.x * 0.0005f)
  sdata2.AddPoint(t, mouse.y * 0.0005f)
  rdata2.AddPoint(t, mouse.y * 0.0005f)

  var history{.global.} = 10.0f
  igSliderFloat("History",addr history,1,30,"%.1f s")
  rdata1.Span = history
  rdata2.Span = history

  var flags{.global.} = ImPlotAxisFlags.NoTickLabels
  if ipBeginPlot("##Scrolling", ImVec2(x: -1,y: 150)):
    ipSetupAxes(nullptr, nullptr, flags, flags)
    ipSetupAxisLimits(ImAxis.X1,(t - history), t, ImPlotCond.Always)
    ipSetupAxisLimits(ImAxis.Y1,0,1)
    var spec = initImPlotSpec()
    spec.offset = sdata1.Offset.cint
    spec.stride = (2 * sizeof(cfloat)).cint
    spec.fillAlpha = 0.5f
    ipPlotShaded_spec("Mouse X", addr sdata1.Data[0].x, addr sdata1.Data[0].y
                          , sdata1.Data.len
                          , -Inf
                          , spec)
    spec = initImPlotSpec()
    spec.offset = sdata2.Offset.cint
    spec.stride = (2 * sizeof(cfloat)).cint
    ipPlotLine_spec("Mouse Y", addr sdata2.Data[0].x, addr sdata2.Data[0].y
                          , sdata2.Data.len
                          , spec)

    ipEndPlot()

  if ipBeginPlot("##Rolling", ImVec2(x: -1,y: 150)):
    ipSetupAxes(nullptr, nullptr, flags, flags)
    ipSetupAxisLimits(ImAxis.X1,0,history, ImPlotCond.Always)
    ipSetupAxisLimits(ImAxis.Y1,0,1)
    var spec = initImPlotSpec()
    spec.offset = 0
    spec.stride = (2 * sizeof(cfloat)).cint
    ipPlotLine_spec("Mouse X", addr rdata1.Data[0].x, addr rdata1.Data[0].y
                        , rdata1.Data.len
                        , spec)
    ipPlotLine_spec("Mouse Y", addr rdata2.Data[0].x , addr rdata2.Data[0].y
                        , rdata2.Data.len
                        , spec)
    ipEndPlot()
