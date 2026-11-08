import imgui
import implot
import utils

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

    ipPlotBars("Bar", xs.ptz, bar.ptz, 5, 0.5f)
    ipPlotErrorBars("Bar", xs.ptz, bar.ptz, err1.ptz, 5)

    var col1: ImVec4
    ipGetColormapColorNonUDT(addr col1, 1)
    var spec = initImPlotSpec()
    spec.lineColor = col1
    spec.size = 0
    ipPlotErrorBars_spec("Line", xs.ptz, lin1.ptz, err1.ptz, err2.ptz, 5, spec)
    spec = initImPlotSpec()
    spec.marker = ImPlotMarker.Square
    ipPlotLine_spec("Line", xs.ptz, lin1.ptz, 5, spec)

    var col2: ImVec4
    ipGetColormapColorNonUDT(addr col2, 2)
    spec = initImPlotSpec()
    spec.lineColor = col2
    spec.size = 6
    spec.lineWeight = 1.5f
    ipPlotErrorBars_spec("Scatter", xs.ptz, lin2.ptz, err2.ptz, 5, spec)
    spec.flags = cast[ImPlotItemFlags](ImPlotErrorBarsFlags.Horizontal)
    ipPlotErrorBars_spec("Scatter", xs.ptz, lin2.ptz, err3.ptz, err4.ptz, 5, spec)
    ipPlotScatter("Scatter", xs.ptz, lin2.ptz, 5)

    ipEndPlot()
