import imgui
#
import LinePlots
import FilledLinePlots
import ShadedPlots
import ScatterPlots
import RealtimePlots
import StairstepPlots
import BarStacks
import BarPlots
import BarGroups
import ErrorBars
import StemPlots
import InfiniteLines
import PieCharts
import HeatMaps
import Histogram
import DigitalPlots
import Images
import MarkersAndText
import NaNValues
#
import Tables
#
import LogScale
#
import SimplePlots
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
      demoHeader("Scatter Plots", demo_ScatterPlots)
      demoHeader("RealTime Plots",demo_RealtimePlots)
      demoHeader("Stairstep Plots",demo_StairstepPlots)
      demoHeader("Bar Plots", demo_BarPlots)
      demoHeader("Bar Groups", demo_BarGroups)
      demoHeader("Bar Stacks",demo_BarStacks)
      demoHeader("Error Bars", demo_ErrorBars)
      demoHeader("Stem Plots##", demo_StemPlots)
      demoHeader("Infinite Lines" , demo_InfiniteLines)
      demoHeader("Pie Charts", demo_PieCharts)
      demoHeader("HeatMaps", demo_Heatmaps)
      demoHeader("Histogram", demo_Histogram)
      demoHeader("Histogram2D", demo_Histogram2D)
      demoHeader("Digital Plots", demo_DigitalPlots)
      demoHeader("Images" , demo_Images)
      demoHeader("Markers and Text" , demo_MarkersAndText)
      demoHeader("Nan Values" , demo_NaNValues)
      #
      demoHeader("Simple Plots", demo_SimplePlot)

    if igBeginTabItem("Subplots"):
      defer: igEndTabItem()
      #demoHeader("Sizing", demo_SubplotsSizing)
      #demoHeader("Item Sharing", demo_SubplotItemSharing)
      #demoHeader("Axis Linking", demo_SubplotAxisLinking)
      demoHeader("Tables", demo_Tables)

    if igBeginTabItem("Axes"):
      defer: igEndTabItem()
      demoHeader("Log Scale", demo_LogScale)
      #demoHeader("Symmetric Log Scale", demo_SymmetricLogScale)
      #demoHeader("Time Scale", demo_TimeScale)
      #demoHeader("Custom Scale", demo_CustomScale)
      #demoHeader("Multiple Axes", demo_MultipleAxes)
      #demoHeader("Tick Labels", demo_TickLabels)
      #demoHeader("Linked Axes", demo_LinkedAxes)
      #demoHeader("Axis Constraints", demo_AxisConstraints)
      #demoHeader("Equal Axes", demo_EqualAxes)
      #demoHeader("Auto-Fitting Data", demo_AutoFittingData)

    if igBeginTabItem("ImGui"):
      defer: igEndTabItem()
      demoHeader("Simple demo", demo_SimpleImGui)
