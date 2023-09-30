import imgui
import implot
import utils

#----------------------------
# demo_Axes_AxisConstraints()
#----------------------------
proc demo_Axes_AxisConstraints*() =
  var
    constraintsA{.global.} = [-10.cfloat, 10]
    constraintsB{.global.} = [1.cfloat, 20]
    flags{.global.}: ImPlotAxisFlags

  igDragFloat2("Limits Constraints", constraintsA, 0.01f)
  igDragFloat2("Zoom Constraints"  , constraintsB, 0.01f)
  CHECKBOX_FLAG(flags, ImPlotAxisFlags.PanStretch)
  if ipBeginPlot("##AxisConstraints", ImVec2(x: -1, y: 0)):
    defer: ipEndPlot()
    ipSetupAxes("X", "Y", flags, flags)
    ipSetupAxesLimits(-1, 1, -1, 1)
    ipSetupAxisLimitsConstraints(ImAxis.X1, constraintsA[0], constraintsA[1])
    ipSetupAxisZoomConstraints(  ImAxis.X1, constraintsB[0], constraintsB[1])
    ipSetupAxisLimitsConstraints(ImAxis.Y1, constraintsA[0], constraintsA[1])
    ipSetupAxisZoomConstraints(  ImAxis.Y1, constraintsB[0], constraintsB[1])
