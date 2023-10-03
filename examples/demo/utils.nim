import std/[math]
import imgui
import implot
import std/random
export random.rand

#----------
# snprintf
#----------
#proc snprintf*(s: cstring, n: cint, fmt: cstring, count: cint): cint {.importc,
proc snprintf*(s: cstring): cint {.importc,
    header: "<stdio.h>", varargs.}

const IMPLOT_AUTO_COL* = ImVec4(x: 0, y: 0, z: 0, w: -1)

#define CHECKBOX_FLAG(flags, flag) ImGui::CheckboxFlags(#flag, (unsigned int*)&flags, flag)
template CHECKBOX_FLAG*(flags,flag:untyped) =
  igCheckboxFlags(($flag).cstring,flags.pu32,flag.uint32)

const RAND_MAX* = 0x7FFF.int
template RandomRange*[T](vmin, vmax: T): T =
  let scale: T = T(rand(RAND_MAX)) / T(RAND_MAX)
  vmin + scale * (vmax - vmin)

proc RandomColor*(): ImVec4 =
  result.x = RandomRange(0.0f,1.0f)
  result.y = RandomRange(0.0f,1.0f)
  result.z = RandomRange(0.0f,1.0f)
  result.w = 1.0f

#// utility structure for realtime plot
#-----------------
# ScrollingBuffer TODO: Memory managemant
#-----------------
type
  ScrollingBuffer*  {.bycopy.} = object
    MaxSize*: int32
    Offset*: int32
    Data*: seq[ImVec2]

proc newScrollingBuffer*(max_size: int32 = 2000): ScrollingBuffer =
  #result.new
  result.MaxSize = max_size
  result.Offset = 0
  result.Data = newSeqOfCap[ImVec2](max_size)

proc AddPoint*(self: var ScrollingBuffer, x, y: cfloat) =
  if self.Data.len < self.MaxSize:
    self.Data.add ImVec2(x: x, y: y)
  else:
    self.Data[self.Offset] = ImVec2(x: x, y: y)
    self.Offset = (self.Offset + 1) mod self.MaxSize

proc Erase*(self: var ScrollingBuffer) =
  if self.Data.len > 0:
    self.Data = @[] #self.Data.shrink(0); TODO
    self.Offset = 0

#// utility structure for realtime plot
#---------------
# RollingBuffer     TODO: Memory mangagement
#---------------
type
  RollingBuffer*  {.bycopy.} = object
    Span*: cfloat
    Data*: seq[ImVec2]

proc newRollingBuffer*(): RollingBuffer =
  #result.new
  result.Span = 10.0f
  result.Data = newSeqOfCap[ImVec2](2000)

proc AddPoint*(self: var RollingBuffer, x, y: cfloat) =
  var xmod = x mod self.Span
  if (self.Data.len > 0) and (xmod < self.Data[self.Data.len - 1].x):
    self.Data = @[] #self.Data.shrink(0); TODO
  self.Data.add ImVec2(x: xmod, y: y)

#-----------
# sparkline
#-----------
proc sparkline*(id: cstring, values: ptr cfloat, count: int32, min_v: cfloat,
                  max_v: cfloat, offset: int32, col: ImVec4, size: ImVec2) =
  ipPushStyleVar(ImPlotStyleVar.PlotPadding, ImVec2(x: 0, y: 0))
  if ipBeginPlot(id, size, ImPlotFlags.CanvasOnly or ImPlotFlags.NoChild):
    defer: ipEndPlot()
    ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations,
        ImPlotAxisFlags.NoDecorations)
    ipSetupAxesLimits(0, (count - 1).cdouble, min_v, max_v, ImPlotCond.Always)
    ipSetNextLineStyle(col)
    ipSetNextFillStyle(col, 0.25)
    ipPlotLine(id, values, count, 1, 0, ImPlotLineFlags.Shaded, offset)
  ipPopStyleVar()

