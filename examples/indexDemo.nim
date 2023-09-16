import imgui
#
import SimplePlot
import LinePlots
import Histogram
import DigitalPlots
#
import SimpleImGui

#---------------
# demoHeaeder()
#---------------
proc demoHeader(label: string, demo: proc()) =
  if igTreeNodeEx(label.cstring):
    demo()
    igTreePop()

#------------------
# imPlotDemoTabs()
#------------------
proc imPlotDemoTabs*() =
  if igBeginTabBar("ImPlotDemoTabs"):
    defer: igEndTabBar()
    if (igBeginTabItem("ImPlot")):
      defer: igEndTabItem()
      demoHeader("Simple Plots", demo_SimplePlot)
      demoHeader("Line Plots", demo_LinePlots)
      demoHeader("Histogram", demo_Histogram)
      demoHeader("Histogram2D", demo_Histogram2D)
      demoHeader("Digital Plots", demo_DigitalPlots)
    if (igBeginTabItem("ImGui")):
      defer: igEndTabItem()
      demoHeader("Simple demo", demo_SimpleImGui)
