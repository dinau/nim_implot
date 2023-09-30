import std/[math]
import imgui
import implot

#--------------------------
# demo_ToolsLegendPopups()
#--------------------------
proc demo_Tools_LegendPopups*() =
  igBulletText("You can implement legend context menus to inject per-item controls and widgets.")
  igBulletText("Right click the legend label/icon to edit custom item attributes.")
  var
    frequency{.global.} = 0.1f
    amplitude{.global.} = 0.5f
    color    {.global.} = ImVec4(x: 1,y: 1,z: 0,w: 1)
    alpha    {.global.} = 1.0f
    line     {.global.} = false
    thickness{.global.} = 1.cfloat
    markers  {.global.} = false
    shaded   {.global.} = false

  var vals{.global.} :array[101,cfloat]
  for i in 0..<101:
    vals[i] = amplitude * sin(frequency * i.cfloat)

  if ipBeginPlot("Right Click the Legend"):
    defer: ipEndPlot()
    ipSetupAxesLimits(0,100,-1,1)
    #// rendering logic
    ipPushStyleVar(ImPlotStyleVar.FillAlpha, alpha)
    if not line:
      ipSetNextFillStyle(color)
      ipPlotBars("Right Click Me", vals.ptz, 101)
    else:
      if markers: ipSetNextMarkerStyle(ImPlotMarker.Square)
      ipSetNextLineStyle(color, thickness)
      ipPlotLine("Right Click Me", vals.ptz, 101)
      if shaded: ipPlotShaded("Right Click Me",vals.ptz,101)
    ipPopStyleVar()
    #// custom legend context menu
    if ipBeginLegendPopup("Right Click Me") :
      defer: ipEndLegendPopup()
      igSliderFloat("Frequency",frequency.addr,0,1,"%0.2f")
      igSliderFloat("Amplitude",amplitude.addr,0,1,"%0.2f")
      igSeparator()
      var col = [color.x,color.y,color.z]
      igColorEdit3("Color",col)
      color.x = col[0]; color.y = col[1]; color.z = col[2]
      igSliderFloat("Transparency",alpha.addr,0,1,"%.2f")
      igCheckbox("Line Plot", line.addr)
      if line:
        igSliderFloat("Thickness", thickness.addr, 0, 5)
        igCheckbox("Markers", markers.addr)
        igCheckbox("Shaded",shaded.addr)
