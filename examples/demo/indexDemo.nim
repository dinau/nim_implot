import imgui

# Plots
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
#import PieCharts
import HeatMaps
#import Histogram
import DigitalPlots
#import Images
import MarkersAndText
import NaNValues
#
import SimplePlots
import SimpleImGui

# SubPlots
import Sizing
import ItemSharing
import AxisLinking
import Tables
# Axes
import LogScale
import SymmetricLogScale
import CustomScale
import MultipleAxes
import EqualAxes
import AutoFittingData
import LinkedAxes
#import AxisConstraints
import TimeScale
import TickLabels
# Tools
import DragPoints
import DragLines
import DragRects
import Tags
#import ColormapWidgets
#import LegendPopups
#import LegendOptions
import Annotations
import OffsetAndStride
import Querying
import DragAndDrop
# Custom
import CustomStyles
import CustomDataAndGetters
#import CustomPlottersAndTooltips
import CustomRendering
# Config
import Config
# Help
import Help

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

    if (igBeginTabItem("Plots")):
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
      #demoHeader("Pie Charts", demo_PieCharts)
      demoHeader("HeatMaps", demo_Heatmaps)
      #demoHeader("Histogram", demo_Histogram)
      #demoHeader("Histogram2D", demo_Histogram2D)
      demoHeader("Digital Plots", demo_DigitalPlots)
      #demoHeader("Images" , demo_Images)
      demoHeader("Markers and Text" , demo_MarkersAndText)
      demoHeader("Nan Values" , demo_NaNValues)
      #
      demoHeader("Simple Plots", demo_SimplePlot)

    if igBeginTabItem("Subplots"):
      defer: igEndTabItem()
      demoHeader("Sizing", demo_Subplots_Sizing)
      demoHeader("Item Sharing", demo_Subplots_ItemSharing)
      demoHeader("Axis Linking", demo_Subplots_AxisLinking)
      demoHeader("Tables", demo_Subplots_Tables)

    if igBeginTabItem("Axes"):
      defer: igEndTabItem()
      demoHeader("Log Scale", demo_Axes_LogScale)
      demoHeader("Symmetric Log Scale", demo_Axes_SymmetricLogScale)
      demoHeader("Time Scale", demo_Axes_TimeScale)
      demoHeader("Custom Scale", demo_Axes_CustomScale)
      demoHeader("Multiple Axes", demo_Axes_MultipleAxes)
      demoHeader("Tick Labels", demo_Axes_TickLabels)
      demoHeader("Linked Axes", demo_Axes_LinkedAxes)
      #demoHeader("Axis Constraints", demo_Axes_AxisConstraints)
      demoHeader("Equal Axes", demo_Axes_EqualAxes)
      demoHeader("Auto-Fitting Data", demo_Axes_AutoFittingData)

    if igBeginTabItem("Tools"):
      defer: igEndTabItem()
      demoHeader("Offset and Stride", demo_Tools_OffsetAndStride)
      demoHeader("Drag Points", demo_Tools_DragPoints)
      demoHeader("Drag Lines", demo_Tools_DragLines)
      demoHeader("Drag Rects", demo_Tools_DragRects)
      demoHeader("Querying", demo_Tools_Querying)
      demoHeader("Annotations", demo_Tools_Annotations)
      demoHeader("Tags", demo_Tools_Tags)
      demoHeader("Drag and Drop", demo_Tools_DragAndDrop)
      #demoHeader("Legend Options", demo_Tools_LegendOptions)
      #demoHeader("Legend Popups", demo_Tools_LegendPopups)
      #demoHeader("Colormap Widgets", demo_Tools_ColormapWidgets)

    if igBeginTabItem("Custom"):
      defer: igEndTabItem()
      demoHeader("Custom Styles", demo_Custom_CustomStyles)
      demoHeader("Custom Data and Getters", demo_Custom_CustomDataAndGetters)
      demoHeader("Custom Rendering", demo_Custom_CustomRendering)
      #demoHeader("Custom Plotters and Tooltips", demo_Custom_CustomPlottersAndTooltips)

    if igBeginTabItem("Config"):
      defer: igEndTabItem()
      demo_Config_Config()

    if igBeginTabItem("Help"):
      defer: igEndTabItem()
      demo_Help_Help()

    if igBeginTabItem("ImGui"):
      defer: igEndTabItem()
      demoHeader("Simple demo", demo_SimpleImGui)
