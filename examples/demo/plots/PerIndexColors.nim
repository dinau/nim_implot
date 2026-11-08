import std/[math]
import imgui
import implot
import utils

var msvcRandState {.global.}: uint32

proc msvcSrand(seed: uint32) =
  msvcRandState = seed

proc msvcRand(): cfloat =
  msvcRandState = msvcRandState * 214013'u32 + 2531011'u32
  result = ((msvcRandState shr 16) and 0x7FFF'u32).cfloat

proc msvcRandUnit(): cfloat =
  msvcRand() / 32767'f32

proc hueColor(hue: float32, saturation = 0.8'f32, value = 0.9'f32): uint32 =
  igColorConvertFloat4ToU32(hSVNonUDT(hue, saturation, value).value)

proc colormapColor(t: float32, colormap: ImPlotColormap): uint32 =
  var color: ImVec4
  ipSampleColormapNonUDT(addr color, t, colormap)
  igGetColorU32(color)

proc demo_PerIndexColors*() =
  var
    xsLine {.global.}: array[1001, cfloat]
    ysLine {.global.}: array[1001, cfloat]
    lineColors {.global.}: array[1001, uint32]
    xsShort {.global.}: array[20, cdouble]
    ysShort {.global.}: array[20, cdouble]
    shortColors {.global.}: array[20, uint32]
    xsShade {.global.}: array[1001, cfloat]
    ysShade {.global.}: array[1001, cfloat]
    ysShadeTop {.global.}: array[1001, cfloat]
    ysShadeBottom {.global.}: array[1001, cfloat]
    ysOverlap1 {.global.}: array[1001, cfloat]
    ysOverlap2 {.global.}: array[1001, cfloat]
    shadeColors {.global.}: array[1001, uint32]
    overlapColors {.global.}: array[1001, uint32]
    xsScatter {.global.}: array[100, cfloat]
    ysScatter {.global.}: array[100, cfloat]
    scatterFill {.global.}: array[100, uint32]
    scatterLine {.global.}: array[100, uint32]
    scatterSizes {.global.}: array[100, cfloat]
    xsScatter2 {.global.}: array[50, cfloat]
    ysScatter2 {.global.}: array[50, cfloat]
    scatterColors2 {.global.}: array[50, uint32]
    scatterSizes2 {.global.}: array[50, cfloat]
    xsBubble {.global.}: array[20, cfloat]
    ysBubble1 {.global.}: array[20, cfloat]
    ysBubble2 {.global.}: array[20, cfloat]
    bubbleSizes1 {.global.}: array[20, cfloat]
    bubbleSizes2 {.global.}: array[20, cfloat]
    bubbleColors1 {.global.}: array[20, uint32]
    bubbleColors2 {.global.}: array[20, uint32]
    barValues {.global.}: array[10, int8]
    barColorsVertical {.global.}: array[10, uint32]
    barColorsHorizontal {.global.}: array[10, uint32]
    ysStairs1 {.global.}: array[21, cfloat]
    ysStairs2 {.global.}: array[21, cfloat]
    stairsColors1 {.global.}: array[21, uint32]
    stairsColors2 {.global.}: array[21, uint32]
    stairsFlags {.global.}: ImPlotStairsFlags
    xsStems {.global.}: array[51, cdouble]
    ysStems1 {.global.}: array[51, cdouble]
    ysStems2 {.global.}: array[51, cdouble]
    stemColors1 {.global.}: array[51, uint32]
    stemColors2 {.global.}: array[51, uint32]
    horizontalLines {.global.}: array[8, cdouble]
    horizontalLineColors {.global.}: array[8, uint32]
    verticalLines {.global.}: array[6, cdouble]
    verticalLineColors {.global.}: array[6, uint32]
    constantLines {.global.}: array[5, cdouble]

  for i in 0 .. 1000:
    let x = i.cfloat * 0.001'f32
    xsLine[i] = x
    ysLine[i] = 0.5'f32 + 0.5'f32 * sin(50'f32 * (x + igGetTime().float32 / 10'f32))
    lineColors[i] = hueColor(i.cfloat / 1000'f32)

  for i in 0 .. 19:
    xsShort[i] = i.cdouble / 19
    ysShort[i] = xsShort[i] * xsShort[i]
    shortColors[i] = colormapColor(i.cfloat / 19'f32, ImPlotColormap.Viridis)

  for i in 0 .. 9:
    barValues[i] = (i + 1).int8
    barColorsVertical[i] = hueColor(i.cfloat / 9'f32)
    barColorsHorizontal[i] = colormapColor(i.cfloat / 9'f32, ImPlotColormap.Viridis)

  for i in 0 .. 20:
    let t = i.cfloat * 0.05'f32
    ysStairs1[i] = 0.75'f32 + 0.2'f32 * sin(10'f32 * t)
    ysStairs2[i] = 0.25'f32 + 0.2'f32 * sin(10'f32 * t)
    stairsColors1[i] = hueColor(i.cfloat / 20'f32)
    stairsColors2[i] = colormapColor(i.cfloat / 20'f32, ImPlotColormap.Viridis)

  for i in 0 .. 50:
    let x = i.cdouble * 0.02
    xsStems[i] = x
    ysStems1[i] = 1.0 + 0.5 * sin(25 * x) * cos(2 * x)
    ysStems2[i] = 0.5 + 0.25 * sin(10 * x) * sin(x)
    stemColors1[i] = hueColor(i.cfloat / 50'f32)
    stemColors2[i] = colormapColor(i.cfloat / 50'f32, ImPlotColormap.Viridis)

  for i in 0 .. 7:
    horizontalLines[i] = 1 + i.cdouble
    horizontalLineColors[i] = colormapColor(i.cfloat / 7'f32, ImPlotColormap.Jet)

  for i in 0 .. 5:
    verticalLines[i] = 1.5 + i.cdouble * 1.5
    verticalLineColors[i] = colormapColor(i.cfloat / 5'f32, ImPlotColormap.Plasma)

  constantLines = [1.0, 2.5, 4.0, 5.5, 7.0]
  CHECKBOX_FLAG(stairsFlags, ImPlotStairsFlags.Shaded)

  once:
    msvcSrand(0)
    for i in 0 .. 1000:
      let x = i.cfloat * 0.001'f32
      xsShade[i] = x
      ysShade[i] = 0.25'f32 + 0.25'f32 * sin(25'f32 * x) * sin(5'f32 * x) +
        (-0.01'f32 + msvcRand() / 32767'f32 * 0.02'f32)
      ysShadeTop[i] = ysShade[i] +
        0.1'f32 + msvcRand() / 32767'f32 * 0.02'f32
      ysShadeBottom[i] = ysShade[i] -
        (0.1'f32 + msvcRand() / 32767'f32 * 0.02'f32)
      ysOverlap1[i] = 0.75'f32 + 0.2'f32 * sin(25'f32 * x)
      ysOverlap2[i] = 0.75'f32 + 0.1'f32 * cos(25'f32 * x)
      shadeColors[i] = hueColor(i.cfloat / 1000'f32)
      overlapColors[i] = colormapColor(i.cfloat / 1000'f32, ImPlotColormap.Viridis)

    msvcSrand(0)
    for i in 0 .. 99:
      xsScatter[i] = i.cfloat * 0.01'f32
      ysScatter[i] = xsScatter[i] + 0.1'f32 * msvcRandUnit()
      scatterFill[i] = hueColor(i.cfloat / 99'f32)
      scatterLine[i] = hueColor(i.cfloat / 99'f32, 0.9'f32, 0.7'f32)
      scatterSizes[i] = 2'f32 + 4'f32 * msvcRandUnit()

    for i in 0 .. 49:
      xsScatter2[i] = 0.25'f32 + 0.2'f32 * msvcRandUnit()
      ysScatter2[i] = 0.75'f32 + 0.2'f32 * msvcRandUnit()
      scatterColors2[i] = colormapColor(i.cfloat / 49'f32, ImPlotColormap.Viridis)
      scatterSizes2[i] = 2'f32 + 4'f32 * msvcRandUnit()

    msvcSrand(0)
    for i in 0 .. 19:
      xsBubble[i] = i.cfloat * 0.1'f32
      ysBubble1[i] = msvcRandUnit()
      ysBubble2[i] = msvcRandUnit()
      bubbleSizes1[i] = 0.02'f32 + 0.08'f32 * msvcRandUnit()
      bubbleSizes2[i] = 0.02'f32 + 0.08'f32 * msvcRandUnit()
      bubbleColors1[i] = hueColor(i.cfloat / 19'f32)
      bubbleColors2[i] = colormapColor(i.cfloat / 19'f32, ImPlotColormap.Viridis)

  if ipBeginPlot("Colorful Lines"):
    defer: ipEndPlot()
    ipSetupAxes("x", "y")
    var lineSpec = initImPlotSpec()
    lineSpec.lineColors = lineColors.ptz
    ipPlotLine_spec("f(x)", xsLine.ptz, ysLine.ptz, 1001, lineSpec)
    var pointSpec = initImPlotSpec()
    pointSpec.marker = ImPlotMarker.Circle
    pointSpec.flags = cast[ImPlotItemFlags](ImPlotLineFlags.Segments)
    pointSpec.lineColors = shortColors.ptz
    pointSpec.markerFillColors = shortColors.ptz
    pointSpec.markerLineColors = shortColors.ptz
    ipPlotLine_spec("g(x)", xsShort.ptz, ysShort.ptz, 20, pointSpec)

  if ipBeginPlot("Colorful Shaded Plots"):
    defer: ipEndPlot()
    ipSetupLegend(ImPlotLocation.NorthWest, ImPlotLegendFlags.Reverse)
    var shadeSpec = initImPlotSpec()
    shadeSpec.fillAlpha = 0.25'f32
    shadeSpec.fillColors = shadeColors.ptz
    ipPlotShaded_spec("Uncertain Data", xsShade.ptz, ysShadeTop.ptz,
      ysShadeBottom.ptz, 1001, shadeSpec)
    var lineSpec = initImPlotSpec()
    lineSpec.lineColors = shadeColors.ptz
    ipPlotLine_spec("Uncertain Data", xsShade.ptz, ysShade.ptz, 1001, lineSpec)
    shadeSpec.fillColors = overlapColors.ptz
    ipPlotShaded_spec("Overlapping", xsShade.ptz, ysOverlap1.ptz,
      ysOverlap2.ptz, 1001, shadeSpec)
    lineSpec.lineColors = overlapColors.ptz
    ipPlotLine_spec("Overlapping", xsShade.ptz, ysOverlap1.ptz, 1001, lineSpec)
    ipPlotLine_spec("Overlapping", xsShade.ptz, ysOverlap2.ptz, 1001, lineSpec)

  if ipBeginPlot("Colorful Scatter", ImVec2(x: -1, y: 0)):
    defer: ipEndPlot()
    var firstSpec = initImPlotSpec()
    firstSpec.markerFillColors = scatterFill.ptz
    firstSpec.markerLineColors = scatterLine.ptz
    firstSpec.markerSizes = scatterSizes.ptz
    ipPlotScatter_spec("Data 1", xsScatter.ptz, ysScatter.ptz, 100, firstSpec)
    var secondSpec = initImPlotSpec()
    secondSpec.marker = ImPlotMarker.Square
    secondSpec.markerFillColors = scatterColors2.ptz
    secondSpec.markerLineColors = scatterColors2.ptz
    secondSpec.markerSizes = scatterSizes2.ptz
    secondSpec.fillAlpha = 0.5'f32
    ipPlotScatter_spec("Data 2", xsScatter2.ptz, ysScatter2.ptz, 50, secondSpec)

  if ipBeginPlot("Colorful Bubbles", ImVec2(x: -1, y: 0), ImPlotFlags.Equal):
    defer: ipEndPlot()
    var firstSpec = initImPlotSpec()
    firstSpec.fillAlpha = 0.5'f32
    firstSpec.fillColors = bubbleColors1.ptz
    firstSpec.lineColors = bubbleColors1.ptz
    ipPlotBubbles_spec("Data 1", xsBubble.ptz, ysBubble1.ptz,
      bubbleSizes1.ptz, 20, firstSpec)
    var secondSpec = initImPlotSpec()
    secondSpec.fillAlpha = 0.5'f32
    secondSpec.lineColor = ImVec4(x: 0, y: 0, z: 0, w: 0)
    secondSpec.fillColors = bubbleColors2.ptz
    ipPlotBubbles_spec("Data 2", xsBubble.ptz, ysBubble2.ptz,
      bubbleSizes2.ptz, 20, secondSpec)

  if ipBeginPlot("Colorful Stairstep Plot"):
    defer: ipEndPlot()
    ipSetupAxes("x", "f(x)")
    ipSetupAxesLimits(0, 1, 0, 1)
    var lineSpec = initImPlotSpec()
    lineSpec.lineColor = ImVec4(x: 0.5'f32, y: 0.5'f32, z: 0.5'f32, w: 1)
    ipPlotLine_spec("##1", ysStairs1.ptz, 21, 0.05, 0, lineSpec)
    ipPlotLine_spec("##2", ysStairs2.ptz, 21, 0.05, 0, lineSpec)
    var postSpec = initImPlotSpec()
    postSpec.flags = cast[ImPlotItemFlags](stairsFlags)
    postSpec.fillAlpha = 0.25'f32
    postSpec.marker = ImPlotMarker.Auto
    postSpec.lineColors = stairsColors1.ptz
    postSpec.fillColors = stairsColors1.ptz
    postSpec.markerFillColors = stairsColors1.ptz
    postSpec.markerLineColors = stairsColors1.ptz
    ipPlotStairs_spec("Post Step (default)", ysStairs1.ptz, 21, 0.05, 0, postSpec)
    var preSpec = initImPlotSpec()
    preSpec.flags = cast[ImPlotItemFlags](stairsFlags or ImPlotStairsFlags.PreStep)
    preSpec.fillAlpha = 0.25'f32
    preSpec.marker = ImPlotMarker.Auto
    preSpec.lineColors = stairsColors2.ptz
    preSpec.fillColors = stairsColors2.ptz
    preSpec.markerFillColors = stairsColors2.ptz
    preSpec.markerLineColors = stairsColors2.ptz
    ipPlotStairs_spec("Pre Step", ysStairs2.ptz, 21, 0.05, 0, preSpec)

  if ipBeginPlot("Colorful Bar Plot"):
    defer: ipEndPlot()
    var verticalSpec = initImPlotSpec()
    verticalSpec.fillColors = barColorsVertical.ptz
    verticalSpec.lineColors = barColorsVertical.ptz
    ipPlotBars_spec("Vertical", barValues.ptz, 10, 0.7, 1, verticalSpec)
    var horizontalSpec = initImPlotSpec()
    horizontalSpec.flags = cast[ImPlotItemFlags](ImPlotBarsFlags.Horizontal)
    horizontalSpec.fillColors = barColorsHorizontal.ptz
    horizontalSpec.lineColors = barColorsHorizontal.ptz
    ipPlotBars_spec("Horizontal", barValues.ptz, 10, 0.4, 1, horizontalSpec)

  if ipBeginPlot("Colorful Stem Plots"):
    defer: ipEndPlot()
    ipSetupAxisLimits(ImAxis.X1, 0, 1)
    ipSetupAxisLimits(ImAxis.Y1, 0, 1.6)
    var firstSpec = initImPlotSpec()
    firstSpec.lineColors = stemColors1.ptz
    firstSpec.markerFillColors = stemColors1.ptz
    firstSpec.markerLineColors = stemColors1.ptz
    ipPlotStems_spec("Stems 1", xsStems.ptz, ysStems1.ptz, 51, 0, firstSpec)
    var secondSpec = initImPlotSpec()
    secondSpec.marker = ImPlotMarker.Circle
    secondSpec.lineColors = stemColors2.ptz
    secondSpec.markerFillColors = stemColors2.ptz
    secondSpec.markerLineColors = stemColors2.ptz
    ipPlotStems_spec("Stems 2", xsStems.ptz, ysStems2.ptz, 51, 0, secondSpec)

  if ipBeginPlot("Colorful Infinite Lines", ImVec2(x: -1, y: 0)):
    defer: ipEndPlot()
    ipSetupAxes("x", "y")
    ipSetupAxesLimits(0, 10, -1, 10)
    var constantSpec = initImPlotSpec()
    constantSpec.lineColor = ImVec4(x: 0, y: 0.7'f32, z: 1, w: 1)
    ipPlotInfLines_spec("Const Color", constantLines.ptz, 5, constantSpec)
    var horizontalSpec = initImPlotSpec()
    horizontalSpec.lineColors = horizontalLineColors.ptz
    horizontalSpec.flags = cast[ImPlotItemFlags](ImPlotInfLinesFlags.Horizontal)
    ipPlotInfLines_spec("Rainbow Horizontal", horizontalLines.ptz, 8, horizontalSpec)
    var verticalSpec = initImPlotSpec()
    verticalSpec.lineColors = verticalLineColors.ptz
    ipPlotInfLines_spec("Plasma Vertical", verticalLines.ptz, 6, verticalSpec)
