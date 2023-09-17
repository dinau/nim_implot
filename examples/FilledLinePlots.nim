import std/[random]
import imgui
import implot
import utils

#------------------------
# demo_FilledLinePlots()
#------------------------
proc demo_FilledLinePlots*() =
  var
    xs1{.global.}: array[101, double]
    ys1{.global.}: array[101, double]
    ys2{.global.}: array[101, double]
    ys3{.global.}: array[101, double]

  randomize(0) # srand(0) : C++
  for i in 0..<101:
    xs1[i] = (float)i
    ys1[i] = RandomRange(400.0, 450.0)
    ys2[i] = RandomRange(275.0, 350.0)
    ys3[i] = RandomRange(150.0, 225.0)
  var
    show_lines{.global.} = true
    show_fills{.global.} = true
    fill_ref{.global.} = 0.float32
    shade_mode{.global.} = 0
    flags{.global.} = 0.ImPlotShadedFlags

  igCheckbox("Lines", addr show_lines)
  igSameLine()
  igCheckbox("Fills", addr show_fills)
  if show_fills:
    igSameLine()
    if igRadioButton("To -INF", shade_mode == 0): shade_mode = 0
    igSameLine()
    if igRadioButton("To +INF", shade_mode == 1): shade_mode = 1
    igSameLine()
    if igRadioButton("To Ref", shade_mode == 2): shade_mode = 2
    if shade_mode == 2:
      igSameLine()
      igSetNextItemWidth(100)
      igDragFloat("##Ref", addr fill_ref, 1, -100, 500)

  if ipBeginPlot("Stock Prices"):
    ipSetupAxes("Days", "Price")
    ipSetupAxesLimits(0, 100, 0, 500)
    if show_fills:
      ipPushStyleVar(ImPlotStyleVar.FillAlpha, 0.25f)
      ipPlotShaded("Stock 1", addr xs1[0], addr ys1[0], 101
        , if shade_mode == 0: -Inf
                 else:
                   if shade_mode == 1: Inf
                   else: fill_ref
               , flags)
      ipPlotShaded("Stock 2", addr xs1[0], addr ys2[0], 101
        , if shade_mode == 0: -Inf
                 else:
                   if shade_mode == 1: Inf
                   else: fill_ref
               , flags)
      ipPlotShaded("Stock 3", addr xs1[0], addr ys3[0], 101
        , if shade_mode == 0: -Inf
                 else:
                   if shade_mode == 1: Inf
                   else: fill_ref
               , flags)
      ipPopStyleVar()

    if show_lines:
      ipPlotLine("Stock 1", addr xs1[0], addr ys1[0], 101)
      ipPlotLine("Stock 2", addr xs1[0], addr ys2[0], 101)
      ipPlotLine("Stock 3", addr xs1[0], addr ys3[0], 101)

    ipEndPlot()
