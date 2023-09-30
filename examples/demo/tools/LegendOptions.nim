import imgui
import implot
import utils

#---------------------------
# demo_Tools_LegendOptions()
#---------------------------
proc demo_Tools_LegendOptions*() =
  var loc{.global.} = ImPlotLocation.East
  igCheckboxFlags("North", loc.pu32, ImPlotLocation.North.uint32); igSameLine()
  igCheckboxFlags("South", loc.pu32, ImPlotLocation.South.uint32); igSameLine()
  igCheckboxFlags("West",  loc.pu32, ImPlotLocation.West.uint32);  igSameLine()
  igCheckboxFlags("East",  loc.pu32, ImPlotLocation.East.uint32)

  var flags{.global.} = 0.ImPlotLegendFlags

  CHECKBOX_FLAG(flags, ImPlotLegendFlags.Horizontal)
  CHECKBOX_FLAG(flags, ImPlotLegendFlags.Outside)
  CHECKBOX_FLAG(flags, ImPlotLegendFlags.Sort)
  var pad:array[2,cfloat]
  let v = ipGetStyle().legendPadding
  pad[0] = v.x
  pad[1] = v.y
  igSliderFloat2("LegendPadding", pad, 0.0f, 20.0f, "%.0f")
  igSliderFloat2("LegendInnerPadding", pad, 0.0f, 10.0f, "%.0f")
  igSliderFloat2("LegendSpacing", pad, 0.0f, 5.0f, "%.0f")

  if ipBeginPlot("##Legend",ImVec2(x: -1,y: 0)):
    defer: ipEndPlot()
    ipSetupLegend(loc, flags)
    var
      data1{.global.} = WaveData(X: 0.001, Amp:0.2, Freq: 4, Offset: 0.2)
      data2{.global.} = WaveData(X: 0.001, Amp:0.2, Freq: 4, Offset: 0.4)
      data3{.global.} = WaveData(X: 0.001, Amp:0.2, Freq: 4, Offset: 0.6)
      data4{.global.} = WaveData(X: 0.001, Amp:0.2, Freq: 4, Offset: 0.8)
      data5{.global.} = WaveData(X: 0.001, Amp:0.2, Freq: 4, Offset: 1.0)

    ipPlotLineG("Item B",         utils.SawWave, data1.addr, 1000) #// "Item B" added to legend
    ipPlotLineG("Item A##IDText", utils.SawWave, data2.addr, 1000) #// "Item A" added to legend, text after ## used for ID only
    ipPlotLineG("##NotListed",    utils.SawWave, data3.addr, 1000) #// plotted, but not added to legend
    ipPlotLineG("Item C",         utils.SawWave, data4.addr, 1000) #// "Item C" added to legend
    ipPlotLineG("Item C",         utils.SawWave, data5.addr, 1000) #// combined with previous "Item C"