#[ from cimplot.h
  //ImPlotPoint getters manually wrapped use this
  typedef void *(*ImPlotPoint_getter)(void* data, int idx, ImPlotPoint *point)
]#

type
  WaveData* {.bycopy.} =  object
    X*, Amp*, Freq*, Offset*: cdouble

#----------
# Sinewave
#----------
proc Sinewave*(data: pointer, idx: cint, point: ptr ImPlotPoint): pointer {.cdecl.} =
  let f = cast[ptr cfloat](data)[]
  point.x = idx.cfloat
  point.y = sin(f * idx.cfloat)

#-----------
# Sinewave2
#-----------
proc Sinewave2*(data: pointer, idx: cint, point: ptr ImPlotPoint): pointer {.cdecl.} =
  let wd = cast[ptr WaveData](data)[]
  let x = idx.cdouble * wd.X
  point.x = x
  point.y = wd.Offset + wd.Amp * sin(2 * 3.14 * wd.Freq * x)

#-----------
# SawWave()
#-----------
proc SawWave*(data: pointer, idx: cint, point: ptr ImPlotPoint): pointer {.cdecl.} =
  let wd = cast[ptr WaveData](data)[]
  let x = idx.cdouble * wd.X
  point.x = x
  point.y = wd.Offset + wd.Amp * (-2 / 3.14 * arctan(cos(3.14 * wd.Freq * x) / sin(3.14 * wd.Freq * x)))

#--------------
# FindCentroid
#--------------
proc FindCentroid*(data: seq[ImPlotPoint], bounds:ImPlotRect , cnt: var int): ImPlotPoint =
  var
    avg: ImPlotPoint
    bounds_fixed: ImPlotRect
  cnt = 0
  bounds_fixed.x.min = if bounds.x.min < bounds.x.max : bounds.x.min else: bounds.x.max
  bounds_fixed.x.max = if bounds.x.min < bounds.x.max : bounds.x.max else: bounds.x.min
  bounds_fixed.y.min = if bounds.y.min < bounds.y.max : bounds.y.min else: bounds.y.max
  bounds_fixed.y.max = if bounds.y.min < bounds.y.max : bounds.y.max else: bounds.y.min
  for i in  0..<data.len:
    if contains(bounds_fixed.addr,data[i].x, data[i].y):
      avg.x += data[i].x
      avg.y += data[i].y
      cnt.inc
  if cnt > 0:
    avg.x = avg.x / cnt.cdouble
    avg.y = avg.y / cnt.cdouble
  return avg

