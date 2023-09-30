import std/[math]
import implot

proc TransformForward_Sqrt( v:cdouble, data: pointer): cdouble {.cdecl.} =
  return sqrt(v)

proc TransformInverse_Sqrt(v:cdouble, data:pointer): cdouble {.cdecl.} =
  return v * v

#------------------------
# demo_Axes_CustomScale()
#------------------------
proc demo_Axes_CustomScale*() =
  var v:array[100,cfloat]
  for i in 0..<100:
    v[i] = i.cfloat * 0.01f
  if ipBeginPlot("Sqrt"):
    defer: ipEndPlot()
    ipSetupAxis(ImAxis.X1, "Linear")
    ipSetupAxis(ImAxis.Y1, "Sqrt")
    ipSetupAxisScale(ImAxis.Y1, TransformForward_Sqrt, TransformInverse_Sqrt)
    ipSetupAxisLimitsConstraints(ImAxis.Y1, 0, Inf)
    ipPlotLine("##data",v.ptz,v.ptz,100)
