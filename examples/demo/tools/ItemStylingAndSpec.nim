import imgui
import implot

#-----------------------------
# Demo_ItemStylingAndSpec()
#-----------------------------
proc demo_Tools_ItemStylingAndSpec*() =
  var data1{.global.}: array[20, ImVec2]
  var data2{.global.}: array[20, ImVec2]
  once:
    for i in 0..<20:
      data1[i].x = i.float32 * 1 / 19.0f
      data1[i].y = data1[i].x * data1[i].x
      data2[i].x = i.float32 * 1 / 19.0f
      data2[i].y = data2[i].x * data2[i].x * data2[i].x
  if ipBeginPlot("##SpecStyling"):
    defer: ipEndPlot()
    ipSetupAxes("x","y")

    #// Two options for using ImPlotSpec:

    #// 1. By declaring and defining a struct instance:
    var spec = initImPlotSpec()
    spec.lineColor = ImVec4(x: 1,y: 1,z: 0,w: 1)
    spec.lineWeight = 1.0f
    spec.fillColor = ImVec4(x: 1,y: 0.5f,z: 0,w: 1)
    spec.fillAlpha = 0.5f
    spec.marker = ImPlotMarker.Square
    spec.markerSize = 6
    spec.stride = sizeof(ImVec2).cint
    spec.flags = cast[ImPlotItemFlags](ImPlotItemFlags.NoLegend) or cast[ImPlotItemFlags](ImPlotLineFlags.Shaded)
    ipPlotLine_spec("Line 1", data1[0].x.addr, data1[0].y.addr, 20, spec)

    #// 2. Inline using ImPlotProp,value pairs (order does NOT matter) -- in Nim,
    #// just set the spec fields directly:
    var spec2 = initImPlotSpec()
    spec2.lineColor = ImVec4(x: 0,y: 1,z: 1,w: 1)
    spec2.lineWeight = 1.0f
    spec2.fillColor = ImVec4(x: 0,y: 0,z: 1,w: 1)
    spec2.fillAlpha = 0.5f
    spec2.marker = ImPlotMarker.Diamond
    spec2.size = 6
    spec2.stride = sizeof(ImVec2).cint
    spec2.flags = cast[ImPlotItemFlags](ImPlotItemFlags.NoLegend) or cast[ImPlotItemFlags](ImPlotLineFlags.Shaded)
    ipPlotLine_spec("Line 2", data2[0].x.addr, data2[0].y.addr, 20, spec2)
