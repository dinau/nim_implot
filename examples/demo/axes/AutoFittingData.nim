import std/[math,random]
import imgui
import implot

#-----------------------------
# demo_Axes_AutoFittingData()
#-----------------------------
proc demo_Axes_AutoFittingData*() =
  igBulletText("The Y-axis has been configured to auto-fit to only the data visible in X-axis range.")
  igBulletText("Zoom and pan the X-axis. Disable Stems to see a difference in fit.")
  igBulletText("If ImPlotAxisFlags_RangeFit is disabled, the axis will fit ALL data.")
  var
    xflags{.global.} = ImPlotAxisFlags.None
    yflags{.global.} = ImPlotAxisFlags.AutoFit or ImPlotAxisFlags.RangeFit

  igTextUnformatted("X: ");igSameLine()
  igCheckboxFlags("ImPlotAxisFlags_AutoFit##X", xflags.pu32, ImPlotAxisFlags.AutoFit.uint32);igSameLine()
  igCheckboxFlags("ImPlotAxisFlags_RangeFit##X", xflags.pu32, ImPlotAxisFlags.RangeFit.uint32)

  igTextUnformatted("Y: "); igSameLine()
  igCheckboxFlags("ImPlotAxisFlags_AutoFit##Y", yflags.pu32, ImPlotAxisFlags.AutoFit.uint32);igSameLine()
  igCheckboxFlags("ImPlotAxisFlags_RangeFit##Y", yflags.pu32, ImPlotAxisFlags.RangeFit.uint32)

  var data{.global.}:array[101,cdouble]
  randomize(0) # srand(0) : C++
  for i in 0..<101:
    data[i] = 1.cfloat + sin(i.cfloat/10.0f)

  if ipBeginPlot("##DataFitting"):
    defer: ipEndPlot()
    ipSetupAxes("X","Y",xflags,yflags)
    ipPlotLine("Line",data.ptz,101)
    ipPlotStems("Stems",data.ptz,101)
