import imgui
import implot

#------------------
# demo_BarStacks()
#------------------
proc demo_BarStacks*() =
  var Liars{.global.} = -1
  if Liars == -1:
    var Liars_Data{.global.} = [ 4282515870'u32, 4282609140'u32, 4287357182'u32, 4294630301'u32, 4294945280'u32, 4294921472'u32 ]
    Liars = ipAddColormap("LiarsNim", Liars_Data.ptz, 6).int32

  var diverging{.global.}  = true
  igCheckbox("Diverging", addr diverging)

  var
    politicians{.global.} = ["Trump".cstring,"Bachman","Cruz","Gingrich","Palin","Santorum","Walker","Perry","Ryan","McCain","Rubio","Romney","Rand Paul","Christie","Biden","Kasich","Sanders","J Bush","H Clinton","Obama"]
    data_reg{.global.}    = [18.int8,26,7,14,10,8,6,11,4,4,3,8,6,8,6,5,0,3,1,2,         #// Pants on Fire
                           43,36,30,21,30,27,25,17,11,22,15,16,16,17,12,12,14,6,13,12,  #// False
                           16,13,28,22,15,21,15,18,30,17,24,18,13,10,14,15,17,22,14,12, #// Mostly False
                           17,10,13,25,12,22,19,26,23,17,22,27,20,26,29,17,18,22,21,27, #// Half True
                           5,7,16,10,10,12,23,13,17,20,22,16,23,19,20,26,36,29,27,26,   #// Mostly True
                           1,8,6,8,23,10,12,15,15,20,14,15,22,20,19,25,15,18,24,21]     #// True
    labels_reg{.global.} = ["Pants on Fire".cstring,"False","Mostly False","Half True","Mostly True","True"]
    data_div{.global}    = [0.int8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,                                       #// Pants on Fire (dummy, to order legend logically)
                             0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,                                         #// False         (dummy, to order legend logically)
                             0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,                                         #// Mostly False  (dummy, to order legend logically)
                             -16,-13,-28,-22,-15,-21,-15,-18,-30,-17,-24,-18,-13,-10,-14,-15,-17,-22,-14,-12, #// Mostly False
                             -43,-36,-30,-21,-30,-27,-25,-17,-11,-22,-15,-16,-16,-17,-12,-12,-14,-6,-13,-12,  #// False
                             -18,-26,-7,-14,-10,-8,-6,-11,-4,-4,-3,-8,-6,-8,-6,-5,0,-3,-1,-2,                 #// Pants on Fire
                             17,10,13,25,12,22,19,26,23,17,22,27,20,26,29,17,18,22,21,27,                     #// Half True
                             5,7,16,10,10,12,23,13,17,20,22,16,23,19,20,26,36,29,27,26,                       #// Mostly True
                             1,8,6,8,23,10,12,15,15,20,14,15,22,20,19,25,15,18,24,21]                         #// True
    labels_div{.global.} = ["Pants on Fire".cstring,"False","Mostly False","Mostly False","False","Pants on Fire","Half True","Mostly True","True"]

  #ipPushColormap(Liars.ImPlotColormap) # Error: "PushID/PopID or TreeNode/TreePop Mismatch!",
  ipPushColormap("LiarsNim")
  if ipBeginPlot("PolitiFact: Who Lies More?",ImVec2(x: -1,y: 400),ImPlotFlags.NoMouseText):
      ipSetupLegend(ImPlotLocation.South, ImPlotLegendFlags.Outside or ImPlotLegendFlags.Horizontal)
      ipSetupAxes(nullptr,nullptr
                ,ImPlotAxisFlags.AutoFit or ImPlotAxisFlags.NoDecorations
                ,ImPlotAxisFlags.AutoFit or ImPlotAxisFlags.Invert)
      ipSetupAxisTicks(ImAxis.Y1,0,19,20, politicians.ptz,false)
      if diverging:
          ipPlotBarGroups(labels_div.ptz, data_div.ptz
                      ,9      # item_count : int
                      ,20     # group_count: int
                      ,0.75   # group_size:  cdouble
                      ,0      # shift:       cdouble
                      ,ImPlotBarGroupsFlags.Stacked or ImPlotBarGroupsFlags.Horizontal)
      else:
          ipPlotBarGroups(labels_reg.ptz, data_reg.ptz
                      ,6
                      ,20
                      ,0.75
                      ,0
                      ,ImPlotBarGroupsFlags.Stacked or ImPlotBarGroupsFlags.Horizontal)
      ipEndPlot()
  ipPopColormap()
