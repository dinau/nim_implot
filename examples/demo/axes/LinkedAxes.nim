import imgui
import implot

#------------------------
# demo_Axes_LinkedAxes()
#------------------------
proc demo_Axes_LinkedAxes*() =
  var
    rx = ImPlotRange(min: 0,max: 1)
    ry = ImPlotRange(min: 0,max: 1)
    lims {.global.} : ImPlotRect
    linkx{.global.} = true
    linky{.global.} = true
    data = [0.int32,1]
  once:
    lims = ImPlotRect(x: rx,y: ry )

  igCheckbox("Link X", linkx.addr)
  igSameLine()
  igCheckbox("Link Y", linky.addr)

  igDragScalarN("Limits",ImGuiDataType.Double,lims.x.min.addr,4,0.01f)

  if ipBeginAlignedPlots("AlignedGroup"):
    defer: ipEndAlignedPlots()
    if ipBeginPlot("Plot A"):
      defer: ipEndPlot()
      ipSetupAxisLinks(ImAxis.X1, if linkx : lims.x.min.addr else: nullptr
                                , if linkx : lims.x.max.addr else: nullptr)
      ipSetupAxisLinks(ImAxis.Y1, if linky : lims.y.min.addr else: nullptr
                                , if linky : lims.y.max.addr else: nullptr)
      ipPlotLine("Line",data.ptz,2)
    if ipBeginPlot("Plot B"):
      defer: ipEndPlot()
      ipSetupAxisLinks(ImAxis.X1, if linkx : lims.x.min.addr else: nullptr
                                , if linkx : lims.x.max.addr else: nullptr)
      ipSetupAxisLinks(ImAxis.Y1, if linky : lims.y.min.addr else: nullptr
                                , if linky : lims.y.max.addr else: nullptr)
      ipPlotLine("Line",data.ptz,2)
