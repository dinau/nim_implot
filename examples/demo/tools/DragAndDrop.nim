import std/[math]
import imgui
import implot
import utils

# // convenience struct to manage DND items; do this however you like
# struct MyDndItem {
#   int              Idx
#   int              Plt
#   ImAxis           Yax
#   char             Label[16]
#   ImVector<ImVec2> Data
#   ImVec4           Color
#   MyDndItem()        {
#     static int i = 0
#     Idx = i++
#     Plt = 0
#     Yax = ImAxis_Y1
#     snprintf(Label, sizeof(Label), "%02d Hz", Idx+1)
#     Color = RandomColor()
#     Data.reserve(1001)
#     for (int k = 0; k < 1001; ++k) {
#       float t = k * 1.0f / 999
#       Data.push_back(ImVec2(t, 0.5f + 0.5f * sinf(2*3.14f*t*(Idx+1))))
#     }
#   }
#   void Reset() { Plt = 0; Yax = ImAxis_Y1; }
# }

type
  MyDndItem = ref object
    Idx*: int32
    Plt*: int32
    Yax*: ImAxis
    Label*: array[16, cchar]
    Data*: seq[ImVec2]
    Color*: ImVec4

proc newMyDndItem(): MyDndItem =
  result = new MyDndItem
  var i{.global.} = 0'i32
  result.Idx = i
  result.Plt = 0
  result.Yax = ImAxis.Y1
  i.inc
  discard snprintf(result.Label.ptz.cstringCast, result.Label.len.cint, "%02d Hz".cstring
    , (result.Idx + 1.int32).cint)
  result.Color = RandomColor()
  result.Data = newSeqOfCap[ImVec2](1001)
  for k in 0..<1001:
    let t = k.float * 1.0f / 999.float
    result.Data.add(ImVec2(x: t, y: 0.5f + 0.5f * sin(2 * 3.14f * t * (result.Idx + 1).float)))

proc Reset(this: var MyDndItem) =
  this.Plt = 0
  this.Yax = ImAxis.Y1

