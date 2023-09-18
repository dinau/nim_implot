import imgui
#
import SimplePlots
import LinePlots
import Histogram
import DigitalPlots
import StemPlots
import PieCharts
import HeatMaps
import StairstepPlots
import ScatterPlots
import FilledLinePlots
import ShadedPlots
import RealtimePlots
import BarStacks
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
      demoHeader("Line Plots", demo_LinePlots)
      demoHeader("Filled Line Plots", demo_FilledLinePlots)
      demoHeader("Shaded Plots", demo_ShadedPlots)
      demoHeader("Stairstep Plots",demo_StairstepPlots)
      demoHeader("Bar Stacks",demo_BarStacks)
      demoHeader("Stem Plots##", demo_StemPlots)
      demoHeader("Pie Charts", demo_PieCharts)
      demoHeader("HeatMaps", demo_Heatmaps)
      demoHeader("Histogram", demo_Histogram)
      demoHeader("Histogram2D", demo_Histogram2D)
      demoHeader("Digital Plots", demo_DigitalPlots)
      demoHeader("Scatter Plots", demo_ScatterPlots)
      demoHeader("RealTime Plots",demo_RealtimePlots)
      demoHeader("Simple Plots", demo_SimplePlot)

    if (igBeginTabItem("ImGui")):
      defer: igEndTabItem()
      demoHeader("Simple demo", demo_SimpleImGui)
