import imgui
import implot
import utils

#-----------------------
# demo_Tools_Querying()
#-----------------------
proc demo_Tools_Querying*() =
  var
    data {.global.}: seq[ImPlotPoint]
    rects {.global.}: seq[ImPlotRect]
    limits{.global.}: ImPlotRect
    select{.global.}: ImPlotRect
    init{.global.} = true
  if init:
    for i in 0..<50:
      var x = RandomRange(0.1.cdouble, 0.9)
      var y = RandomRange(0.1.cdouble, 0.9)
      data.add ImPlotPoint(x: x, y: y)
    init = false

  igBulletText("Box select and left click mouse to create a new query rect.")
  igBulletText("Ctrl + click in the plot area to draw points.")

  if igButton("Clear Queries"):
    rects = @[] # rects.shrink(0) TODO ?

  if ipBeginPlot("##Centroid"):
    defer: ipEndPlot()
    ipSetupAxesLimits(0, 1, 0, 1)
    if ipIsPlotHovered() and igIsMouseClicked(ImGuiMouseButton.Left) and igGetIO().keyCtrl:
      var pt: ImPlotPoint
      ipGetPlotMousePosNonUDT(pt.addr)
      data.add pt
    ipPlotScatter("Points", data[0].x.addr, data[0].y.addr
      , data.len.int, 0.ImPlotScatterFlags, 0, 2 * sizeof(cdouble))
    if ipIsPlotSelected():
      ipGetPlotSelectionNonUDT(select.addr)
      var cnt: int
      var centroid = FindCentroid(data, select, cnt)
      if cnt > 0:
        ipSetNextMarkerStyle(ImPlotMarker.Square, 6)
        ipPlotScatter("Centroid", centroid.x.addr, centroid.y.addr, 1)
      if igIsMouseClicked(ipGetInputMap().selectCancel):
        ipCancelPlotSelection()
        rects.add(select)
    for i in 0..<rects.len:
      var cnt: int
      var centroid = FindCentroid(data, rects[i], cnt)
      if cnt > 0:
        ipSetNextMarkerStyle(ImPlotMarker.Square, 6)
        ipPlotScatter("Centroid", centroid.x.addr, centroid.y.addr, 1)
      ipDragRect(i, rects[i].x.min.addr, rects[i].y.min.addr
                , rects[i].x.max.addr, rects[i].y.max.addr
                , ImVec4(x: 1, y: 0, z: 1, w: 1))
    ipGetPlotLimitsNonUDT(limits.addr)