#-------------------------
# demo_Tools_DragAndDrop()
#--------------------------
proc demo_Tools_DragAndDrop*() =
  igBulletText("Drag/drop items from the left column.")
  igBulletText("Drag/drop items between plots.")
  igIndent()
  igBulletText("Plot 1 Targets: Plot, Y-Axes, Legend")
  igBulletText("Plot 1 Sources: Legend Item Labels")
  igBulletText("Plot 2 Targets: Plot, X-Axis, Y-Axis")
  igBulletText("Plot 2 Sources: Plot, X-Axis, Y-Axis (hold Ctrl)")
  igUnindent()

  const k_dnd = 20
  var
    dnd {.global.}: array[k_dnd, MyDndItem]
    dndx{.global.}: MyDndItem = nullptr #// for plot 2
    dndy{.global.}: MyDndItem = nullptr #// for plot 2
  once:
    for i in 0..<dnd.len:
      dnd[i] = newMyDndItem()

  #// child window to serve as initial source for our DND items
  igBeginChild("DND_LEFT", ImVec2(x: 100, y: 400))
  if igButton("Reset Data"):
    for k in 0..<k_dnd:
      dnd[k].Reset()
    dndx = nullptr
    dndy = nullptr
  for k in 0..<k_dnd:
    var kk = k
    if dnd[k].Plt > 0:
      continue
    ipItemIcon(dnd[k].Color); igSameLine()
    igSelectable(dnd[k].Label.ptz.cstringCast, false, 0.ImGuiSelectableFlags, ImVec2(x: 100, y: 0))
    if igBeginDragDropSource(ImGuiDragDropFlags.None):
      igSetDragDropPayload("MY_DND", kk.addr, sizeof(int).uint)
      ipItemIcon(dnd[k].Color); igSameLine()
      igTextUnformatted(dnd[k].Label.ptz.cstringCast)
      igEndDragDropSource()
  igEndChild()
  if igBeginDragDropTarget():
    let payload = igAcceptDragDropPayload("MY_DND")
    if not payload.isNil:
      let i = cast[ptr int](payload.data)[]
      dnd[i].Reset()
    igEndDragDropTarget()
  igSameLine()
  igBeginChild("DND_RIGHT", ImVec2(x: -1, y: 400))
  #// plot 1 (time series)
  var flags = ImPlotAxisFlags.NoTickLabels or ImPlotAxisFlags.NoGridLines or ImPlotAxisFlags.NoHighlight
  if ipBeginPlot("##DND1", ImVec2(x: -1, y: 195)):
    ipSetupAxis(ImAxis.X1, nullptr, flags or ImPlotAxisFlags.Lock)
    ipSetupAxis(ImAxis.Y1, "[drop here]", flags)
    ipSetupAxis(ImAxis.Y2, "[drop here]", flags or ImPlotAxisFlags.Opposite)
    ipSetupAxis(ImAxis.Y3, "[drop here]", flags or ImPlotAxisFlags.Opposite)

    for k in 0..<k_dnd:
      var kk = k
      if dnd[k].Plt == 1 and dnd[k].Data.len > 0:
        ipSetAxis(dnd[k].Yax)
        ipSetNextLineStyle(dnd[k].Color)
        ipPlotLine(dnd[k].Label.ptz.cstringCast
          , dnd[k].Data[0].x.addr
          , dnd[k].Data[0].y.addr
          , dnd[k].Data.len, 0.ImPlotLineFlags, 0, 2 * sizeof(cfloat)) # Being sizeof(cfloat) is very important.
        #// allow legend item labels to be DND sources
        if ipBeginDragDropSourceItem(dnd[k].Label.ptz.cstringCast):
          igSetDragDropPayload("MY_DND", kk.addr, sizeof(int).uint)
          ipItemIcon(dnd[k].Color); igSameLine()
          igTextUnformatted(dnd[k].Label.ptz.cstringCast)
          ipEndDragDropSource()
    #// allow the main plot area to be a DND target
    if ipBeginDragDropTargetPlot():
      let payload = igAcceptDragDropPayload("MY_DND")
      if not payload.isNil:
        var i = cast[ptr int](payload.data)[]; dnd[i].Plt = 1; dnd[i].Yax = ImAxis.Y1
      ipEndDragDropTarget()
    #// allow each y-axis to be a DND target
    for y in ImAxis.Y1..ImAxis.Y3:
      if ipBeginDragDropTargetAxis(y):
        let payload = igAcceptDragDropPayload("MY_DND")
        if not payload.isNil:
          var i = cast[ptr int](payload.data)[]; dnd[i].Plt = 1; dnd[i].Yax = y
        ipEndDragDropTarget()
    #// allow the legend to be a DND target
    if ipBeginDragDropTargetLegend():
      let payload = igAcceptDragDropPayload("MY_DND")
      if not payload.isNil:
        var i = cast[ptr int](payload.data)[]; dnd[i].Plt = 1; dnd[i].Yax = ImAxis.Y1
      ipEndDragDropTarget()
    ipEndPlot()

  #// plot 2 (Lissajous)
  if ipBeginPlot("##DND2", ImVec2(x: -1, y: 195)):
    defer: ipEndPlot()
    ipPushStyleColor(ImPlotCol.AxisBg, if dndx != nullptr: dndx.Color else: ipGetStyle().colors[ImPlotCol.AxisBg.int])
    ipSetupAxis(ImAxis.X1, if dndx == nullptr: "[drop here]".cstring else: dndx.Label.ptz.cstringCast, flags)
    ipPushStyleColor(ImPlotCol.AxisBg, if dndy != nullptr: dndy.Color else: ipGetStyle().colors[ImPlotCol.AxisBg.int])
    ipSetupAxis(ImAxis.Y1, if dndy == nullptr: "[drop here]".cstring else: dndy.Label.ptz.cstringCast, flags)
    ipPopStyleColor(2)
    if dndx != nullptr and dndy != nullptr:
      var mixed = ImVec4(x: (dndx.Color.x + dndy.Color.x)/2
        , y: (dndx.Color.y + dndy.Color.y)/2
        , z: (dndx.Color.z + dndy.Color.z)/2
        , w: (dndx.Color.w + dndy.Color.w)/2)
      ipSetNextLineStyle(mixed)
      ipPlotLine("##dndxy", dndx.Data[0].y.addr
        , dndy.Data[0].y.addr
        , dndx.Data.len, 0.ImPlotLineFlags, 0, 2 * sizeof(float))
    #// allow the x-axis to be a DND target
    if ipBeginDragDropTargetAxis(ImAxis.X1):
      let payload = igAcceptDragDropPayload("MY_DND")
      if not payload.isNil:
        var i = cast[ptr int](payload.data)[]; dndx = dnd[i]
      ipEndDragDropTarget()

    #// allow the x-axis to be a DND source
    if dndx != nullptr and ipBeginDragDropSourceAxis(ImAxis.X1):
      igSetDragDropPayload("MY_DND", dndx.Idx.addr, sizeof(int).uint)
      ipItemIcon(dndx.Color); igSameLine()
      igTextUnformatted(dndx.Label.ptz.cstringCast)
      ipEndDragDropSource()
    #// allow the y-axis to be a DND target
    if ipBeginDragDropTargetAxis(ImAxis.Y1):
      let payload = igAcceptDragDropPayload("MY_DND")
      if not payload.isNil:
        var i = cast[ptr int](payload.data)[]; dndy = dnd[i]
      ipEndDragDropTarget()

    #// allow the y-axis to be a DND source
    if dndy != nullptr and ipBeginDragDropSourceAxis(ImAxis.Y1):
      igSetDragDropPayload("MY_DND", dndy.Idx.addr, sizeof(int).uint)
      ipItemIcon(dndy.Color); igSameLine()
      igTextUnformatted(dndy.Label.ptz.cstringCast)
      ipEndDragDropSource()

    #// allow the plot area to be a DND target
    if ipBeginDragDropTargetPlot():
      let payload = igAcceptDragDropPayload("MY_DND")
      if not payload.isNil:
        var i = cast[ptr int](payload.data)[]
        dndx = dnd[i]
        dndy = dnd[i]

    #// allow the plot area to be a DND source
    if ipBeginDragDropSourcePlot():
      igTextUnformatted("Yes, you can\ndrag this!")
      ipEndDragDropSource()

  igEndChild()
