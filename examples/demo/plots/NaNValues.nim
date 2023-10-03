import imgui
import implot

#--------------------
# demo_NaNValues()
#--------------------
proc demo_NaNValues*() =
  var
    include_nan{.global.} = true
    flags{.global.} = 0.ImPlotLineFlags
    data1 = [0.0f,0.25f,0.5f,0.75f,1.0f]
    data2 = [0.0f,0.25f,0.5f,0.75f,1.0f]

  if (include_nan):
    data1[2] = NAN

  igCheckbox("Include NaN", addr include_nan)
  igSameLine()
  igCheckboxFlags("Skip NaN", cast[ptr int32](addr flags), ImPlotLineFlags.SkipNaN.int32)

  if ipBeginPlot("##NaNValues"):
    ipSetNextMarkerStyle(ImPlotMarker.Square)
    ipPlotLine("line", data1.ptz, data2.ptz, 5, flags)
    ipPlotBars("bars", data1.ptz, 5)
    ipEndPlot()
