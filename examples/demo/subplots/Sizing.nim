import imgui
import implot
import utils
template ptn*[T](v: T): untyped = cast[ptr T](v.addr)
template puint32*(v: uint32): untyped = cast[ptr uint32](v.addr)

#-----------------------
# demo_Subplots_Sizing()
#-----------------------
proc demo_Subplots_Sizing*() =
  var flags{.global.} = ImPlotSubplotFlags.None
  igCheckboxFlags("ImPlotSubplotFlags_NoResize", flags.pu32, ImPlotSubplotFlags.NoResize.uint32)
  igCheckboxFlags("ImPlotSubplotFlags_NoTitle ", flags.pu32, ImPlotSubplotFlags.NoTitle.uint32)
  var
    rows{.global.} = 3.int32
    cols{.global.} = 3.int32
  igSliderInt("Rows", rows.addr, 1, 5)
  igSliderInt("Cols", cols.addr, 1, 5)
  if rows < 1 and cols < 1:
    igTextColored(ImVec4(x: 1, y: 0, z: 0, w: 1), "Nice try, but the number of rows and columns must be greater than 0!")
    return
  var
    rratios{.global.} = [5.float32, 1, 1, 1, 1, 1]
    cratios{.global.} = [5.float32, 1, 1, 1, 1, 1]
  igDragScalarN("Row Ratios", ImGuiDataType.Float, rratios.addr, rows, 0.01f, nullptr)
  igDragScalarN("Col Ratios", ImGuiDataType.Float, cratios.addr, cols, 0.01f, nullptr)
  if ipBeginSubplots("My Subplots", rows, cols, ImVec2(x: -1, y: 400), flags, rratios.ptz, cratios.ptz):
    defer: ipEndSubplots()
    for i in 0..<(rows * cols):
      if ipBeginPlot("", ImVec2(), ImPlotFlags.NoLegend):
        defer: ipEndPlot()
        ipSetupAxes(nullptr, nullptr, ImPlotAxisFlags.NoDecorations, ImPlotAxisFlags.NoDecorations)
        var fi = 0.01f * (i + 1).cfloat
        if (rows * cols ) > 1:
          var vec4: ImVec4
          ipSampleColormapNonUDT(vec4.addr, i.cfloat / (rows * cols - 1).cfloat, ImPlotColormap.Jet)
          ipSetNextLineStyle(vec4)
        ipPlotLineG("data", Sinewave, fi.addr, 1000) # fi must be cfloat type
