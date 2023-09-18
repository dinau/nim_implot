import imgui
import implot
import utils

# Notice: This demo dos'nt works well at this moment. TODO

#----------------------
# demo_RealtimePlots()
#----------------------
proc demo_RealtimePlots*() =
  igBulletText("Move your mouse to change the data!")
  igBulletText("This example assumes 60 FPS. Higher FPS requires larger buffer size.")
  var
    sdata1{.global.} = newScrollingBuffer()
    sdata2{.global.} = newScrollingBuffer()
    rdata1{.global.} = newRollingBuffer()
    rdata2{.global.} = newRollingBuffer()
    mouse:ImVec2
    t{.global.} = 0f

  igGetMousePosNonUDT(addr mouse)
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
    ipSetNextFillStyle(IMPLOT_AUTO_COL,0.5f)
    ipPlotShaded("Mouse X", addr sdata1.Data[0].x, addr sdata1.Data[0].y
                          , sdata1.Data.len
                          , -Inf
                          , 0.ImPlotShadedFlags
                          , sdata1.Offset
                          , 2 * sizeof(float))
    ipPlotLine("Mouse Y",   addr sdata2.Data[0].x, addr sdata2.Data[0].y
                          , sdata2.Data.len
                          , 0.ImPlotLineFlags
                          , sdata2.Offset
                          , 2*sizeof(float))

    ipEndPlot()

  if ipBeginPlot("##Rolling", ImVec2(x: -1,y: 150)):
    ipSetupAxes(nullptr, nullptr, flags, flags)
    ipSetupAxisLimits(ImAxis.X1,0,history, ImPlotCond.Always)
    ipSetupAxisLimits(ImAxis.Y1,0,1)
    ipPlotLine("Mouse X", addr rdata1.Data[0].x, addr rdata1.Data[0].y
                        , rdata1.Data.len
                        , 0.ImPlotLineFlags
                        , 0
                        , 2 * sizeof(float))
    ipPlotLine("Mouse Y", addr rdata2.Data[0].x , addr rdata2.Data[0].y
                        , rdata2.Data.len
                        , 0.ImPlotLineFlags
                        , 0
                        , 2 * sizeof(float))
    ipEndPlot()
