import imgui
import implot
import utils

#-----------------------------
# demo_Tools_ColormapWidgets() {
#-----------------------------
proc demo_Tools_ColormapWidgets*() =
  var cmap{.global.} = ImPlotColormap.Viridis

  if ipColormapButton("Button",ImVec2(x: 0,y: 0),cmap):
    cmap = cast[ImPlotColormap]( (cmap.uint32 + 1) mod ipGetColormapCount().uint32 )
  var
    t  {.global.} = 0.5f
    col{.global.} = ImVec4()
  igColorButton("##Display",col,ImGuiColorEditFlags.NoInputs)
  igSameLine()
  ipColormapSlider("Slider", t.addr, col.addr, "%.3f", cmap)

  ipColormapIcon(cmap);igSameLine();igText("Icon")
  var
    flags{.global.} = 0.ImPlotColormapScaleFlags
    scale{.global.} = [0.cfloat, 100]
  ipColormapScale("Scale",scale[0].cdouble,scale[1].cdouble,ImVec2(x: 0,y: 0),"%g dB",flags,cmap)
  igInputFloat2("Scale",scale)
  CHECKBOX_FLAG(flags, ImPlotColormapScaleFlags.NoLabel)
  CHECKBOX_FLAG(flags, ImPlotColormapScaleFlags.Opposite)
  CHECKBOX_FLAG(flags, ImPlotColormapScaleFlags.Invert)