#----------------
# StyleSeaborn
#----------------
proc StyleSeaborn*() =
  const ImVec4 = proc(x: float32, y: float32, z: float32, w: float32): ImVec4 = ImVec4(x: x, y: y, z: z, w: w)
  const ImVec2 = proc(x: float32, y: float32): ImVec2 = ImVec2(x: x, y: y)
  var style                                    = ipGetStyle()

  style.colors[Line.uint32]                    = IMPLOT_AUTO_COL
  style.colors[Fill.uint32]                    = IMPLOT_AUTO_COL
  style.colors[MarkerOutline.uint32]           = IMPLOT_AUTO_COL
  style.colors[MarkerFill.uint32]              = IMPLOT_AUTO_COL
  style.colors[ErrorBar.uint32]                = ImVec4(0.00f, 0.00f, 0.00f, 1.00f)
  style.colors[ImPlotCol.FrameBg.uint32]       = ImVec4(1.00f, 1.00f, 1.00f, 1.00f)
  style.colors[PlotBg.uint32]                  = ImVec4(0.92f, 0.92f, 0.95f, 1.00f)
  style.colors[PlotBorder.uint32]              = ImVec4(0.00f, 0.00f, 0.00f, 0.00f)
  style.colors[LegendBg.uint32]                = ImVec4(0.92f, 0.92f, 0.95f, 1.00f)
  style.colors[LegendBorder.uint32]            = ImVec4(0.80f, 0.81f, 0.85f, 1.00f)
  style.colors[LegendText.uint32]              = ImVec4(0.00f, 0.00f, 0.00f, 1.00f)
  style.colors[TitleText.uint32]               = ImVec4(0.00f, 0.00f, 0.00f, 1.00f)
  style.colors[InlayText.uint32]               = ImVec4(0.00f, 0.00f, 0.00f, 1.00f)
  style.colors[AxisText.uint32]                = ImVec4(0.00f, 0.00f, 0.00f, 1.00f)
  style.colors[AxisGrid.uint32]                = ImVec4(1.00f, 1.00f, 1.00f, 1.00f)
  style.colors[AxisBgHovered.uint32]           = ImVec4(0.92f, 0.92f, 0.95f, 1.00f)
  style.colors[AxisBgActive.uint32]            = ImVec4(0.92f, 0.92f, 0.95f, 0.75f)
  style.colors[Selection.uint32]               = ImVec4(1.00f, 0.65f, 0.00f, 1.00f)
  style.colors[ImPlotCol.Crosshairs.uint32]    = ImVec4(0.23f, 0.10f, 0.64f, 0.50f)

  style.lineWeight       = 1.5
  style.marker           = ImPlotMarker.None.int
  style.markerSize       = 4
  style.markerWeight     = 1
  style.fillAlpha        = 1.0f
  style.errorBarSize     = 5
  style.errorBarWeight   = 1.5f
  style.digitalBitHeight = 8
  style.digitalBitGap    = 4
  style.plotBorderSize   = 0
  style.minorAlpha       = 1.0f
  style.majorTickLen     = ImVec2(0, 0)
  style.minorTickLen     = ImVec2(0, 0)
  style.majorTickSize    = ImVec2(0, 0)
  style.minorTickSize    = ImVec2(0, 0)
  style.majorGridSize    = ImVec2(1.2f, 1.2f)
  style.minorGridSize    = ImVec2(1.2f, 1.2f)
  style.plotPadding      = ImVec2(12, 12)
  style.labelPadding     = ImVec2(5, 5)
  style.legendPadding    = ImVec2(5, 5)
  style.mousePosPadding  = ImVec2(5, 5)
  style.plotMinSize      = ImVec2(300, 225)

#--------------
# BinarySearch
#--------------
proc BinarySearch*[T](arr:openArray[T], l:int, r:int,  x:T):int =
    if r >= l:
      var mid = l + (r - l) div 2
      if arr[mid] == x:
          return mid
      if arr[mid] > x:
          return BinarySearch(arr, l, mid - 1, x);
      return BinarySearch(arr, mid + 1, r, x);
    return -1

type ImU32 = cuint
# convert RR,GG,BB,AA -> AA,BB,GG,RR
template ImCol32*(r, g, b, a: untyped): ImU32 =
  (a.uint32 shl 24) or (b.uint32 shl 16) or (g.uint32 shl 8) or r.uint32
# convert RR,GG,BB -> AA,BB,GG,RR
template ImCol32*(r, g, b: untyped): ImU32{.used.} =
  (0xff.uint32 shl 24) or (b.uint32 shl 16) or (g.uint32 shl 8) or r.uint32

