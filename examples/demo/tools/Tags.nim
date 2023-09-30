import imgui
import implot

#------------------
# Demo_Tools_Tags()
#------------------
proc demo_Tools_Tags*() =
  var
    show{.global.} = true
  igCheckbox("Show Tags",show.addr)
  if ipBeginPlot("##Tags"):
    defer: ipEndPlot()
    ipSetupAxis(ImAxis.X2)
    ipSetupAxis(ImAxis.Y2)
    if show:
      ipTagX(0.25, ImVec4(x: 1,y: 1,z: 0,w: 1))
      ipTagY(0.75, ImVec4(x: 1,y: 1,z: 0,w: 1))
      var drag_tag{.global.} = 0.25.cdouble
      ipDragLineY(0,drag_tag.addr,ImVec4(x: 1,y: 0,z: 0,w: 1),1,ImPlotDragToolFlags.NoFit)
      ipTagY(drag_tag, ImVec4(x: 1,y: 0,z: 0,w: 1), "Drag")
      ipSetAxes(ImAxis.X2, ImAxis.Y2)
      ipTagX(0.5, ImVec4(x: 0,y: 1,z: 1,w: 1), "%s", "MyTag")
      ipTagY(0.5, ImVec4(x: 0,y: 1,z: 1,w: 1), "Tag: %d", 42)
