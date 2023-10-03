import imgui
import implot
import utils

#----------------------------
# Demo_Subplots_AxisLinking()
#----------------------------
proc demo_Subplots_AxisLinking*() =
  var flags{.global.} = ImPlotSubplotFlags.LinkRows or  ImPlotSubplotFlags.LinkCols
  igCheckboxFlags("ImPlotSubplotFlags_LinkRows", flags.pu32, ImPlotSubplotFlags.LinkRows.uint32)
  igCheckboxFlags("ImPlotSubplotFlags_LinkCols", flags.pu32, ImPlotSubplotFlags.LinkCols.uint32)
  igCheckboxFlags("ImPlotSubplotFlags_LinkAllX", flags.pu32, ImPlotSubplotFlags.LinkAllX.uint32)
  igCheckboxFlags("ImPlotSubplotFlags_LinkAllY", flags.pu32, ImPlotSubplotFlags.LinkAllY.uint32)
  var
    rows = 2.int32
    cols = 2.int32
  if ipBeginSubplots("##AxisLinking", rows, cols, ImVec2(x: -1,y: 400), flags):
    defer: ipEndSubplots()
    for i in 0..<rows*cols:
      if ipBeginPlot(""):
        defer: ipEndPlot()
        ipSetupAxesLimits(0,1000,-1,1)
        var fc = 0.01f
        ipPlotLineG("common",Sinewave,fc.addr,1000)
