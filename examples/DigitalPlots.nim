import imgui
import implot
import std/[strutils, math]

# utility structure for realtime plot

#-----------------
# ScrollingBuffer
#-----------------
type
  ScrollingBuffer = object
    MaxSize: int32
    Offset: int32
    Data: seq[ImVec2]

proc newScrollingBuffer(max_size: int32 = 2000): ScrollingBuffer =
  result = ScrollingBuffer(MaxSize: max_size
    , Offset: 0
    , Data: newSeqOfCap[ImVec2](max_size))

proc AddPoint(self: var ScrollingBuffer, x, y: float32) =
  if self.Data.len < self.MaxSize:
    self.Data.add(ImVec2(x: x, y: y))
  else:
    self.Data[self.Offset] = ImVec2(x: x, y: y)
    self.Offset = (self.Offset + 1) mod self.MaxSize
#[
proc Erase(self:var ScrollingBuffer) =
  if self.Data.len > 0:
#   self.Data.shrink(0)
    self.Offset = 0
]#

proc demo_DigitalPlots*() =
  var
    paused{.global.} = false
    dataDigital{.global.} = [newScrollingBuffer(), newScrollingBuffer()]
    dataAnalog{.global.} = [newScrollingBuffer(), newScrollingBuffer()]
    showDigital{.global.} = [true, false]
    showAnalog{.global.} = [true, false]

  igBulletText("Digital plots do not respond to Y drag and zoom, so that");
  igIndent();
  igText("you can drag analog plots over the rising/falling digital edge.");
  igUnindent();

  var label: string # char[32]
  igCheckbox("digital_0", addr showDigital[0])
  igSameLine()
  igCheckbox("digital_1", addr showDigital[1])
  igSameLine()
  igCheckbox("analog_0", addr showAnalog[0])
  igSameLine()
  igCheckbox("analog_1", addr showAnalog[1])

  var t{.global.} = 0.float32
  if not paused:
    t += igGetIO().deltaTime
    #//digital signal values
    if showDigital[0]:
      dataDigital[0].AddPoint(t, (sin(2*t) > 0.45).int.tofloat)
    if showDigital[1]:
      dataDigital[1].AddPoint(t, (sin(2*t) < 0.45).int.tofloat)
    # //Analog signal values
    if showAnalog[0]:
      dataAnalog[0].AddPoint(t, sin(2*t))
    if showAnalog[1]:
      dataAnalog[1].AddPoint(t, cos(2*t))

  if ipBeginPlot("##Digital"):
    defer: ipEndPlot()
    ipSetupAxisLimits(ImAxis.X1, (t - 10.0).cfloat64, t.cfloat64
      , (if paused: ImPlotCond.Once else: ImPlotCond.Always))
    ipSetupAxisLimits(ImAxis.Y1, -1.cfloat64, 1.cfloat64)
    for i in 0..<2:
      if showDigital[i] and (dataDigital[i].Data.len() > 0):
        label = "digital_$#" % [$i]
        ipPlotDigital(label.cstring
          , addr dataDigital[i].Data[0].x
          , addr dataDigital[i].Data[0].y
          , dataDigital[i].Data.len()
          , 0.ImPlotDigitalFlags
          , dataDigital[i].Offset
          , 2 * sizeof(float32))
    for i in 0..<2:
      if showAnalog[i]:
        label = "analog_$#" % [$i]
        if dataAnalog[i].Data.len() > 0:
          ipPlotLine(label.cstring
            , addr dataAnalog[i].Data[0].x
            , addr dataAnalog[i].Data[0].y
            , dataAnalog[i].Data.len()
            , 0.ImPlotLineFlags
            , dataAnalog[i].Offset
            , 2 * sizeof(float32))
