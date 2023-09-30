import std/[times]
import imgui
import implot

#----------------------
# Demo_Config_Config()
#----------------------
proc demo_Config_Config*() =
  igShowFontSelector("Font")
  igShowStyleSelector("ImGui Style")
  ipShowStyleSelector("ImPlot Style")
  ipShowColormapSelector("ImPlot Colormap")
  ipShowInputMapSelector("Input Map")
  igSeparator()
  igCheckbox("Use Local Time", ipGetStyle().useLocalTime.addr)
  igCheckbox("Use ISO 8601", ipGetStyle().useISO8601.addr)
  igCheckbox("Use 24 Hour Clock", ipGetStyle().use24HourClock.addr)
  igSeparator()
  if ipBeginPlot("Preview"):
    defer: ipEndPlot()
    var nowd {.global.} = epochTime().cdouble
    ipSetupAxisScale(ImAxis.X1, ImPlotScale.Time)
    ipSetupAxisLimits(ImAxis.X1, nowd, nowd + 24 * 3600)
    for i in 0..<10:
      var
        x = [nowd, nowd + 24*3600]
        y = [0.cdouble,i.cdouble/9.0]
      igPushID(i.int32)
      ipPlotLine("##Line",x.ptz,y.ptz,2)
      igPopID()
