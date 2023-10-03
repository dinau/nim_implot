import imgui
import implot
import utils

#------------------------
# demo_CustomRendering()
#------------------------
proc demo_Custom_CustomRendering*() =
  if ipBeginPlot("##CustomRend"):
    var vec2:ImVec2
    ipPlotToPixelsNonUDT(vec2.addr,ImPlotPoint(x: 0.5f, y: 0.5f))
    var cntr = vec2
    ipPlotToPixelsNonUDT(vec2.addr,ImPlotPoint(x: 0.25f, y: 0.75f))
    var rmin = vec2
    ipPlotToPixelsNonUDT(vec2.addr,ImPlotPoint(x: 0.75f, y: 0.25f))
    var rmax = vec2
    ipPushPlotClipRect()
    ipGetPlotDrawList().addCircleFilled(cntr,20,IM_COL32(255,255,0,255),20)
    ipGetPlotDrawList().addRect(rmin, rmax, IM_COL32(128,0,255,255))
    ipPopPlotClipRect()
    ipEndPlot()
