import imgui
import implot

#--------------------
# Demo_Annotations()
#--------------------
proc demo_Tools_Annotations*() =
  var clamp{.global.} = false
  igCheckbox("Clamp", clamp.addr)
  if ipBeginPlot("##Annotations"):
    defer: ipEndPlot()
    ipSetupAxesLimits(0, 2, 0, 1)
    var p{.global.} = [0.25f, 0.25f, 0.75f, 0.75f, 0.25f]
    ipPlotScatter("##Points", p.ptz, p.ptz, 4)
    var col: ImVec4
    ipGetLastItemColorNonUDT(col.addr)
    ipAnnotation(0.25, 0.25, col, ImVec2(x: -15, y: 15), clamp, "BL")
    ipAnnotation(0.75, 0.25, col, ImVec2(x: 15, y: 15), clamp, "BR")
    ipAnnotation(0.75, 0.75, col, ImVec2(x: 15, y: -15), clamp, "TR")
    ipAnnotation(0.25, 0.75, col, ImVec2(x: -15, y: -15), clamp, "TL")
    ipAnnotation(0.5, 0.5, col, ImVec2(), clamp, "Center")

    ipAnnotation(1.25, 0.75, ImVec4(x: 0, y: 1, z: 0, w: 1), ImVec2(), clamp)
    var
      bx = [1.2f, 1.5f, 1.8f]
      by = [0.25f, 0.5f, 0.75f]
    ipPlotBars("##Bars", bx.ptz, by.ptz, 3, 0.2)
    for i in 0..<3:
      ipAnnotation(bx[i], by[i], ImVec4(), ImVec2(x: 0, y: -5), clamp, "B[%d]=%.2f", i, by[i])
