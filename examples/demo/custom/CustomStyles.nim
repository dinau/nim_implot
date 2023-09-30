import implot
import utils

#-----------------------------
# demo_Custom_CustomStyles*()
#-----------------------------
proc demo_Custom_CustomStyles*() =
  ipPushColormap(ImPlotColormap.Deep)
  #// normally you wouldn't change the entire style each frame
  var backup = ipGetStyle()[]
  StyleSeaborn()
  if ipBeginPlot("seaborn style"):
    defer: ipEndPlot()
    ipSetupAxes( "x-axis", "y-axis")
    ipSetupAxesLimits(-0.5f, 9.5f, 0, 10)
    var
      lin = [8.uint32,8,9,7,8,8,8,9,7,8]
      bar = [1.uint32,2,5,3,4,1,2,5,3,4]
      dot = [7.uint32,6,6,7,8,5,6,5,8,7]
    ipPlotBars("Bars", bar.ptz, 10, 0.5f)
    ipPlotLine("Line", lin.ptz, 10)
    ipNextColormapColorU32()  #// skip green
    ipPlotScatter("Scatter", dot.ptz, 10)
  ipGetStyle()[] = backup
  ipPopColormap()