#-----------------
# PlotCandlestick
#-----------------
proc PlotCandlestick*(label_id:cstring, xs: openArray[cdouble], opens: openArray[cdouble], closes: openArray[cdouble], lows: openArray[cdouble], highs: openArray[cdouble], count:int, tooltip: bool, width_percent: cfloat, bullCol: ImVec4, bearCol: ImVec4) = #// get ImGui window DrawList
  var draw_list = ipGetPlotDrawList()
  #// calc real value width
  var half_width:cdouble = if count > 1 : (xs[1] - xs[0]) * width_percent.cdouble
                           else: width_percent.cdouble
  #// custom tool
  if ipIsPlotHovered() and tooltip:
    var mouse:ImPlotPoint
    ipGetPlotMousePosNonUDT(mouse.addr)
    var tm,tm2:ImPlotTime
    fromDoubleNonUDT(tm2.addr,mouse.x)
    ipRoundTimeNonUDT(tm.addr,tm2, ImPlotTimeUnit.Day)
    mouse.x             = tm.addr.toDouble()
    var pt:ImVec2
    ipPlotToPixelsNonUDT2(pt.addr,mouse.x - half_width * 1.5, mouse.y)
    var tool_l       = pt.x
    ipPlotToPixelsNonUDT2(pt.addr,mouse.x + half_width * 1.5, mouse.y)
    var tool_r       = pt.x
    ipGetPlotPosNonUDT(pt.addr)
    var tool_t       = pt.y
    ipGetPlotSizeNonUDT(pt.addr)
    var  tool_b       = tool_t + pt.y
    ipPushPlotClipRect()
    draw_list.addRectFilled(ImVec2(x: tool_l, y: tool_t), ImVec2(x: tool_r, y: tool_b), IM_COL32(128,128,128,64))
    ipPopPlotClipRect()
    #// find mouse location index
    var idx = BinarySearch(xs, 0, count - 1, mouse.x)
    #// render tool tip (won't be affected by plot clip rect)
    if idx != -1:
      igBeginTooltip()
      var buff:array[32,cchar]
      var tm:ImPlotTime
      fromDoubleNonUDT(tm.addr,xs[idx])
      ipFormatDate(tm,buff.ptz.cstringCast,32,ImPlotDateFmt.DayMoYr,ipGetStyle().useISO8601)
      igText("Day:   %s",  buff)
      igText("Open:  $%.2f", opens[idx])
      igText("Close: $%.2f", closes[idx])
      igText("Low:   $%.2f", lows[idx])
      igText("High:  $%.2f", highs[idx])
      igEndTooltip()

  #// begin plot item
  if ipBeginItem(label_id):
    defer: ipEndItem()
    #// override legend icon color
    ipGetCurrentItem().color = IM_COL32(64,64,64,255)
    #// fit data if requested
    if ipFitThisFrame():
      for i in 0..<count:
        ipFitPoint(ImPlotPoint(x: xs[i], y: lows[i]))
        ipFitPoint(ImPlotPoint(x: xs[i], y: highs[i]))
    #// render data
    for i in 0..<count:
      var open_pos :ImVec2
      ipPlotToPixelsNonUDT2(open_pos.addr, xs[i] - half_width, opens[i])
      var close_pos:ImVec2
      ipPlotToPixelsNonUDT2(close_pos.addr, xs[i] + half_width, closes[i])
      var low_pos  :ImVec2
      ipPlotToPixelsNonUDT2(low_pos.addr, xs[i], lows[i])
      var high_pos :ImVec2
      ipPlotToPixelsNonUDT2(high_pos.addr,xs[i], highs[i])
      var color =  igGetColorU32(if opens[i] > closes[i] : bearCol else: bullCol)
      draw_list.addLine(low_pos, high_pos, color)
      draw_list.addRectFilled(open_pos, close_pos, color)

#-----------------
# MetricFormatter
#-----------------
var MetricFormatter* = proc(value:cdouble, buff:cstring, size:int, data:pointer): int {.cdecl.} =
  var unit = cast[ptr cchar](data)
  var v    = [1000000000.cdouble,1000000,1000,1,0.001,0.000001,0.000000001]
  const  p = ["G".cstring,"M","k","","m","u","n"]
  if value == 0:
    return snprintf(buff,size.cint,"0 %s", unit);
  for i in 0..<7:
    if abs(value) >= v[i]:
      return snprintf(buff,size,"%g %s%s",value/v[i],p[i],unit);
  return snprintf(buff,size,"%g %s%s",value/v[6],p[6],unit);
