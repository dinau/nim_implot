import imgui
import implot
import utils

#---------------------------
# demo_Subplots_ItemSharing()
#---------------------------
proc demo_Subplots_ItemSharing*() =
  var
    flags{.global.} = ImPlotSubplotFlags.ShareItems
  igCheckboxFlags("ImPlotSubplotFlags_ShareItems", flags.pu32, ImPlotSubplotFlags.ShareItems.uint32)
  igCheckboxFlags("ImPlotSubplotFlags_ColMajor", flags.pu32, ImPlotSubplotFlags.ColMajor.uint32)
  igBulletText("Drag and drop items from the legend onto plots (except for 'common')")
  var
    rows{.global.} = 2
    cols{.global.} = 3
    id{.global.} = [0, 1, 2, 3, 4, 5]
    curj{.global.} = -1
  if ipBeginSubplots("##ItemSharing", rows, cols, ImVec2(x: -1, y: 400), flags):
    defer: ipEndSubplots()
    for i in 0..<rows*cols:
      if ipBeginPlot(""):
        defer: ipEndPlot()
        var fc = 0.01f
        ipPlotLineG("common".cstring, Sinewave, fc.addr, 1000)
        for j in 0..<6:
          if id[j] == i:
            var label: array[8, cchar]
            var fj = 0.01f * (j + 2).float32
            discard snprintf(label.ptz.cstringCast, label.len.cint, "data%d".cstring, j.cint)
            ipPlotLineG(label.ptz.cstringCast, Sinewave, fj.addr, 1000)
            if ipBeginDragDropSourceItem(label.ptz.cstringCast):
              curj = j
              igSetDragDropPayload("MY_DND", nullptr, 0)
              var col: ImVec4
              ipGetLastItemColorNonUDT(col.addr)
              ipItemIcon(col); igSameLine()
              igTextUnformatted(label.addr.cstringCast)
              ipEndDragDropSource()
        if ipBeginDragDropTargetPlot():
          if isNil igAcceptDragDropPayload("MY_DND"):
            id[curj] = i
          ipEndDragDropTarget()
