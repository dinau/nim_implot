import std/[math]
import imgui
import implot

#--------------------------
# demo_Axes_MultipleAxes()
#--------------------------
proc demo_Axes_MultipleAxes*() =
  var
    xs {.global.}:array[1001,cfloat]
    xs2{.global.}:array[1001,cfloat]
    ys1{.global.}:array[1001,cfloat]
    ys2{.global.}:array[1001,cfloat]
    ys3{.global.}:array[1001,cfloat]
  once:
    for i in  0..<1001:
      xs[i]  = (i.cfloat * 0.1f)
      xs2[i] = xs[i] + 10.0f
      ys1[i] = sin(xs[i]) * 3 + 1
      ys2[i] = cos(xs[i]) * 0.2f + 0.5f
      ys3[i] = sin(xs[i]+0.5f) * 100 + 200
  var
    x2_axis{.global.} = true
    y2_axis{.global.} = true
    y3_axis{.global.} = true

  igCheckbox("X-Axis 2", x2_axis.addr)
  igSameLine()
  igCheckbox("Y-Axis 2", y2_axis.addr)
  igSameLine()
  igCheckbox("Y-Axis 3", y3_axis.addr)

  igBulletText("You can drag axes to the opposite side of the plot.")
  igBulletText("Hover over legend items to see which axis they are plotted on.")

  if ipBeginPlot("Multi-Axis Plot", ImVec2(x: -1,y: 0)):
    defer: ipEndPlot()
    ipSetupAxes("X-Axis 1", "Y-Axis 1")
    ipSetupAxesLimits(0, 100, 0, 10)
    if x2_axis:
      ipSetupAxis(ImAxis.X2, "X-Axis 2",ImPlotAxisFlags.AuxDefault)
      ipSetupAxisLimits(ImAxis.X2, 0, 100)
    if y2_axis:
      ipSetupAxis(ImAxis.Y2, "Y-Axis 2",ImPlotAxisFlags.AuxDefault)
      ipSetupAxisLimits(ImAxis.Y2, 0, 1)
    if y3_axis:
      ipSetupAxis(ImAxis.Y3, "Y-Axis 3",ImPlotAxisFlags.AuxDefault)
      ipSetupAxisLimits(ImAxis.Y3, 0, 300)

    ipPlotLine("f(x) = x", xs.ptz, xs.ptz, 1001)
    if x2_axis:
      ipSetAxes(ImAxis.X2, ImAxis.Y1)
      ipPlotLine("f(x) = sin(x)*3+1", xs2.ptz, ys1.ptz, 1001)
    if y2_axis:
      ipSetAxes(ImAxis.X1, ImAxis.Y2)
      ipPlotLine("f(x) = cos(x)*.2+.5", xs.ptz, ys2.ptz, 1001)
    if y3_axis:
      ipSetAxes(ImAxis.X2, ImAxis.Y3)
      ipPlotLine("f(x) = sin(x+.5)*100+200 ", xs2.ptz, ys3.ptz, 1001)
