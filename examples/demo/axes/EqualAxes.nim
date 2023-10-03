import std/[math]
import imgui
import implot

#----------------------
# demo_Axes_EqualAxes()
#----------------------
proc demo_Axes_EqualAxes*() =
  igBulletText("Equal constraint applies to axis pairs (e.g ImAxis_X1/Y1, ImAxis_X2/Y2)")
  var
    xs1{.global.}:array[360,cdouble]
    ys1{.global.}:array[360,cdouble]
  once:
    for i in 0..<360:
      let angle = i.cfloat * 2 * PI / 359.0
      xs1[i] = cos(angle)
      ys1[i] = sin(angle)
  var
    xs2 = [-1.cfloat,0,1,0,-1]
    ys2 = [0.cfloat,1,0,-1,0]
  if ipBeginPlot("##EqualAxes",ImVec2(x: -1,y: 0),ImPlotFlags.Equal):
    defer: ipEndPlot()
    ipSetupAxis(ImAxis.X2, nullptr, ImPlotAxisFlags.AuxDefault)
    ipSetupAxis(ImAxis.Y2, nullptr, ImPlotAxisFlags.AuxDefault)
    ipPlotLine("Circle",xs1.ptz,ys1.ptz,360)
    ipSetAxes(ImAxis.X2, ImAxis.Y2)
    ipPlotLine("Diamond",xs2.ptz,ys2.ptz,5)
