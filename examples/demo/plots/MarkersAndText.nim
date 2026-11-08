import imgui
import implot
import utils

#----------------------
# demo_MarkersAndText()
#----------------------
proc demo_MarkersAndText*() =
  var spec{.global.} = initImPlotSpec()
  once:
    spec.marker = ImPlotMarker.Auto
  igDragFloat("Marker Size",   addr spec.markerSize, 0.1f, 2.0f, 10.0f, "%.2f px")
  igDragFloat("Marker Weight", addr spec.lineWeight, 0.05f, 0.5f, 3.0f, "%.2f px")

  if ipBeginPlot("##MarkerStyles", ImVec2(x: -1,y: 0), ImPlotFlags.CanvasOnly):
   ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
   ipSetupAxesLimits(0, 10, -2, 12)
   var
     xs = [1'i8 ,4]
     ys = [10'i8,11]

   #// filled markers
   for m in 0..<ImPlotMarker.COUNT.int32:
     igPushID(m)
     spec.fillAlpha = 1.0f
     ipPlotLine_spec("##Filled", xs.ptz, ys.ptz, 2, spec)
     igPopID()
     dec ys[0]; dec ys[1]
   xs[0] = 6; xs[1] = 9; ys[0] = 10; ys[1] = 11
   #// open markers
   for m in 0..<ImPlotMarker.COUNT.int32:
     igPushID(m)
     spec.fillAlpha = 0.0f
     ipPlotLine_spec("##Open", xs.ptz, ys.ptz, 2, spec)
     igPopID()
     dec ys[0]; dec ys[1]

   ipPlotText("Filled Markers", 2.5f, 5.0f)
   ipPlotText("Open Markers",   7.5f, 5.0f)

   ipPushStyleColor(ImPlotCol.InlayText, ImVec4(x: 1,y: 0,z: 1,w: 1))
   var textSpec = initImPlotSpec()
   textSpec.flags = cast[ImPlotItemFlags](ImPlotTextFlags.Vertical)
   ipPlotText_spec("Vertical Text", 5.0f, 5.0f, ImVec2(x: 0,y: 0), textSpec)
   ipPopStyleColor()

   ipEndPlot()
