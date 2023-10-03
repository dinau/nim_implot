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
    ipPlotBars("Bar",       xs.ptz, bar.ptz, 5, 0.5f)
    ipPlotErrorBars("Bar",  xs.ptz, bar.ptz, err1.ptz, 5)
    var vec4:ImVec4
    ipGetColormapColorNonUDT(addr vec4,1)
    ipSetNextErrorBarStyle(vec4, 0)
    ipPlotErrorBars("Line", xs.ptz, lin1.ptz, err1.ptz,  err2.ptz, 5)
    ipSetNextMarkerStyle(ImPlotMarker.Square)
    ipPlotLine("Line",  xs.ptz,  lin1.ptz, 5)

    ipGetColormapColorNonUDT( addr vec4,2)
    ipPushStyleColor(ImPlotCol.ErrorBar, vec4)
    ipPlotErrorBars("Scatter",  xs.ptz,  lin2.ptz,  err2.ptz, 5)
    ipPlotErrorBars("Scatter",  xs.ptz,  lin2.ptz,  err3.ptz,  err4.ptz, 5, ImPlotErrorBarsFlags.Horizontal)
    ipPopStyleColor()
    ipPlotScatter("Scatter",  xs.ptz,  lin2.ptz, 5)

    ipEndPlot()
