import imgui
import implot

#----------------
# Demo_ErrorBars()
#----------------
proc demo_ErrorBars*() =
  var
    xs   = [1'f32,2,3,4,5]
    bar  = [1'f32,2,5,3,4]
    lin1 = [8'f32,8,9,7,8]
    lin2 = [6'f32,7,6,9,6]
    err1 = [0.2f, 0.4f, 0.2f, 0.6f, 0.4f]
    err2 = [0.4f, 0.2f, 0.4f, 0.8f, 0.6f]
    err3 = [0.09f, 0.14f, 0.09f, 0.12f, 0.16f]
    err4 = [0.02f, 0.08f, 0.15f, 0.05f, 0.2f]

  if ipBeginPlot("##ErrorBars"):
    ipSetupAxesLimits(0, 6, 0, 10)
    ipPlotBars("Bar", addr xs[0], addr bar[0], 5, 0.5f)
    ipPlotErrorBars("Bar", addr xs[0], addr bar[0], addr err1[0], 5)
    var vec4:ImVec4
    ipGetColormapColorNonUDT(addr vec4,1)
    ipSetNextErrorBarStyle(vec4, 0)
    ipPlotErrorBars("Line", addr xs[0], addr lin1[0], addr err1[0], addr err2[0], 5)
    ipSetNextMarkerStyle(ImPlotMarker.Square)
    ipPlotLine("Line", addr xs[0], addr lin1[0], 5)

    ipGetColormapColorNonUDT(addr vec4,2)
    ipPushStyleColor(ImPlotCol.ErrorBar, vec4)
    ipPlotErrorBars("Scatter", addr xs[0], addr lin2[0], addr err2[0], 5)
    ipPlotErrorBars("Scatter", addr xs[0], addr lin2[0], addr err3[0], addr err4[0], 5, ImPlotErrorBarsFlags.Horizontal)
    ipPopStyleColor()
    ipPlotScatter("Scatter", addr xs[0], addr lin2[0], 5)

    ipEndPlot()

