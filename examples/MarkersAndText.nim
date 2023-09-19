const fDisable = true # This example crashes.

when not fDisable:
  import imgui
  import implot
  import utils

#----------------------
# demo_MarkersAndText()
#----------------------
proc demo_MarkersAndText*() =
  when fDisable:
    discard
  else:
    var
      mk_size  {.global.} = ipGetStyle().markerSize # float32 : Crash here! . I don't why the reason.
      mk_weight{.global.} = ipGetStyle().markerWeight

    igDragFloat("Marker Size",   addr mk_size  ,0.1f,2.0f,10.0f,"%.2f px")
    igDragFloat("Marker Weight", addr mk_weight,0.05f,0.5f,3.0f,"%.2f px")

    if ipBeginPlot("##MarkerStyles", ImVec2(x: -1,y: 0), ImPlotFlags.CanvasOnly):
     ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
     ipSetupAxesLimits(0, 10, 0, 12)
     var
       xs = [1'i8 ,4]
       ys = [10'i8,11]

     #// filled markers
     for m in 0..<ImPlotMarker.COUNT.int32:
       igPushID(m)
       ipSetNextMarkerStyle(m.ImPlotMarker, mk_size, IMPLOT_AUTO_COL, mk_weight)
       ipPlotLine("##Filled", addr xs[0], addr ys[0], 2)
       igPopID()
       dec ys[0]; dec ys[1]
     xs[0] = 6; xs[1] = 9; ys[0] = 10; ys[1] = 11
     #// open markers
     for m in 0..<ImPlotMarker.COUNT.int32:
       igPushID(m)
       ipSetNextMarkerStyle(m.ImPlotMarker, mk_size, ImVec4(x: 0,y: 0,z: 0,w: 0), mk_weight)
       ipPlotLine("##Open", addr xs[0], addr ys[0], 2)
       igPopID()
       dec ys[0]; dec ys[1]

     ipPlotText("Filled Markers", 2.5f, 6.0f)
     ipPlotText("Open Markers",   7.5f, 6.0f)

     ipPushStyleColor(ImPlotCol.InlayText, ImVec4(x: 1,y: 0,z: 1,w: 1))
     ipPlotText("Vertical Text", 5.0f, 6.0f, ImVec2(x: 0,y: 0), ImPlotTextFlags.Vertical)
     ipPopStyleColor()

     ipEndPlot()
