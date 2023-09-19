import implot

#-----------------
# demo_BarPlots()
#-----------------
proc demo_BarPlots*() =
  var  data{.global.} = [1'i8,2,3,4,5,6,7,8,9,10]
  if ipBeginPlot("Bar Plot"):
    ipPlotBars("Vertical",addr data[0],10,0.7,1)
    ipPlotBars("Horizontal",addr data[0],10,0.4,1,ImPlotBarsFlags.Horizontal)
    ipEndPlot()
