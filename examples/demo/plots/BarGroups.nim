import imgui
import implot

#-------------------
# demo_BarGroups()
#-------------------
proc demo_BarGroups*() =
  var
    data{.global.} = [83'i8, 67, 23, 89, 83, 78, 91, 82, 85, 90,    #// midterm
                           80, 62, 56, 99, 55, 78, 88, 78, 90, 100, #// final
                           80, 69, 52, 92, 72, 78, 75, 76, 89, 95]  #// course
    ilabels     = ["Midterm Exam".cstring,"Final Exam","Course Grade"]
    glabels     = ["S1".cstring,"S2","S3","S4","S5","S6","S7","S8","S9","S10"]
    positions   = [0.cfloat64,1,2,3,4,5,6,7,8,9]
    Items{.global.}  = 3.int32
    groups{.global.} = 10
    size{.global.} = 0.67f
    flags{.global.} = 0'i32 # ImPlotBarGroupsFlags
    horz{.global.} = false

  igCheckboxFlags("Stacked", addr flags, ImPlotBarGroupsFlags.Stacked.int32)
  igSameLine()
  igCheckbox("Horizontal",addr horz)

  igSliderInt("items",addr Items,1,3)
  igSliderFloat("Size",addr size,0,1)

  if ipBeginPlot("Bar Group"):
    ipSetupLegend(ImPlotLocation.East, ImPlotLegendFlags.Outside)
    if horz:
      ipSetupAxes("Score","Student",ImPlotAxisFlags.AutoFit,ImPlotAxisFlags.AutoFit)
      ipSetupAxisTicks(ImAxis.Y1,positions.ptz, groups,  glabels.ptz)
      ipPlotBarGroups(ilabels.ptz, data.ptz, Items,groups,size,0
                   ,flags or ImPlotBarGroupsFlags.Horizontal)
    else:
      ipSetupAxes("Student","Score",ImPlotAxisFlags.AutoFit,ImPlotAxisFlags.AutoFit)
      ipSetupAxisTicks(ImAxis.X1,positions.ptz, groups, glabels.ptz)
      ipPlotBarGroups(ilabels.ptz, data.ptz,Items,groups,size,0,flags.ImPlotBarGroupsFlags)
    ipEndPlot()
