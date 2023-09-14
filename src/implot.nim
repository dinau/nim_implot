# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

## ImGUI Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the generator.
##
## The aim is to achieve as much compatibility with C as possible.
## Optional helper functions have been created as a submodule
## ``imgui/imgui_helpers`` to better bind this library to Nim.
##
## You can check the original documentation `here <https://github.com/ocornut/imgui/blob/master/imgui.cpp>`_.
##
## Source language of ImGui is C++, since Nim is able to compile both to C
## and C++ you can select which compile target you wish to use. Note that to use
## the C backend you must supply a `cimgui <https://github.com/cimgui/cimgui>`_
## dynamic library file.
##
## HACK: If you are targeting Windows, be sure to compile the cimgui dll with
## visual studio and not with mingw.

import strutils
import imgui

## Tentative workaround [start]
type
  Imguidockrequest* = distinct object
  ImGuiDockNodeSettings* = distinct object
  const_cstringPtr* {.pure, inheritable, bycopy.} = object
    Size*: cint
    Capacity*: cint
    Data*: ptr ptr cschar
  tm {.pure, inheritable, bycopy.} = object
    tmsec*: cint
    tmmin*: cint
    tmhour*: cint
    tmmday*: cint
    tmmon*: cint
    tmyear*: cint
    tmwday*: cint
    tmyday*: cint
    tmisdst*: cint
  cfloat64* = cdouble
  double* = cdouble
  Ims32* = cint
const
  nullptr* = nil

## Tentative workaround [end]

proc currentSourceDir(): string {.compileTime.} =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]

{.passC:"-DImDrawIdx=\"unsigned int\"".}

{.compile: "implot/private/cimplot/cimplot.cpp",
  compile: "implot/private/cimplot/implot/implot.cpp",
  compile: "implot/private/cimplot/implot/implot_demo.cpp",
  compile: "implot/private/cimplot/implot/implot_items.cpp".}
{.passC:"-I" & currentSourceDir() & "/implot/private/cimplot".}
{.passC:"-I" & currentSourceDir() & "/implot/private/cimplot/implot".}
{.pragma: implot_header, header: currentSourceDir() & "/implot/private/ncimplot.h".}

# Enums
type
  ImAxis* {.pure, size: int32.sizeof.} = enum
    X1 = 0
    X2 = 1
    X3 = 2
    Y1 = 3
    Y2 = 4
    Y3 = 5
  ImPlotAxisFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoLabel = 1
    NoGridLines = 2
    NoTickMarks = 4
    NoTickLabels = 8
    NoDecorations = 15
    NoInitialFit = 16
    NoMenus = 32
    NoSideSwitch = 64
    NoHighlight = 128
    Opposite = 256
    AuxDefault = 258
    Foreground = 512
    Invert = 1024
    AutoFit = 2048
    RangeFit = 4096
    PanStretch = 8192
    LockMin = 16384
    LockMax = 32768
    Lock = 49152
  ImPlotBarGroupsFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1024
    Stacked = 2048
  ImPlotBarsFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1024
  ImPlotBin* {.pure, size: int32.sizeof.} = enum
    Scott = -4
    Rice = -3
    Sturges = -2
    Sqrt = -1
  ImPlotCol* {.pure, size: int32.sizeof.} = enum
    Line = 0
    Fill = 1
    MarkerOutline = 2
    MarkerFill = 3
    ErrorBar = 4
    FrameBg = 5
    PlotBg = 6
    PlotBorder = 7
    LegendBg = 8
    LegendBorder = 9
    LegendText = 10
    TitleText = 11
    InlayText = 12
    AxisText = 13
    AxisGrid = 14
    AxisTick = 15
    AxisBg = 16
    AxisBgHovered = 17
    AxisBgActive = 18
    Selection = 19
    Crosshairs = 20
  ImPlotColormapScaleFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoLabel = 1
    Opposite = 2
    Invert = 4
  ImPlotColormap* {.pure, size: int32.sizeof.} = enum
    Deep = 0
    Dark = 1
    Pastel = 2
    Paired = 3
    Viridis = 4
    Plasma = 5
    Hot = 6
    Cool = 7
    Pink = 8
    Jet = 9
    Twilight = 10
    RdBu = 11
    BrBG = 12
    PiYG = 13
    Spectral = 14
    Greys = 15
  ImPlotCond* {.pure, size: int32.sizeof.} = enum
    None = 0
    Always = 1
    Once = 2
  ImPlotDateFmt* {.pure, size: int32.sizeof.} = enum
    None = 0
    DayMo = 1
    DayMoYr = 2
    MoYr = 3
    Mo = 4
    Yr = 5
  ImPlotDigitalFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
  ImPlotDragToolFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoCursors = 1
    NoFit = 2
    NoInputs = 4
    Delayed = 8
  ImPlotDummyFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
  ImPlotErrorBarsFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1024
  ImPlotFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoTitle = 1
    NoLegend = 2
    NoMouseText = 4
    NoInputs = 8
    NoMenus = 16
    NoBoxSelect = 32
    CanvasOnly = 55
    NoChild = 64
    NoFrame = 128
    Equal = 256
    Crosshairs = 512
  ImPlotHeatmapFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    ColMajor = 1024
  ImPlotHistogramFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1024
    Cumulative = 2048
    Density = 4096
    NoOutliers = 8192
    ColMajor = 16384
  ImPlotImageFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
  ImPlotInfLinesFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1024
  ImPlotItemFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoLegend = 1
    NoFit = 2
  ImPlotLegendFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoButtons = 1
    NoHighlightItem = 2
    NoHighlightAxis = 4
    NoMenus = 8
    Outside = 16
    Horizontal = 32
    Sort = 64
  ImPlotLineFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Segments = 1024
    Loop = 2048
    SkipNaN = 4096
    NoClip = 8192
    Shaded = 16384
  ImPlotLocation* {.pure, size: int32.sizeof.} = enum
    Center = 0
    North = 1
    South = 2
    West = 4
    NorthWest = 5
    SouthWest = 6
    East = 8
    NorthEast = 9
    SouthEast = 10
  ImPlotMarker* {.pure, size: int32.sizeof.} = enum
    None = -1
    Circle = 0
    Square = 1
    Diamond = 2
    Up = 3
    Down = 4
    Left = 5
    Right = 6
    Cross = 7
    Plus = 8
    Asterisk = 9
  ImPlotMouseTextFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoAuxAxes = 1
    NoFormat = 2
    ShowAlways = 4
  ImPlotPieChartFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Normalize = 1024
  ImPlotScale* {.pure, size: int32.sizeof.} = enum
    Linear = 0
    Time = 1
    Log10 = 2
    SymLog = 3
  ImPlotScatterFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoClip = 1024
  ImPlotShadedFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
  ImPlotStairsFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    PreStep = 1024
    Shaded = 2048
  ImPlotStemsFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1024
  ImPlotStyleVar* {.pure, size: int32.sizeof.} = enum
    LineWeight = 0
    Marker = 1
    MarkerSize = 2
    MarkerWeight = 3
    FillAlpha = 4
    ErrorBarSize = 5
    ErrorBarWeight = 6
    DigitalBitHeight = 7
    DigitalBitGap = 8
    PlotBorderSize = 9
    MinorAlpha = 10
    MajorTickLen = 11
    MinorTickLen = 12
    MajorTickSize = 13
    MinorTickSize = 14
    MajorGridSize = 15
    MinorGridSize = 16
    PlotPadding = 17
    LabelPadding = 18
    LegendPadding = 19
    LegendInnerPadding = 20
    LegendSpacing = 21
    MousePosPadding = 22
    AnnotationPadding = 23
    FitPadding = 24
    PlotDefaultSize = 25
    PlotMinSize = 26
  ImPlotSubplotFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoTitle = 1
    NoLegend = 2
    NoMenus = 4
    NoResize = 8
    NoAlign = 16
    ShareItems = 32
    LinkRows = 64
    LinkCols = 128
    LinkAllX = 256
    LinkAllY = 512
    ColMajor = 1024
  ImPlotTextFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Vertical = 1024
  ImPlotTimeFmt* {.pure, size: int32.sizeof.} = enum
    None = 0
    Us = 1
    SUs = 2
    SMs = 3
    S = 4
    MinSMs = 5
    HrMinSMs = 6
    HrMinS = 7
    HrMin = 8
    Hr = 9
  ImPlotTimeUnit* {.pure, size: int32.sizeof.} = enum
    Us = 0
    Ms = 1
    S = 2
    Min = 3
    Hr = 4
    Day = 5
    Mo = 6
    Yr = 7

# TypeDefs
type
  ImPlotFormatter* = proc(value: cfloat64, buff: cstring, size: int, user_data: pointer): int {.cdecl, varargs.}
  ImPlotGetter* = proc(idx: int, user_data: pointer): ImPlotPoint {.cdecl, varargs.}
  ImPlotLocator* = proc(ticker: ImPlotTicker, Range: ImPlotRange, pixels: float32, vertical: bool, formatter: ImPlotFormatter, formatter_data: pointer): void {.cdecl, varargs.}
  ImPlotTransform* = proc(value: cfloat64, user_data: pointer): cfloat64 {.cdecl, varargs.}

  Formatter_Time_Data* {.importc: "Formatter_Time_Data", implot_header.} = object
    time* {.importc: "Time".}: ImPlotTime
    spec* {.importc: "Spec".}: ImPlotDateTimeSpec
    userFormatter* {.importc: "UserFormatter".}: ImPlotFormatter
    userFormatterData* {.importc: "UserFormatterData".}: pointer
  ImPlotAlignmentData* {.importc: "ImPlotAlignmentData", implot_header.} = object
    vertical* {.importc: "Vertical".}: bool
    padA* {.importc: "PadA".}: float32
    padB* {.importc: "PadB".}: float32
    padAMax* {.importc: "PadAMax".}: float32
    padBMax* {.importc: "PadBMax".}: float32
  ImPlotAnnotation* {.importc: "ImPlotAnnotation", implot_header.} = object
    pos* {.importc: "Pos".}: ImVec2
    offset* {.importc: "Offset".}: ImVec2
    colorBg* {.importc: "ColorBg".}: uint32
    colorFg* {.importc: "ColorFg".}: uint32
    textOffset* {.importc: "TextOffset".}: int
    clamp* {.importc: "Clamp".}: bool
  ImPlotAnnotationCollection* {.importc: "ImPlotAnnotationCollection", implot_header.} = object
    annotations* {.importc: "Annotations".}: ImVector[ImPlotAnnotation]
    textBuffer* {.importc: "TextBuffer".}: ImGuiTextBuffer
    size* {.importc: "Size".}: int
  ImPlotAxis* {.importc: "ImPlotAxis", implot_header.} = object
    id* {.importc: "ID".}: ImGuiID
    flags* {.importc: "Flags".}: ImPlotAxisFlags
    previousFlags* {.importc: "PreviousFlags".}: ImPlotAxisFlags
    Range* {.importc: "Range".}: ImPlotRange
    rangeCond* {.importc: "RangeCond".}: ImPlotCond
    scale* {.importc: "Scale".}: ImPlotScale
    fitExtents* {.importc: "FitExtents".}: ImPlotRange
    orthoAxis* {.importc: "OrthoAxis".}: ptr ImPlotAxis
    constraintRange* {.importc: "ConstraintRange".}: ImPlotRange
    constraintZoom* {.importc: "ConstraintZoom".}: ImPlotRange
    ticker* {.importc: "Ticker".}: ImPlotTicker
    formatter* {.importc: "Formatter".}: ImPlotFormatter
    formatterData* {.importc: "FormatterData".}: pointer
    formatSpec* {.importc: "FormatSpec".}: array[16, int8]
    locator* {.importc: "Locator".}: ImPlotLocator
    linkedMin* {.importc: "LinkedMin".}: ptr cfloat64
    linkedMax* {.importc: "LinkedMax".}: ptr cfloat64
    pickerLevel* {.importc: "PickerLevel".}: int
    pickerTimeMin* {.importc: "PickerTimeMin".}: ImPlotTime
    pickerTimeMax* {.importc: "PickerTimeMax".}: ImPlotTime
    transformForward* {.importc: "TransformForward".}: ImPlotTransform
    transformInverse* {.importc: "TransformInverse".}: ImPlotTransform
    transformData* {.importc: "TransformData".}: pointer
    pixelMin* {.importc: "PixelMin".}: float32
    pixelMax* {.importc: "PixelMax".}: float32
    scaleMin* {.importc: "ScaleMin".}: cfloat64
    scaleMax* {.importc: "ScaleMax".}: cfloat64
    scaleToPixel* {.importc: "ScaleToPixel".}: cfloat64
    datum1* {.importc: "Datum1".}: float32
    datum2* {.importc: "Datum2".}: float32
    hoverRect* {.importc: "HoverRect".}: ImRect
    labelOffset* {.importc: "LabelOffset".}: int
    colorMaj* {.importc: "ColorMaj".}: uint32
    colorMin* {.importc: "ColorMin".}: uint32
    colorTick* {.importc: "ColorTick".}: uint32
    colorTxt* {.importc: "ColorTxt".}: uint32
    colorBg* {.importc: "ColorBg".}: uint32
    colorHov* {.importc: "ColorHov".}: uint32
    colorAct* {.importc: "ColorAct".}: uint32
    colorHiLi* {.importc: "ColorHiLi".}: uint32
    enabled* {.importc: "Enabled".}: bool
    vertical* {.importc: "Vertical".}: bool
    fitThisFrame* {.importc: "FitThisFrame".}: bool
    hasRange* {.importc: "HasRange".}: bool
    hasFormatSpec* {.importc: "HasFormatSpec".}: bool
    showDefaultTicks* {.importc: "ShowDefaultTicks".}: bool
    hovered* {.importc: "Hovered".}: bool
    held* {.importc: "Held".}: bool
  ImPlotColormapData* {.importc: "ImPlotColormapData", implot_header.} = object
    keys* {.importc: "Keys".}: ImVector[uint32]
    keyCounts* {.importc: "KeyCounts".}: ImVector[int]
    keyOffsets* {.importc: "KeyOffsets".}: ImVector[int]
    tables* {.importc: "Tables".}: ImVector[uint32]
    tableSizes* {.importc: "TableSizes".}: ImVector[int]
    tableOffsets* {.importc: "TableOffsets".}: ImVector[int]
    text* {.importc: "Text".}: ImGuiTextBuffer
    textOffsets* {.importc: "TextOffsets".}: ImVector[int]
    quals* {.importc: "Quals".}: ImVector[bool]
    map* {.importc: "Map".}: ImGuiStorage
    count* {.importc: "Count".}: int
  ImPlotContext* {.importc: "ImPlotContext", implot_header.} = object
    plots* {.importc: "Plots".}: ImVector[ImPlotPlot]
    subplots* {.importc: "Subplots".}: ImVector[ImPlotSubplot]
    currentPlot* {.importc: "CurrentPlot".}: ptr ImPlotPlot
    currentSubplot* {.importc: "CurrentSubplot".}: ptr ImPlotSubplot
    currentItems* {.importc: "CurrentItems".}: ptr ImPlotItemGroup
    currentItem* {.importc: "CurrentItem".}: ptr ImPlotItem
    previousItem* {.importc: "PreviousItem".}: ptr ImPlotItem
    cTicker* {.importc: "CTicker".}: ImPlotTicker
    annotations* {.importc: "Annotations".}: ImPlotAnnotationCollection
    tags* {.importc: "Tags".}: ImPlotTagCollection
    childWindowMade* {.importc: "ChildWindowMade".}: bool
    style* {.importc: "Style".}: ImPlotStyle
    colorModifiers* {.importc: "ColorModifiers".}: ImVector[ImGuiColorMod]
    styleModifiers* {.importc: "StyleModifiers".}: ImVector[ImGuiStyleMod]
    colormapData* {.importc: "ColormapData".}: ImPlotColormapData
    colormapModifiers* {.importc: "ColormapModifiers".}: ImVector[ImPlotColormap]
    tm* {.importc: "Tm".}: tm
    tempDouble1* {.importc: "TempDouble1".}: ImVector[cfloat64]
    tempDouble2* {.importc: "TempDouble2".}: ImVector[cfloat64]
    tempInt1* {.importc: "TempInt1".}: ImVector[int]
    digitalPlotItemCnt* {.importc: "DigitalPlotItemCnt".}: int
    digitalPlotOffset* {.importc: "DigitalPlotOffset".}: int
    nextPlotData* {.importc: "NextPlotData".}: ImPlotNextPlotData
    nextItemData* {.importc: "NextItemData".}: ImPlotNextItemData
    inputMap* {.importc: "InputMap".}: ImPlotInputMap
    openContextThisFrame* {.importc: "OpenContextThisFrame".}: bool
    mousePosStringBuilder* {.importc: "MousePosStringBuilder".}: ImGuiTextBuffer
    sortItems* {.importc: "SortItems".}: ptr ImPlotItemGroup
    alignmentData* {.importc: "AlignmentData".}: ImVector[ImPlotAlignmentData]
    currentAlignmentH* {.importc: "CurrentAlignmentH".}: ptr ImPlotAlignmentData
    currentAlignmentV* {.importc: "CurrentAlignmentV".}: ptr ImPlotAlignmentData
  ImPlotDateTimeSpec* {.importc: "ImPlotDateTimeSpec", implot_header.} = object
    date* {.importc: "Date".}: ImPlotDateFmt
    time* {.importc: "Time".}: ImPlotTimeFmt
    useISO8601* {.importc: "UseISO8601".}: bool
    use24HourClock* {.importc: "Use24HourClock".}: bool
  ImPlotInputMap* {.importc: "ImPlotInputMap", implot_header.} = object
    pan* {.importc: "Pan".}: ImGuiMouseButton
    panMod* {.importc: "PanMod".}: int
    fit* {.importc: "Fit".}: ImGuiMouseButton
    select* {.importc: "Select".}: ImGuiMouseButton
    selectCancel* {.importc: "SelectCancel".}: ImGuiMouseButton
    selectMod* {.importc: "SelectMod".}: int
    selectHorzMod* {.importc: "SelectHorzMod".}: int
    selectVertMod* {.importc: "SelectVertMod".}: int
    menu* {.importc: "Menu".}: ImGuiMouseButton
    overrideMod* {.importc: "OverrideMod".}: int
    zoomMod* {.importc: "ZoomMod".}: int
    zoomRate* {.importc: "ZoomRate".}: float32
  ImPlotItem* {.importc: "ImPlotItem", implot_header.} = object
    id* {.importc: "ID".}: ImGuiID
    color* {.importc: "Color".}: uint32
    legendHoverRect* {.importc: "LegendHoverRect".}: ImRect
    nameOffset* {.importc: "NameOffset".}: int
    show* {.importc: "Show".}: bool
    legendHovered* {.importc: "LegendHovered".}: bool
    seenThisFrame* {.importc: "SeenThisFrame".}: bool
  ImPlotItemGroup* {.importc: "ImPlotItemGroup", implot_header.} = object
    id* {.importc: "ID".}: ImGuiID
    legend* {.importc: "Legend".}: ImPlotLegend
    itemPool* {.importc: "ItemPool".}: ImVector[ImPlotItem]
    colormapIdx* {.importc: "ColormapIdx".}: int
  ImPlotLegend* {.importc: "ImPlotLegend", implot_header.} = object
    flags* {.importc: "Flags".}: ImPlotLegendFlags
    previousFlags* {.importc: "PreviousFlags".}: ImPlotLegendFlags
    location* {.importc: "Location".}: ImPlotLocation
    previousLocation* {.importc: "PreviousLocation".}: ImPlotLocation
    indices* {.importc: "Indices".}: ImVector[int]
    labels* {.importc: "Labels".}: ImGuiTextBuffer
    rect* {.importc: "Rect".}: ImRect
    hovered* {.importc: "Hovered".}: bool
    held* {.importc: "Held".}: bool
    canGoInside* {.importc: "CanGoInside".}: bool
  ImPlotNextItemData* {.importc: "ImPlotNextItemData", implot_header.} = object
    colors* {.importc: "Colors".}: array[5, ImVec4]
    lineWeight* {.importc: "LineWeight".}: float32
    marker* {.importc: "Marker".}: ImPlotMarker
    markerSize* {.importc: "MarkerSize".}: float32
    markerWeight* {.importc: "MarkerWeight".}: float32
    fillAlpha* {.importc: "FillAlpha".}: float32
    errorBarSize* {.importc: "ErrorBarSize".}: float32
    errorBarWeight* {.importc: "ErrorBarWeight".}: float32
    digitalBitHeight* {.importc: "DigitalBitHeight".}: float32
    digitalBitGap* {.importc: "DigitalBitGap".}: float32
    renderLine* {.importc: "RenderLine".}: bool
    renderFill* {.importc: "RenderFill".}: bool
    renderMarkerLine* {.importc: "RenderMarkerLine".}: bool
    renderMarkerFill* {.importc: "RenderMarkerFill".}: bool
    hasHidden* {.importc: "HasHidden".}: bool
    hidden* {.importc: "Hidden".}: bool
    hiddenCond* {.importc: "HiddenCond".}: ImPlotCond
  ImPlotNextPlotData* {.importc: "ImPlotNextPlotData", implot_header.} = object
    rangeCond* {.importc: "RangeCond".}: array[6, ImPlotCond]
    Range* {.importc: "Range".}: array[6, ImPlotRange]
    hasRange* {.importc: "HasRange".}: array[6, bool]
    fit* {.importc: "Fit".}: array[6, bool]
    linkedMin* {.importc: "LinkedMin".}: array[6, ptr cfloat64]
    linkedMax* {.importc: "LinkedMax".}: array[6, ptr cfloat64]
  ImPlotPlot* {.importc: "ImPlotPlot", implot_header.} = object
    id* {.importc: "ID".}: ImGuiID
    flags* {.importc: "Flags".}: ImPlotFlags
    previousFlags* {.importc: "PreviousFlags".}: ImPlotFlags
    mouseTextLocation* {.importc: "MouseTextLocation".}: ImPlotLocation
    mouseTextFlags* {.importc: "MouseTextFlags".}: ImPlotMouseTextFlags
    axes* {.importc: "Axes".}: array[6, ImPlotAxis]
    textBuffer* {.importc: "TextBuffer".}: ImGuiTextBuffer
    items* {.importc: "Items".}: ImPlotItemGroup
    currentX* {.importc: "CurrentX".}: ImAxis
    currentY* {.importc: "CurrentY".}: ImAxis
    frameRect* {.importc: "FrameRect".}: ImRect
    canvasRect* {.importc: "CanvasRect".}: ImRect
    plotRect* {.importc: "PlotRect".}: ImRect
    axesRect* {.importc: "AxesRect".}: ImRect
    selectRect* {.importc: "SelectRect".}: ImRect
    selectStart* {.importc: "SelectStart".}: ImVec2
    titleOffset* {.importc: "TitleOffset".}: int
    justCreated* {.importc: "JustCreated".}: bool
    initialized* {.importc: "Initialized".}: bool
    setupLocked* {.importc: "SetupLocked".}: bool
    fitThisFrame* {.importc: "FitThisFrame".}: bool
    hovered* {.importc: "Hovered".}: bool
    held* {.importc: "Held".}: bool
    selecting* {.importc: "Selecting".}: bool
    selected* {.importc: "Selected".}: bool
    contextLocked* {.importc: "ContextLocked".}: bool
  ImPlotPoint* {.importc: "ImPlotPoint", implot_header.} = object
    x* {.importc: "x".}: cfloat64
    y* {.importc: "y".}: cfloat64
  ImPlotPointError* {.importc: "ImPlotPointError", implot_header.} = object
    x* {.importc: "X".}: cfloat64
    y* {.importc: "Y".}: cfloat64
    neg* {.importc: "Neg".}: cfloat64
    pos* {.importc: "Pos".}: cfloat64
  ImPlotRange* {.importc: "ImPlotRange", implot_header.} = object
    min* {.importc: "Min".}: cfloat64
    max* {.importc: "Max".}: cfloat64
  ImPlotRect* {.importc: "ImPlotRect", implot_header.} = object
    x* {.importc: "X".}: ImPlotRange
    y* {.importc: "Y".}: ImPlotRange
  ImPlotStyle* {.importc: "ImPlotStyle", implot_header.} = object
    lineWeight* {.importc: "LineWeight".}: float32
    marker* {.importc: "Marker".}: int
    markerSize* {.importc: "MarkerSize".}: float32
    markerWeight* {.importc: "MarkerWeight".}: float32
    fillAlpha* {.importc: "FillAlpha".}: float32
    errorBarSize* {.importc: "ErrorBarSize".}: float32
    errorBarWeight* {.importc: "ErrorBarWeight".}: float32
    digitalBitHeight* {.importc: "DigitalBitHeight".}: float32
    digitalBitGap* {.importc: "DigitalBitGap".}: float32
    plotBorderSize* {.importc: "PlotBorderSize".}: float32
    minorAlpha* {.importc: "MinorAlpha".}: float32
    majorTickLen* {.importc: "MajorTickLen".}: ImVec2
    minorTickLen* {.importc: "MinorTickLen".}: ImVec2
    majorTickSize* {.importc: "MajorTickSize".}: ImVec2
    minorTickSize* {.importc: "MinorTickSize".}: ImVec2
    majorGridSize* {.importc: "MajorGridSize".}: ImVec2
    minorGridSize* {.importc: "MinorGridSize".}: ImVec2
    plotPadding* {.importc: "PlotPadding".}: ImVec2
    labelPadding* {.importc: "LabelPadding".}: ImVec2
    legendPadding* {.importc: "LegendPadding".}: ImVec2
    legendInnerPadding* {.importc: "LegendInnerPadding".}: ImVec2
    legendSpacing* {.importc: "LegendSpacing".}: ImVec2
    mousePosPadding* {.importc: "MousePosPadding".}: ImVec2
    annotationPadding* {.importc: "AnnotationPadding".}: ImVec2
    fitPadding* {.importc: "FitPadding".}: ImVec2
    plotDefaultSize* {.importc: "PlotDefaultSize".}: ImVec2
    plotMinSize* {.importc: "PlotMinSize".}: ImVec2
    colors* {.importc: "Colors".}: array[21, ImVec4]
    colormap* {.importc: "Colormap".}: ImPlotColormap
    useLocalTime* {.importc: "UseLocalTime".}: bool
    useISO8601* {.importc: "UseISO8601".}: bool
    use24HourClock* {.importc: "Use24HourClock".}: bool
  ImPlotSubplot* {.importc: "ImPlotSubplot", implot_header.} = object
    id* {.importc: "ID".}: ImGuiID
    flags* {.importc: "Flags".}: ImPlotSubplotFlags
    previousFlags* {.importc: "PreviousFlags".}: ImPlotSubplotFlags
    items* {.importc: "Items".}: ImPlotItemGroup
    rows* {.importc: "Rows".}: int
    cols* {.importc: "Cols".}: int
    currentIdx* {.importc: "CurrentIdx".}: int
    frameRect* {.importc: "FrameRect".}: ImRect
    gridRect* {.importc: "GridRect".}: ImRect
    cellSize* {.importc: "CellSize".}: ImVec2
    rowAlignmentData* {.importc: "RowAlignmentData".}: ImVector[ImPlotAlignmentData]
    colAlignmentData* {.importc: "ColAlignmentData".}: ImVector[ImPlotAlignmentData]
    rowRatios* {.importc: "RowRatios".}: ImVector[float32]
    colRatios* {.importc: "ColRatios".}: ImVector[float32]
    rowLinkData* {.importc: "RowLinkData".}: ImVector[ImPlotRange]
    colLinkData* {.importc: "ColLinkData".}: ImVector[ImPlotRange]
    tempSizes* {.importc: "TempSizes".}: array[2, float32]
    frameHovered* {.importc: "FrameHovered".}: bool
    hasTitle* {.importc: "HasTitle".}: bool
  ImPlotTag* {.importc: "ImPlotTag", implot_header.} = object
    axis* {.importc: "Axis".}: ImAxis
    value* {.importc: "Value".}: cfloat64
    colorBg* {.importc: "ColorBg".}: uint32
    colorFg* {.importc: "ColorFg".}: uint32
    textOffset* {.importc: "TextOffset".}: int
  ImPlotTagCollection* {.importc: "ImPlotTagCollection", implot_header.} = object
    tags* {.importc: "Tags".}: ImVector[ImPlotTag]
    textBuffer* {.importc: "TextBuffer".}: ImGuiTextBuffer
    size* {.importc: "Size".}: int
  ImPlotTick* {.importc: "ImPlotTick", implot_header.} = object
    plotPos* {.importc: "PlotPos".}: cfloat64
    pixelPos* {.importc: "PixelPos".}: float32
    labelSize* {.importc: "LabelSize".}: ImVec2
    textOffset* {.importc: "TextOffset".}: int
    major* {.importc: "Major".}: bool
    showLabel* {.importc: "ShowLabel".}: bool
    level* {.importc: "Level".}: int
    idx* {.importc: "Idx".}: int
  ImPlotTicker* {.importc: "ImPlotTicker", implot_header.} = object
    ticks* {.importc: "Ticks".}: ImVector[ImPlotTick]
    textBuffer* {.importc: "TextBuffer".}: ImGuiTextBuffer
    maxSize* {.importc: "MaxSize".}: ImVec2
    lateSize* {.importc: "LateSize".}: ImVec2
    levels* {.importc: "Levels".}: int
  ImPlotTime* {.importc: "ImPlotTime", implot_header.} = object
    s* {.importc: "S".}: int32
    us* {.importc: "Us".}: int

# Procs
{.push warning[HoleEnumConv]: off.}
when not defined(cpp) or defined(cimguiDLL):
  {.push dynlib: imgui_dll, cdecl, discardable.}
else:
  {.push nodecl, discardable.}

proc begin*(self: ptr ImPlotAlignmentData): void {.importc: "ImPlotAlignmentData_Begin".}
proc `end`*(self: ptr ImPlotAlignmentData): void {.importc: "ImPlotAlignmentData_End".}
proc newImPlotAlignmentData*(): void {.importc: "ImPlotAlignmentData_ImPlotAlignmentData".}
proc reset*(self: ptr ImPlotAlignmentData): void {.importc: "ImPlotAlignmentData_Reset".}
proc update*(self: ptr ImPlotAlignmentData, pad_a: ptr float32, pad_b: ptr float32, delta_a: ptr float32, delta_b: ptr float32): void {.importc: "ImPlotAlignmentData_Update".}
proc destroy*(self: ptr ImPlotAlignmentData): void {.importc: "ImPlotAlignmentData_destroy".}
proc append*(self: ptr ImPlotAnnotationCollection, pos: ImVec2, off: ImVec2, bg: uint32, fg: uint32, clamp: bool, fmt: cstring): void {.importc: "ImPlotAnnotationCollection_Append", varargs.}
proc appendV*(self: ptr ImPlotAnnotationCollection, pos: ImVec2, off: ImVec2, bg: uint32, fg: uint32, clamp: bool, fmt: cstring): void {.importc: "ImPlotAnnotationCollection_AppendV", varargs.}
proc getText*(self: ptr ImPlotAnnotationCollection, idx: int): cstring {.importc: "ImPlotAnnotationCollection_GetText".}
proc newImPlotAnnotationCollection*(): void {.importc: "ImPlotAnnotationCollection_ImPlotAnnotationCollection".}
proc reset*(self: ptr ImPlotAnnotationCollection): void {.importc: "ImPlotAnnotationCollection_Reset".}
proc destroy*(self: ptr ImPlotAnnotationCollection): void {.importc: "ImPlotAnnotationCollection_destroy".}
proc newImPlotAnnotation*(): void {.importc: "ImPlotAnnotation_ImPlotAnnotation".}
proc destroy*(self: ptr ImPlotAnnotation): void {.importc: "ImPlotAnnotation_destroy".}
proc applyFit*(self: ptr ImPlotAxis, padding: float32): void {.importc: "ImPlotAxis_ApplyFit".}
proc canInitFit*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_CanInitFit".}
proc constrain*(self: ptr ImPlotAxis): void {.importc: "ImPlotAxis_Constrain".}
proc extendFit*(self: ptr ImPlotAxis, v: cfloat64): void {.importc: "ImPlotAxis_ExtendFit".}
proc extendFitWith*(self: ptr ImPlotAxis, alt: ptr ImPlotAxis, v: cfloat64, v_alt: cfloat64): void {.importc: "ImPlotAxis_ExtendFitWith".}
proc getAspect*(self: ptr ImPlotAxis): cfloat64 {.importc: "ImPlotAxis_GetAspect".}
proc hasGridLines*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_HasGridLines".}
proc hasLabel*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_HasLabel".}
proc hasMenus*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_HasMenus".}
proc hasTickLabels*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_HasTickLabels".}
proc hasTickMarks*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_HasTickMarks".}
proc newImPlotAxis*(): void {.importc: "ImPlotAxis_ImPlotAxis".}
proc isAutoFitting*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsAutoFitting".}
proc isForeground*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsForeground".}
proc isInputLocked*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsInputLocked".}
proc isInputLockedMax*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsInputLockedMax".}
proc isInputLockedMin*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsInputLockedMin".}
proc isInverted*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsInverted".}
proc isLocked*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsLocked".}
proc isLockedMax*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsLockedMax".}
proc isLockedMin*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsLockedMin".}
proc isOpposite*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsOpposite".}
proc isPanLocked*(self: ptr ImPlotAxis, increasing: bool): bool {.importc: "ImPlotAxis_IsPanLocked".}
proc isRangeLocked*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_IsRangeLocked".}
proc pixelSize*(self: ptr ImPlotAxis): float32 {.importc: "ImPlotAxis_PixelSize".}
proc pixelsToPlot*(self: ptr ImPlotAxis, pix: float32): cfloat64 {.importc: "ImPlotAxis_PixelsToPlot".}
proc plotToPixels*(self: ptr ImPlotAxis, plt: cfloat64): float32 {.importc: "ImPlotAxis_PlotToPixels".}
proc pullLinks*(self: ptr ImPlotAxis): void {.importc: "ImPlotAxis_PullLinks".}
proc pushLinks*(self: ptr ImPlotAxis): void {.importc: "ImPlotAxis_PushLinks".}
proc reset*(self: ptr ImPlotAxis): void {.importc: "ImPlotAxis_Reset".}
proc setAspect*(self: ptr ImPlotAxis, unit_per_pix: cfloat64): void {.importc: "ImPlotAxis_SetAspect".}
proc setMax*(self: ptr ImPlotAxis, max: cfloat64, force: bool = false): bool {.importc: "ImPlotAxis_SetMax".}
proc setMin*(self: ptr ImPlotAxis, min: cfloat64, force: bool = false): bool {.importc: "ImPlotAxis_SetMin".}
proc setRange*(self: ptr ImPlotAxis, v1: cfloat64, v2: cfloat64): void {.importc: "ImPlotAxis_SetRange_double".}
proc setRange*(self: ptr ImPlotAxis, Range: ImPlotRange): void {.importc: "ImPlotAxis_SetRange_PlotRange".}
proc updateTransformCache*(self: ptr ImPlotAxis): void {.importc: "ImPlotAxis_UpdateTransformCache".}
proc willRender*(self: ptr ImPlotAxis): bool {.importc: "ImPlotAxis_WillRender".}
proc destroy*(self: ptr ImPlotAxis): void {.importc: "ImPlotAxis_destroy".}
proc append*(self: ptr ImPlotColormapData, name: cstring, keys: ptr uint32, count: int, qual: bool): int {.importc: "ImPlotColormapData_Append".}
proc getIndex*(self: ptr ImPlotColormapData, name: cstring): ImPlotColormap {.importc: "ImPlotColormapData_GetIndex".}
proc getKeyColor*(self: ptr ImPlotColormapData, cmap: ImPlotColormap, idx: int): uint32 {.importc: "ImPlotColormapData_GetKeyColor".}
proc getKeyCount*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): int {.importc: "ImPlotColormapData_GetKeyCount".}
proc getKeys*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): ptr uint32 {.importc: "ImPlotColormapData_GetKeys".}
proc getName*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): cstring {.importc: "ImPlotColormapData_GetName".}
proc getTable*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): ptr uint32 {.importc: "ImPlotColormapData_GetTable".}
proc getTableColor*(self: ptr ImPlotColormapData, cmap: ImPlotColormap, idx: int): uint32 {.importc: "ImPlotColormapData_GetTableColor".}
proc getTableSize*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): int {.importc: "ImPlotColormapData_GetTableSize".}
proc newImPlotColormapData*(): void {.importc: "ImPlotColormapData_ImPlotColormapData".}
proc isQual*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): bool {.importc: "ImPlotColormapData_IsQual".}
proc lerpTable*(self: ptr ImPlotColormapData, cmap: ImPlotColormap, t: float32): uint32 {.importc: "ImPlotColormapData_LerpTable".}
proc rebuildTables*(self: ptr ImPlotColormapData): void {.importc: "ImPlotColormapData_RebuildTables".}
proc setKeyColor*(self: ptr ImPlotColormapData, cmap: ImPlotColormap, idx: int, value: uint32): void {.importc: "ImPlotColormapData_SetKeyColor".}
proc AppendTable*(self: ptr ImPlotColormapData, cmap: ImPlotColormap): void {.importc: "ImPlotColormapData__AppendTable".}
proc destroy*(self: ptr ImPlotColormapData): void {.importc: "ImPlotColormapData_destroy".}
proc newImPlotDateTimeSpec*(): void {.importc: "ImPlotDateTimeSpec_ImPlotDateTimeSpec_Nil".}
proc newImPlotDateTimeSpec*(date_fmt: ImPlotDateFmt, time_fmt: ImPlotTimeFmt, use_24_hr_clk: bool = false, use_iso_8601: bool = false): void {.importc: "ImPlotDateTimeSpec_ImPlotDateTimeSpec_PlotDateFmt".}
proc destroy*(self: ptr ImPlotDateTimeSpec): void {.importc: "ImPlotDateTimeSpec_destroy".}
proc newImPlotInputMap*(): void {.importc: "ImPlotInputMap_ImPlotInputMap".}
proc destroy*(self: ptr ImPlotInputMap): void {.importc: "ImPlotInputMap_destroy".}
proc getItem*(self: ptr ImPlotItemGroup, id: ImGuiID): ptr ImPlotItem {.importc: "ImPlotItemGroup_GetItem_ID".}
proc getItem*(self: ptr ImPlotItemGroup, label_id: cstring): ptr ImPlotItem {.importc: "ImPlotItemGroup_GetItem_Str".}
proc getItemByIndex*(self: ptr ImPlotItemGroup, i: int): ptr ImPlotItem {.importc: "ImPlotItemGroup_GetItemByIndex".}
proc getItemCount*(self: ptr ImPlotItemGroup): int {.importc: "ImPlotItemGroup_GetItemCount".}
proc getItemID*(self: ptr ImPlotItemGroup, label_id: cstring): ImGuiID {.importc: "ImPlotItemGroup_GetItemID".}
proc getItemIndex*(self: ptr ImPlotItemGroup, item: ptr ImPlotItem): int {.importc: "ImPlotItemGroup_GetItemIndex".}
proc getLegendCount*(self: ptr ImPlotItemGroup): int {.importc: "ImPlotItemGroup_GetLegendCount".}
proc getLegendItem*(self: ptr ImPlotItemGroup, i: int): ptr ImPlotItem {.importc: "ImPlotItemGroup_GetLegendItem".}
proc getLegendLabel*(self: ptr ImPlotItemGroup, i: int): cstring {.importc: "ImPlotItemGroup_GetLegendLabel".}
proc getOrAddItem*(self: ptr ImPlotItemGroup, id: ImGuiID): ptr ImPlotItem {.importc: "ImPlotItemGroup_GetOrAddItem".}
proc newImPlotItemGroup*(): void {.importc: "ImPlotItemGroup_ImPlotItemGroup".}
proc reset*(self: ptr ImPlotItemGroup): void {.importc: "ImPlotItemGroup_Reset".}
proc destroy*(self: ptr ImPlotItemGroup): void {.importc: "ImPlotItemGroup_destroy".}
proc newImPlotItem*(): void {.importc: "ImPlotItem_ImPlotItem".}
proc destroy*(self: ptr ImPlotItem): void {.importc: "ImPlotItem_destroy".}
proc newImPlotLegend*(): void {.importc: "ImPlotLegend_ImPlotLegend".}
proc reset*(self: ptr ImPlotLegend): void {.importc: "ImPlotLegend_Reset".}
proc destroy*(self: ptr ImPlotLegend): void {.importc: "ImPlotLegend_destroy".}
proc newImPlotNextItemData*(): void {.importc: "ImPlotNextItemData_ImPlotNextItemData".}
proc reset*(self: ptr ImPlotNextItemData): void {.importc: "ImPlotNextItemData_Reset".}
proc destroy*(self: ptr ImPlotNextItemData): void {.importc: "ImPlotNextItemData_destroy".}
proc newImPlotNextPlotData*(): void {.importc: "ImPlotNextPlotData_ImPlotNextPlotData".}
proc reset*(self: ptr ImPlotNextPlotData): void {.importc: "ImPlotNextPlotData_Reset".}
proc destroy*(self: ptr ImPlotNextPlotData): void {.importc: "ImPlotNextPlotData_destroy".}
proc clearTextBuffer*(self: ptr ImPlotPlot): void {.importc: "ImPlotPlot_ClearTextBuffer".}
proc enabledAxesX*(self: ptr ImPlotPlot): int {.importc: "ImPlotPlot_EnabledAxesX".}
proc enabledAxesY*(self: ptr ImPlotPlot): int {.importc: "ImPlotPlot_EnabledAxesY".}
proc getAxisLabel*(self: ptr ImPlotPlot, axis: ImPlotAxis): cstring {.importc: "ImPlotPlot_GetAxisLabel".}
proc getTitle*(self: ptr ImPlotPlot): cstring {.importc: "ImPlotPlot_GetTitle".}
proc hasTitle*(self: ptr ImPlotPlot): bool {.importc: "ImPlotPlot_HasTitle".}
proc newImPlotPlot*(): void {.importc: "ImPlotPlot_ImPlotPlot".}
proc isInputLocked*(self: ptr ImPlotPlot): bool {.importc: "ImPlotPlot_IsInputLocked".}
proc setAxisLabel*(self: ptr ImPlotPlot, axis: ptr ImPlotAxis, label: cstring): void {.importc: "ImPlotPlot_SetAxisLabel".}
proc setTitle*(self: ptr ImPlotPlot, title: cstring): void {.importc: "ImPlotPlot_SetTitle".}
proc xAxis*(self: ptr ImPlotPlot, i: int): ptr ImPlotAxis {.importc: "ImPlotPlot_XAxis_Nil".}
proc yAxis*(self: ptr ImPlotPlot, i: int): ptr ImPlotAxis {.importc: "ImPlotPlot_YAxis_Nil".}
proc destroy*(self: ptr ImPlotPlot): void {.importc: "ImPlotPlot_destroy".}
proc newImPlotPointError*(x: cfloat64, y: cfloat64, neg: cfloat64, pos: cfloat64): void {.importc: "ImPlotPointError_ImPlotPointError".}
proc destroy*(self: ptr ImPlotPointError): void {.importc: "ImPlotPointError_destroy".}
proc newImPlotPoint*(): void {.importc: "ImPlotPoint_ImPlotPoint_Nil".}
proc newImPlotPoint*(x: cfloat64, y: cfloat64): void {.importc: "ImPlotPoint_ImPlotPoint_double".}
proc newImPlotPoint*(p: ImVec2): void {.importc: "ImPlotPoint_ImPlotPoint_Vec2".}
proc destroy*(self: ptr ImPlotPoint): void {.importc: "ImPlotPoint_destroy".}
proc clamp*(self: ptr ImPlotRange, value: cfloat64): cfloat64 {.importc: "ImPlotRange_Clamp".}
proc contains*(self: ptr ImPlotRange, value: cfloat64): bool {.importc: "ImPlotRange_Contains".}
proc newImPlotRange*(): void {.importc: "ImPlotRange_ImPlotRange_Nil".}
proc newImPlotRange*(min: cfloat64, max: cfloat64): void {.importc: "ImPlotRange_ImPlotRange_double".}
proc size*(self: ptr ImPlotRange): cfloat64 {.importc: "ImPlotRange_Size".}
proc destroy*(self: ptr ImPlotRange): void {.importc: "ImPlotRange_destroy".}
proc clampNonUDT*(pOut: ptr ImPlotPoint, self: ptr ImPlotRect, p: ImPlotPoint): void {.importc: "ImPlotRect_Clamp_PlotPoInt".}
proc clampNonUDT2*(pOut: ptr ImPlotPoint, self: ptr ImPlotRect, x: cfloat64, y: cfloat64): void {.importc: "ImPlotRect_Clamp_double".}
proc contains*(self: ptr ImPlotRect, p: ImPlotPoint): bool {.importc: "ImPlotRect_Contains_PlotPoInt".}
proc contains*(self: ptr ImPlotRect, x: cfloat64, y: cfloat64): bool {.importc: "ImPlotRect_Contains_double".}
proc newImPlotRect*(): void {.importc: "ImPlotRect_ImPlotRect_Nil".}
proc newImPlotRect*(x_min: cfloat64, x_max: cfloat64, y_min: cfloat64, y_max: cfloat64): void {.importc: "ImPlotRect_ImPlotRect_double".}
proc maxNonUDT*(pOut: ptr ImPlotPoint, self: ptr ImPlotRect): void {.importc: "ImPlotRect_Max".}
proc minNonUDT*(pOut: ptr ImPlotPoint, self: ptr ImPlotRect): void {.importc: "ImPlotRect_Min".}
proc sizeNonUDT*(pOut: ptr ImPlotPoint, self: ptr ImPlotRect): void {.importc: "ImPlotRect_Size".}
proc destroy*(self: ptr ImPlotRect): void {.importc: "ImPlotRect_destroy".}
proc newImPlotStyle*(): void {.importc: "ImPlotStyle_ImPlotStyle".}
proc destroy*(self: ptr ImPlotStyle): void {.importc: "ImPlotStyle_destroy".}
proc newImPlotSubplot*(): void {.importc: "ImPlotSubplot_ImPlotSubplot".}
proc destroy*(self: ptr ImPlotSubplot): void {.importc: "ImPlotSubplot_destroy".}
proc append*(self: ptr ImPlotTagCollection, axis: ImAxis, value: cfloat64, bg: uint32, fg: uint32, fmt: cstring): void {.importc: "ImPlotTagCollection_Append", varargs.}
proc appendV*(self: ptr ImPlotTagCollection, axis: ImAxis, value: cfloat64, bg: uint32, fg: uint32, fmt: cstring): void {.importc: "ImPlotTagCollection_AppendV", varargs.}
proc getText*(self: ptr ImPlotTagCollection, idx: int): cstring {.importc: "ImPlotTagCollection_GetText".}
proc newImPlotTagCollection*(): void {.importc: "ImPlotTagCollection_ImPlotTagCollection".}
proc reset*(self: ptr ImPlotTagCollection): void {.importc: "ImPlotTagCollection_Reset".}
proc destroy*(self: ptr ImPlotTagCollection): void {.importc: "ImPlotTagCollection_destroy".}
proc newImPlotTick*(value: cfloat64, major: bool, level: int, show_label: bool): void {.importc: "ImPlotTick_ImPlotTick".}
proc destroy*(self: ptr ImPlotTick): void {.importc: "ImPlotTick_destroy".}
proc addTick*(self: ptr ImPlotTicker, value: cfloat64, major: bool, level: int, show_label: bool, label: cstring): ptr ImPlotTick {.importc: "ImPlotTicker_AddTick_doubleStr".}
proc addTick*(self: ptr ImPlotTicker, value: cfloat64, major: bool, level: int, show_label: bool, formatter: ImPlotFormatter, data: pointer): ptr ImPlotTick {.importc: "ImPlotTicker_AddTick_doublePlotFormatter".}
proc addTick*(self: ptr ImPlotTicker, tick: ImPlotTick): ptr ImPlotTick {.importc: "ImPlotTicker_AddTick_PlotTick".}
proc getText*(self: ptr ImPlotTicker, idx: int): cstring {.importc: "ImPlotTicker_GetText_Int".}
proc getText*(self: ptr ImPlotTicker, tick: ImPlotTick): cstring {.importc: "ImPlotTicker_GetText_PlotTick".}
proc newImPlotTicker*(): void {.importc: "ImPlotTicker_ImPlotTicker".}
proc overrideSizeLate*(self: ptr ImPlotTicker, size: ImVec2): void {.importc: "ImPlotTicker_OverrideSizeLate".}
proc reset*(self: ptr ImPlotTicker): void {.importc: "ImPlotTicker_Reset".}
proc tickCount*(self: ptr ImPlotTicker): int {.importc: "ImPlotTicker_TickCount".}
proc destroy*(self: ptr ImPlotTicker): void {.importc: "ImPlotTicker_destroy".}
proc fromDoubleNonUDT*(pOut: ptr ImPlotTime, t: cfloat64): void {.importc: "ImPlotTime_FromDouble".}
proc newImPlotTime*(): void {.importc: "ImPlotTime_ImPlotTime_Nil".}
proc newImPlotTime*(s: int32, us: int = 0): void {.importc: "ImPlotTime_ImPlotTime_time_t".}
proc rollOver*(self: ptr ImPlotTime): void {.importc: "ImPlotTime_RollOver".}
proc toDouble*(self: ptr ImPlotTime): cfloat64 {.importc: "ImPlotTime_ToDouble".}
proc destroy*(self: ptr ImPlotTime): void {.importc: "ImPlotTime_destroy".}
proc ipAddColormap*(name: cstring, cols: ptr ImVec4, size: int, qual: bool = true): ImPlotColormap {.importc: "ImPlot_AddColormap_Vec4Ptr".}
proc ipAddColormap*(name: cstring, cols: ptr uint32, size: int, qual: bool = true): ImPlotColormap {.importc: "ImPlot_AddColormap_U32Ptr".}
proc ipAddTextCentered*(drawList: ptr ImDrawList, top_center: ImVec2, col: uint32, text_begin: cstring, text_end: cstring = nullptr): void {.importc: "ImPlot_AddTextCentered".}
proc ipAddTextVertical*(drawList: ptr ImDrawList, pos: ImVec2, col: uint32, text_begin: cstring, text_end: cstring = nullptr): void {.importc: "ImPlot_AddTextVertical".}
proc ipAddTimeNonUDT*(pOut: ptr ImPlotTime, t: ImPlotTime, unit: ImPlotTimeUnit, count: int): void {.importc: "ImPlot_AddTime".}
proc ipAllAxesInputLocked*(axes: ptr ImPlotAxis, count: int): bool {.importc: "ImPlot_AllAxesInputLocked".}
proc ipAnnotation*(x: cfloat64, y: cfloat64, col: ImVec4, pix_offset: ImVec2, clamp: bool, round: bool = false): void {.importc: "ImPlot_Annotation_Bool".}
proc ipAnnotation*(x: cfloat64, y: cfloat64, col: ImVec4, pix_offset: ImVec2, clamp: bool, fmt: cstring): void {.importc: "ImPlot_Annotation_Str", varargs.}
proc ipAnnotationV*(x: cfloat64, y: cfloat64, col: ImVec4, pix_offset: ImVec2, clamp: bool, fmt: cstring): void {.importc: "ImPlot_AnnotationV", varargs.}
proc ipAnyAxesHeld*(axes: ptr ImPlotAxis, count: int): bool {.importc: "ImPlot_AnyAxesHeld".}
proc ipAnyAxesHovered*(axes: ptr ImPlotAxis, count: int): bool {.importc: "ImPlot_AnyAxesHovered".}
proc ipAnyAxesInputLocked*(axes: ptr ImPlotAxis, count: int): bool {.importc: "ImPlot_AnyAxesInputLocked".}
proc ipBeginAlignedPlots*(group_id: cstring, vertical: bool = true): bool {.importc: "ImPlot_BeginAlignedPlots".}
proc ipBeginDragDropSourceAxis*(axis: ImAxis, flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): bool {.importc: "ImPlot_BeginDragDropSourceAxis".}
proc ipBeginDragDropSourceItem*(label_id: cstring, flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): bool {.importc: "ImPlot_BeginDragDropSourceItem".}
proc ipBeginDragDropSourcePlot*(flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): bool {.importc: "ImPlot_BeginDragDropSourcePlot".}
proc ipBeginDragDropTargetAxis*(axis: ImAxis): bool {.importc: "ImPlot_BeginDragDropTargetAxis".}
proc ipBeginDragDropTargetLegend*(): bool {.importc: "ImPlot_BeginDragDropTargetLegend".}
proc ipBeginDragDropTargetPlot*(): bool {.importc: "ImPlot_BeginDragDropTargetPlot".}
proc ipBeginItem*(label_id: cstring, flags: ImPlotItemFlags = 0.ImPlotItemFlags, recolor_from: ImPlotCol = cast[ImPlotcol](-1)): bool {.importc: "ImPlot_BeginItem".}
proc ipBeginLegendPopup*(label_id: cstring, mouse_button: ImGuiMouseButton = 1.ImGuiMouseButton): bool {.importc: "ImPlot_BeginLegendPopup".}
proc ipBeginPlot*(title_id: cstring, size: ImVec2 = ImVec2(x: -1, y: 0), flags: ImPlotFlags = 0.ImPlotFlags): bool {.importc: "ImPlot_BeginPlot".}
proc ipBeginSubplots*(title_id: cstring, rows: int, cols: int, size: ImVec2, flags: ImPlotSubplotFlags = 0.ImPlotSubplotFlags, row_ratios: ptr float32 = nullptr, col_ratios: ptr float32 = nullptr): bool {.importc: "ImPlot_BeginSubplots".}
proc ipBustColorCache*(plot_title_id: cstring = nullptr): void {.importc: "ImPlot_BustColorCache".}
proc ipBustItemCache*(): void {.importc: "ImPlot_BustItemCache".}
proc ipBustPlotCache*(): void {.importc: "ImPlot_BustPlotCache".}
proc ipCalcHoverColor*(col: uint32): uint32 {.importc: "ImPlot_CalcHoverColor".}
proc ipCalcLegendSizeNonUDT*(pOut: ptr ImVec2, items: ptr ImPlotItemGroup, pad: ImVec2, spacing: ImVec2, vertical: bool): void {.importc: "ImPlot_CalcLegendSize".}
proc ipCalcTextColor*(bg: ImVec4): uint32 {.importc: "ImPlot_CalcTextColor_Vec4".}
proc ipCalcTextColor*(bg: uint32): uint32 {.importc: "ImPlot_CalcTextColor_U32".}
proc ipCalcTextSizeVerticalNonUDT*(pOut: ptr ImVec2, text: cstring): void {.importc: "ImPlot_CalcTextSizeVertical".}
proc ipCalculateBins*(values: ptr float32, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_FloatPtr".}
proc ipCalculateBins*(values: ptr cfloat64, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_doublePtr".}
proc ipCalculateBins*(values: ptr int8, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_S8Ptr".}
proc ipCalculateBins*(values: ptr uint8, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_U8Ptr".}
proc ipCalculateBins*(values: ptr int16, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_S16Ptr".}
proc ipCalculateBins*(values: ptr uint16, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_U16Ptr".}
proc ipCalculateBins*(values: ptr int32, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_S32Ptr".}
proc ipCalculateBins*(values: ptr uint32, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_U32Ptr".}
proc ipCalculateBins*(values: ptr int64, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_S64Ptr".}
proc ipCalculateBins*(values: ptr uint64, count: int, meth: ImPlotBin, Range: ImPlotRange, bins_out: ptr int, width_out: ptr cfloat64): void {.importc: "ImPlot_CalculateBins_U64Ptr".}
proc ipCancelPlotSelection*(): void {.importc: "ImPlot_CancelPlotSelection".}
proc ipCeilTimeNonUDT*(pOut: ptr ImPlotTime, t: ImPlotTime, unit: ImPlotTimeUnit): void {.importc: "ImPlot_CeilTime".}
proc ipClampLabelPosNonUDT*(pOut: ptr ImVec2, pos: ImVec2, size: ImVec2, min: ImVec2, max: ImVec2): void {.importc: "ImPlot_ClampLabelPos".}
proc ipColormapButton*(label: cstring, size: ImVec2 = ImVec2(x: 0, y: 0), cmap: ImPlotColormap = cast[ImPlotcolormap](-1)): bool {.importc: "ImPlot_ColormapButton".}
proc ipColormapIcon*(cmap: ImPlotColormap): void {.importc: "ImPlot_ColormapIcon".}
proc ipColormapScale*(label: cstring, scale_min: cfloat64, scale_max: cfloat64, size: ImVec2 = ImVec2(x: 0, y: 0), format: cstring = "%g", flags: ImPlotColormapScaleFlags = 0.ImPlotColormapScaleFlags, cmap: ImPlotColormap = cast[ImPlotcolormap](-1)): void {.importc: "ImPlot_ColormapScale".}
proc ipColormapSlider*(label: cstring, t: ptr float32, `out`: ptr ImVec4 = nullptr, format: cstring = "", cmap: ImPlotColormap = cast[ImPlotcolormap](-1)): bool {.importc: "ImPlot_ColormapSlider".}
proc ipCombineDateTimeNonUDT*(pOut: ptr ImPlotTime, date_part: ImPlotTime, time_part: ImPlotTime): void {.importc: "ImPlot_CombineDateTime".}
proc ipCreateContext*(): ptr ImPlotContext {.importc: "ImPlot_CreateContext".}
proc ipDestroyContext*(ctx: ptr ImPlotContext = nullptr): void {.importc: "ImPlot_DestroyContext".}
proc ipDragLineX*(id: int, x: ptr cfloat64, col: ImVec4, thickness: float32 = 1, flags: ImPlotDragToolFlags = 0.ImPlotDragToolFlags): bool {.importc: "ImPlot_DragLineX".}
proc ipDragLineY*(id: int, y: ptr cfloat64, col: ImVec4, thickness: float32 = 1, flags: ImPlotDragToolFlags = 0.ImPlotDragToolFlags): bool {.importc: "ImPlot_DragLineY".}
proc ipDragPoint*(id: int, x: ptr cfloat64, y: ptr cfloat64, col: ImVec4, size: float32 = 4, flags: ImPlotDragToolFlags = 0.ImPlotDragToolFlags): bool {.importc: "ImPlot_DragPoint".}
proc ipDragRect*(id: int, x1: ptr cfloat64, y1: ptr cfloat64, x2: ptr cfloat64, y2: ptr cfloat64, col: ImVec4, flags: ImPlotDragToolFlags = 0.ImPlotDragToolFlags): bool {.importc: "ImPlot_DragRect".}
proc ipEndAlignedPlots*(): void {.importc: "ImPlot_EndAlignedPlots".}
proc ipEndDragDropSource*(): void {.importc: "ImPlot_EndDragDropSource".}
proc ipEndDragDropTarget*(): void {.importc: "ImPlot_EndDragDropTarget".}
proc ipEndItem*(): void {.importc: "ImPlot_EndItem".}
proc ipEndLegendPopup*(): void {.importc: "ImPlot_EndLegendPopup".}
proc ipEndPlot*(): void {.importc: "ImPlot_EndPlot".}
proc ipEndSubplots*(): void {.importc: "ImPlot_EndSubplots".}
proc ipFillRange*(buffer: ptr ImVector[float32], n: int, vmin: float32, vmax: float32): void {.importc: "ImPlot_FillRange_Vector_Float_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[cfloat64], n: int, vmin: cfloat64, vmax: cfloat64): void {.importc: "ImPlot_FillRange_Vector_double_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[int8], n: int, vmin: int8, vmax: int8): void {.importc: "ImPlot_FillRange_Vector_S8_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[uint8], n: int, vmin: uint8, vmax: uint8): void {.importc: "ImPlot_FillRange_Vector_U8_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[int16], n: int, vmin: int16, vmax: int16): void {.importc: "ImPlot_FillRange_Vector_S16_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[uint16], n: int, vmin: uint16, vmax: uint16): void {.importc: "ImPlot_FillRange_Vector_U16_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[int32], n: int, vmin: int32, vmax: int32): void {.importc: "ImPlot_FillRange_Vector_S32_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[uint32], n: int, vmin: uint32, vmax: uint32): void {.importc: "ImPlot_FillRange_Vector_U32_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[int64], n: int, vmin: int64, vmax: int64): void {.importc: "ImPlot_FillRange_Vector_S64_Ptr".}
proc ipFillRange*(buffer: ptr ImVector[uint64], n: int, vmin: uint64, vmax: uint64): void {.importc: "ImPlot_FillRange_Vector_U64_Ptr".}
proc ipFitPoint*(p: ImPlotPoint): void {.importc: "ImPlot_FitPoint".}
proc ipFitPointX*(x: cfloat64): void {.importc: "ImPlot_FitPointX".}
proc ipFitPointY*(y: cfloat64): void {.importc: "ImPlot_FitPointY".}
proc ipFitThisFrame*(): bool {.importc: "ImPlot_FitThisFrame".}
proc ipFloorTimeNonUDT*(pOut: ptr ImPlotTime, t: ImPlotTime, unit: ImPlotTimeUnit): void {.importc: "ImPlot_FloorTime".}
proc ipFormatDate*(t: ImPlotTime, buffer: cstring, size: int, fmt: ImPlotDateFmt, use_iso_8601: bool): int {.importc: "ImPlot_FormatDate".}
proc ipFormatDateTime*(t: ImPlotTime, buffer: cstring, size: int, fmt: ImPlotDateTimeSpec): int {.importc: "ImPlot_FormatDateTime".}
proc ipFormatTime*(t: ImPlotTime, buffer: cstring, size: int, fmt: ImPlotTimeFmt, use_24_hr_clk: bool): int {.importc: "ImPlot_FormatTime".}
proc ipFormatter_Default*(value: cfloat64, buff: cstring, size: int, data: pointer): int {.importc: "ImPlot_Formatter_Default".}
proc ipFormatter_Logit*(value: cfloat64, buff: cstring, size: int, noname1: pointer): int {.importc: "ImPlot_Formatter_Logit".}
proc ipFormatter_Time*(noname1: cfloat64, buff: cstring, size: int, data: pointer): int {.importc: "ImPlot_Formatter_Time".}
proc ipGetAutoColorNonUDT*(pOut: ptr ImVec4, idx: ImPlotCol): void {.importc: "ImPlot_GetAutoColor".}
proc ipGetColormapColorNonUDT*(pOut: ptr ImVec4, idx: int, cmap: ImPlotColormap = cast[ImPlotcolormap](-1)): void {.importc: "ImPlot_GetColormapColor".}
proc ipGetColormapColorU32*(idx: int, cmap: ImPlotColormap): uint32 {.importc: "ImPlot_GetColormapColorU32".}
proc ipGetColormapCount*(): int {.importc: "ImPlot_GetColormapCount".}
proc ipGetColormapIndex*(name: cstring): ImPlotColormap {.importc: "ImPlot_GetColormapIndex".}
proc ipGetColormapName*(cmap: ImPlotColormap): cstring {.importc: "ImPlot_GetColormapName".}
proc ipGetColormapSize*(cmap: ImPlotColormap = cast[ImPlotcolormap](-1)): int {.importc: "ImPlot_GetColormapSize".}
proc ipGetCurrentContext*(): ptr ImPlotContext {.importc: "ImPlot_GetCurrentContext".}
proc ipGetCurrentItem*(): ptr ImPlotItem {.importc: "ImPlot_GetCurrentItem".}
proc ipGetCurrentPlot*(): ptr ImPlotPlot {.importc: "ImPlot_GetCurrentPlot".}
proc ipGetDaysInMonth*(year: int, month: int): int {.importc: "ImPlot_GetDaysInMonth".}
proc ipGetGmtTime*(t: ImPlotTime, ptm: ptr tm): ptr tm {.importc: "ImPlot_GetGmtTime".}
proc ipGetInputMap*(): ptr ImPlotInputMap {.importc: "ImPlot_GetInputMap".}
proc ipGetItem*(label_id: cstring): ptr ImPlotItem {.importc: "ImPlot_GetItem".}
proc ipGetItemData*(): ptr ImPlotNextItemData {.importc: "ImPlot_GetItemData".}
proc ipGetLastItemColorNonUDT*(pOut: ptr ImVec4): void {.importc: "ImPlot_GetLastItemColor".}
proc ipGetLocTime*(t: ImPlotTime, ptm: ptr tm): ptr tm {.importc: "ImPlot_GetLocTime".}
proc ipGetLocationPosNonUDT*(pOut: ptr ImVec2, outer_rect: ImRect, inner_size: ImVec2, location: ImPlotLocation, pad: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "ImPlot_GetLocationPos".}
proc ipGetMarkerName*(idx: ImPlotMarker): cstring {.importc: "ImPlot_GetMarkerName".}
proc ipGetPlot*(title: cstring): ptr ImPlotPlot {.importc: "ImPlot_GetPlot".}
proc ipGetPlotDrawList*(): ptr ImDrawList {.importc: "ImPlot_GetPlotDrawList".}
proc ipGetPlotLimitsNonUDT*(pOut: ptr ImPlotRect, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_GetPlotLimits".}
proc ipGetPlotMousePosNonUDT*(pOut: ptr ImPlotPoint, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_GetPlotMousePos".}
proc ipGetPlotPosNonUDT*(pOut: ptr ImVec2): void {.importc: "ImPlot_GetPlotPos".}
proc ipGetPlotSelectionNonUDT*(pOut: ptr ImPlotRect, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_GetPlotSelection".}
proc ipGetPlotSizeNonUDT*(pOut: ptr ImVec2): void {.importc: "ImPlot_GetPlotSize".}
proc ipGetStyle*(): ptr ImPlotStyle {.importc: "ImPlot_GetStyle".}
proc ipGetStyleColorName*(idx: ImPlotCol): cstring {.importc: "ImPlot_GetStyleColorName".}
proc ipGetStyleColorU32*(idx: ImPlotCol): uint32 {.importc: "ImPlot_GetStyleColorU32".}
proc ipGetStyleColorVec4NonUDT*(pOut: ptr ImVec4, idx: ImPlotCol): void {.importc: "ImPlot_GetStyleColorVec4".}
proc ipGetYear*(t: ImPlotTime): int {.importc: "ImPlot_GetYear".}
proc ipHideNextItem*(hidden: bool = true, cond: ImPlotCond = ImPlotCond.Once): void {.importc: "ImPlot_HideNextItem".}
proc ipImAlmostEqual*(v1: cfloat64, v2: cfloat64, ulp: int = 2): bool {.importc: "ImPlot_ImAlmostEqual".}
proc ipImAlphaU32*(col: uint32, alpha: float32): uint32 {.importc: "ImPlot_ImAlphaU32".}
proc ipImAsinh*(x: float32): float32 {.importc: "ImPlot_ImAsinh_Float".}
proc ipImAsinh*(x: cfloat64): cfloat64 {.importc: "ImPlot_ImAsinh_double".}
proc ipImConstrainInf*(val: cfloat64): cfloat64 {.importc: "ImPlot_ImConstrainInf".}
proc ipImConstrainLog*(val: cfloat64): cfloat64 {.importc: "ImPlot_ImConstrainLog".}
proc ipImConstrainNan*(val: cfloat64): cfloat64 {.importc: "ImPlot_ImConstrainNan".}
proc ipImConstrainTime*(val: cfloat64): cfloat64 {.importc: "ImPlot_ImConstrainTime".}
proc ipImLerpU32*(colors: ptr uint32, size: int, t: float32): uint32 {.importc: "ImPlot_ImLerpU32".}
proc ipImLog10*(x: float32): float32 {.importc: "ImPlot_ImLog10_Float".}
proc ipImLog10*(x: cfloat64): cfloat64 {.importc: "ImPlot_ImLog10_double".}
proc ipImMaxArray*(values: ptr float32, count: int): float32 {.importc: "ImPlot_ImMaxArray_FloatPtr".}
proc ipImMaxArray*(values: ptr cfloat64, count: int): cfloat64 {.importc: "ImPlot_ImMaxArray_doublePtr".}
proc ipImMaxArray*(values: ptr int8, count: int): int8 {.importc: "ImPlot_ImMaxArray_S8Ptr".}
proc ipImMaxArray*(values: ptr uint8, count: int): uint8 {.importc: "ImPlot_ImMaxArray_U8Ptr".}
proc ipImMaxArray*(values: ptr int16, count: int): int16 {.importc: "ImPlot_ImMaxArray_S16Ptr".}
proc ipImMaxArray*(values: ptr uint16, count: int): uint16 {.importc: "ImPlot_ImMaxArray_U16Ptr".}
proc ipImMaxArray*(values: ptr int32, count: int): int32 {.importc: "ImPlot_ImMaxArray_S32Ptr".}
proc ipImMaxArray*(values: ptr uint32, count: int): uint32 {.importc: "ImPlot_ImMaxArray_U32Ptr".}
proc ipImMaxArray*(values: ptr int64, count: int): int64 {.importc: "ImPlot_ImMaxArray_S64Ptr".}
proc ipImMaxArray*(values: ptr uint64, count: int): uint64 {.importc: "ImPlot_ImMaxArray_U64Ptr".}
proc ipImMean*(values: ptr float32, count: int): cfloat64 {.importc: "ImPlot_ImMean_FloatPtr".}
proc ipImMean*(values: ptr cfloat64, count: int): cfloat64 {.importc: "ImPlot_ImMean_doublePtr".}
proc ipImMean*(values: ptr int8, count: int): cfloat64 {.importc: "ImPlot_ImMean_S8Ptr".}
proc ipImMean*(values: ptr uint8, count: int): cfloat64 {.importc: "ImPlot_ImMean_U8Ptr".}
proc ipImMean*(values: ptr int16, count: int): cfloat64 {.importc: "ImPlot_ImMean_S16Ptr".}
proc ipImMean*(values: ptr uint16, count: int): cfloat64 {.importc: "ImPlot_ImMean_U16Ptr".}
proc ipImMean*(values: ptr int32, count: int): cfloat64 {.importc: "ImPlot_ImMean_S32Ptr".}
proc ipImMean*(values: ptr uint32, count: int): cfloat64 {.importc: "ImPlot_ImMean_U32Ptr".}
proc ipImMean*(values: ptr int64, count: int): cfloat64 {.importc: "ImPlot_ImMean_S64Ptr".}
proc ipImMean*(values: ptr uint64, count: int): cfloat64 {.importc: "ImPlot_ImMean_U64Ptr".}
proc ipImMinArray*(values: ptr float32, count: int): float32 {.importc: "ImPlot_ImMinArray_FloatPtr".}
proc ipImMinArray*(values: ptr cfloat64, count: int): cfloat64 {.importc: "ImPlot_ImMinArray_doublePtr".}
proc ipImMinArray*(values: ptr int8, count: int): int8 {.importc: "ImPlot_ImMinArray_S8Ptr".}
proc ipImMinArray*(values: ptr uint8, count: int): uint8 {.importc: "ImPlot_ImMinArray_U8Ptr".}
proc ipImMinArray*(values: ptr int16, count: int): int16 {.importc: "ImPlot_ImMinArray_S16Ptr".}
proc ipImMinArray*(values: ptr uint16, count: int): uint16 {.importc: "ImPlot_ImMinArray_U16Ptr".}
proc ipImMinArray*(values: ptr int32, count: int): int32 {.importc: "ImPlot_ImMinArray_S32Ptr".}
proc ipImMinArray*(values: ptr uint32, count: int): uint32 {.importc: "ImPlot_ImMinArray_U32Ptr".}
proc ipImMinArray*(values: ptr int64, count: int): int64 {.importc: "ImPlot_ImMinArray_S64Ptr".}
proc ipImMinArray*(values: ptr uint64, count: int): uint64 {.importc: "ImPlot_ImMinArray_U64Ptr".}
proc ipImMinMaxArray*(values: ptr float32, count: int, min_out: ptr float32, max_out: ptr float32): void {.importc: "ImPlot_ImMinMaxArray_FloatPtr".}
proc ipImMinMaxArray*(values: ptr cfloat64, count: int, min_out: ptr cfloat64, max_out: ptr cfloat64): void {.importc: "ImPlot_ImMinMaxArray_doublePtr".}
proc ipImMinMaxArray*(values: ptr int8, count: int, min_out: ptr int8, max_out: ptr int8): void {.importc: "ImPlot_ImMinMaxArray_S8Ptr".}
proc ipImMinMaxArray*(values: ptr uint8, count: int, min_out: ptr uint8, max_out: ptr uint8): void {.importc: "ImPlot_ImMinMaxArray_U8Ptr".}
proc ipImMinMaxArray*(values: ptr int16, count: int, min_out: ptr int16, max_out: ptr int16): void {.importc: "ImPlot_ImMinMaxArray_S16Ptr".}
proc ipImMinMaxArray*(values: ptr uint16, count: int, min_out: ptr uint16, max_out: ptr uint16): void {.importc: "ImPlot_ImMinMaxArray_U16Ptr".}
proc ipImMinMaxArray*(values: ptr int32, count: int, min_out: ptr int32, max_out: ptr int32): void {.importc: "ImPlot_ImMinMaxArray_S32Ptr".}
proc ipImMinMaxArray*(values: ptr uint32, count: int, min_out: ptr uint32, max_out: ptr uint32): void {.importc: "ImPlot_ImMinMaxArray_U32Ptr".}
proc ipImMinMaxArray*(values: ptr int64, count: int, min_out: ptr int64, max_out: ptr int64): void {.importc: "ImPlot_ImMinMaxArray_S64Ptr".}
proc ipImMinMaxArray*(values: ptr uint64, count: int, min_out: ptr uint64, max_out: ptr uint64): void {.importc: "ImPlot_ImMinMaxArray_U64Ptr".}
proc ipImMixU32*(a: uint32, b: uint32, s: uint32): uint32 {.importc: "ImPlot_ImMixU32".}
proc ipImNan*(val: cfloat64): bool {.importc: "ImPlot_ImNan".}
proc ipImNanOrInf*(val: cfloat64): bool {.importc: "ImPlot_ImNanOrInf".}
proc ipImOverlaps*(min_a: float32, max_a: float32, min_b: float32, max_b: float32): bool {.importc: "ImPlot_ImOverlaps_Float".}
proc ipImOverlaps*(min_a: cfloat64, max_a: cfloat64, min_b: cfloat64, max_b: cfloat64): bool {.importc: "ImPlot_ImOverlaps_double".}
proc ipImOverlaps*(min_a: int8, max_a: int8, min_b: int8, max_b: int8): bool {.importc: "ImPlot_ImOverlaps_S8".}
proc ipImOverlaps*(min_a: uint8, max_a: uint8, min_b: uint8, max_b: uint8): bool {.importc: "ImPlot_ImOverlaps_U8".}
proc ipImOverlaps*(min_a: int16, max_a: int16, min_b: int16, max_b: int16): bool {.importc: "ImPlot_ImOverlaps_S16".}
proc ipImOverlaps*(min_a: uint16, max_a: uint16, min_b: uint16, max_b: uint16): bool {.importc: "ImPlot_ImOverlaps_U16".}
proc ipImOverlaps*(min_a: int32, max_a: int32, min_b: int32, max_b: int32): bool {.importc: "ImPlot_ImOverlaps_S32".}
proc ipImOverlaps*(min_a: uint32, max_a: uint32, min_b: uint32, max_b: uint32): bool {.importc: "ImPlot_ImOverlaps_U32".}
proc ipImOverlaps*(min_a: int64, max_a: int64, min_b: int64, max_b: int64): bool {.importc: "ImPlot_ImOverlaps_S64".}
proc ipImOverlaps*(min_a: uint64, max_a: uint64, min_b: uint64, max_b: uint64): bool {.importc: "ImPlot_ImOverlaps_U64".}
proc ipImPosMod*(l: int, r: int): int {.importc: "ImPlot_ImPosMod".}
proc ipImRemap*(x: float32, x0: float32, x1: float32, y0: float32, y1: float32): float32 {.importc: "ImPlot_ImRemap_Float".}
proc ipImRemap*(x: cfloat64, x0: cfloat64, x1: cfloat64, y0: cfloat64, y1: cfloat64): cfloat64 {.importc: "ImPlot_ImRemap_double".}
proc ipImRemap*(x: int8, x0: int8, x1: int8, y0: int8, y1: int8): int8 {.importc: "ImPlot_ImRemap_S8".}
proc ipImRemap*(x: uint8, x0: uint8, x1: uint8, y0: uint8, y1: uint8): uint8 {.importc: "ImPlot_ImRemap_U8".}
proc ipImRemap*(x: int16, x0: int16, x1: int16, y0: int16, y1: int16): int16 {.importc: "ImPlot_ImRemap_S16".}
proc ipImRemap*(x: uint16, x0: uint16, x1: uint16, y0: uint16, y1: uint16): uint16 {.importc: "ImPlot_ImRemap_U16".}
proc ipImRemap*(x: int32, x0: int32, x1: int32, y0: int32, y1: int32): int32 {.importc: "ImPlot_ImRemap_S32".}
proc ipImRemap*(x: uint32, x0: uint32, x1: uint32, y0: uint32, y1: uint32): uint32 {.importc: "ImPlot_ImRemap_U32".}
proc ipImRemap*(x: int64, x0: int64, x1: int64, y0: int64, y1: int64): int64 {.importc: "ImPlot_ImRemap_S64".}
proc ipImRemap*(x: uint64, x0: uint64, x1: uint64, y0: uint64, y1: uint64): uint64 {.importc: "ImPlot_ImRemap_U64".}
proc ipImRemap01*(x: float32, x0: float32, x1: float32): float32 {.importc: "ImPlot_ImRemap01_Float".}
proc ipImRemap01*(x: cfloat64, x0: cfloat64, x1: cfloat64): cfloat64 {.importc: "ImPlot_ImRemap01_double".}
proc ipImRemap01*(x: int8, x0: int8, x1: int8): int8 {.importc: "ImPlot_ImRemap01_S8".}
proc ipImRemap01*(x: uint8, x0: uint8, x1: uint8): uint8 {.importc: "ImPlot_ImRemap01_U8".}
proc ipImRemap01*(x: int16, x0: int16, x1: int16): int16 {.importc: "ImPlot_ImRemap01_S16".}
proc ipImRemap01*(x: uint16, x0: uint16, x1: uint16): uint16 {.importc: "ImPlot_ImRemap01_U16".}
proc ipImRemap01*(x: int32, x0: int32, x1: int32): int32 {.importc: "ImPlot_ImRemap01_S32".}
proc ipImRemap01*(x: uint32, x0: uint32, x1: uint32): uint32 {.importc: "ImPlot_ImRemap01_U32".}
proc ipImRemap01*(x: int64, x0: int64, x1: int64): int64 {.importc: "ImPlot_ImRemap01_S64".}
proc ipImRemap01*(x: uint64, x0: uint64, x1: uint64): uint64 {.importc: "ImPlot_ImRemap01_U64".}
proc ipImSinh*(x: float32): float32 {.importc: "ImPlot_ImSinh_Float".}
proc ipImSinh*(x: cfloat64): cfloat64 {.importc: "ImPlot_ImSinh_double".}
proc ipImStdDev*(values: ptr float32, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_FloatPtr".}
proc ipImStdDev*(values: ptr cfloat64, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_doublePtr".}
proc ipImStdDev*(values: ptr int8, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_S8Ptr".}
proc ipImStdDev*(values: ptr uint8, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_U8Ptr".}
proc ipImStdDev*(values: ptr int16, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_S16Ptr".}
proc ipImStdDev*(values: ptr uint16, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_U16Ptr".}
proc ipImStdDev*(values: ptr int32, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_S32Ptr".}
proc ipImStdDev*(values: ptr uint32, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_U32Ptr".}
proc ipImStdDev*(values: ptr int64, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_S64Ptr".}
proc ipImStdDev*(values: ptr uint64, count: int): cfloat64 {.importc: "ImPlot_ImStdDev_U64Ptr".}
proc ipImSum*(values: ptr float32, count: int): float32 {.importc: "ImPlot_ImSum_FloatPtr".}
proc ipImSum*(values: ptr cfloat64, count: int): cfloat64 {.importc: "ImPlot_ImSum_doublePtr".}
proc ipImSum*(values: ptr int8, count: int): int8 {.importc: "ImPlot_ImSum_S8Ptr".}
proc ipImSum*(values: ptr uint8, count: int): uint8 {.importc: "ImPlot_ImSum_U8Ptr".}
proc ipImSum*(values: ptr int16, count: int): int16 {.importc: "ImPlot_ImSum_S16Ptr".}
proc ipImSum*(values: ptr uint16, count: int): uint16 {.importc: "ImPlot_ImSum_U16Ptr".}
proc ipImSum*(values: ptr int32, count: int): int32 {.importc: "ImPlot_ImSum_S32Ptr".}
proc ipImSum*(values: ptr uint32, count: int): uint32 {.importc: "ImPlot_ImSum_U32Ptr".}
proc ipImSum*(values: ptr int64, count: int): int64 {.importc: "ImPlot_ImSum_S64Ptr".}
proc ipImSum*(values: ptr uint64, count: int): uint64 {.importc: "ImPlot_ImSum_U64Ptr".}
proc ipInitialize*(ctx: ptr ImPlotContext): void {.importc: "ImPlot_Initialize".}
proc ipIntersectionNonUDT*(pOut: ptr ImVec2, a1: ImVec2, a2: ImVec2, b1: ImVec2, b2: ImVec2): void {.importc: "ImPlot_Intersection".}
proc ipIsAxisHovered*(axis: ImAxis): bool {.importc: "ImPlot_IsAxisHovered".}
proc ipIsColorAuto*(col: ImVec4): bool {.importc: "ImPlot_IsColorAuto_Vec4".}
proc ipIsColorAuto*(idx: ImPlotCol): bool {.importc: "ImPlot_IsColorAuto_PlotCol".}
proc ipIsLeapYear*(year: int): bool {.importc: "ImPlot_IsLeapYear".}
proc ipIsLegendEntryHovered*(label_id: cstring): bool {.importc: "ImPlot_IsLegendEntryHovered".}
proc ipIsPlotHovered*(): bool {.importc: "ImPlot_IsPlotHovered".}
proc ipIsPlotSelected*(): bool {.importc: "ImPlot_IsPlotSelected".}
proc ipIsSubplotsHovered*(): bool {.importc: "ImPlot_IsSubplotsHovered".}
proc ipItemIcon*(col: ImVec4): void {.importc: "ImPlot_ItemIcon_Vec4".}
proc ipItemIcon*(col: uint32): void {.importc: "ImPlot_ItemIcon_U32".}
proc ipLabelAxisValue*(axis: ImPlotAxis, value: cfloat64, buff: cstring, size: int, round: bool = false): void {.importc: "ImPlot_LabelAxisValue".}
proc ipLocator_Default*(ticker: ptr ImPlotTicker, Range: ImPlotRange, pixels: float32, vertical: bool, formatter: ImPlotFormatter, formatter_data: pointer): void {.importc: "ImPlot_Locator_Default".}
proc ipLocator_Log10*(ticker: ptr ImPlotTicker, Range: ImPlotRange, pixels: float32, vertical: bool, formatter: ImPlotFormatter, formatter_data: pointer): void {.importc: "ImPlot_Locator_Log10".}
proc ipLocator_SymLog*(ticker: ptr ImPlotTicker, Range: ImPlotRange, pixels: float32, vertical: bool, formatter: ImPlotFormatter, formatter_data: pointer): void {.importc: "ImPlot_Locator_SymLog".}
proc ipLocator_Time*(ticker: ptr ImPlotTicker, Range: ImPlotRange, pixels: float32, vertical: bool, formatter: ImPlotFormatter, formatter_data: pointer): void {.importc: "ImPlot_Locator_Time".}
proc ipMakeTimeNonUDT*(pOut: ptr ImPlotTime, year: int, month: int = 0, day: int = 1, hour: int = 0, min: int = 0, sec: int = 0, us: int = 0): void {.importc: "ImPlot_MakeTime".}
proc ipMapInputDefault*(dst: ptr ImPlotInputMap = nullptr): void {.importc: "ImPlot_MapInputDefault".}
proc ipMapInputReverse*(dst: ptr ImPlotInputMap = nullptr): void {.importc: "ImPlot_MapInputReverse".}
proc ipMkGmtTimeNonUDT*(pOut: ptr ImPlotTime, ptm: ptr tm): void {.importc: "ImPlot_MkGmtTime".}
proc ipMkLocTimeNonUDT*(pOut: ptr ImPlotTime, ptm: ptr tm): void {.importc: "ImPlot_MkLocTime".}
proc ipNextColormapColorNonUDT*(pOut: ptr ImVec4): void {.importc: "ImPlot_NextColormapColor".}
proc ipNextColormapColorU32*(): uint32 {.importc: "ImPlot_NextColormapColorU32".}
proc ipNiceNum*(x: cfloat64, round: bool): cfloat64 {.importc: "ImPlot_NiceNum".}
proc ipOrderOfMagnitude*(val: cfloat64): int {.importc: "ImPlot_OrderOfMagnitude".}
proc ipOrderToPrecision*(order: int): int {.importc: "ImPlot_OrderToPrecision".}
proc ipPixelsToPlotNonUDT*(pOut: ptr ImPlotPoint, pix: ImVec2, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_PixelsToPlot_Vec2".}
proc ipPixelsToPlotNonUDT2*(pOut: ptr ImPlotPoint, x: float32, y: float32, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_PixelsToPlot_Float".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr float32, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_FloatPtr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr cfloat64, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_doublePtr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr int8, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_S8Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr uint8, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_U8Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr int16, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_S16Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr uint16, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_U16Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr int32, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_S32Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr uint32, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_U32Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr int64, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_S64Ptr".}
proc ipPlotBarGroups*(label_ids: ptr cstring, values: ptr uint64, item_count: int, group_count: int, group_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarGroupsFlags = 0.ImPlotBarGroupsFlags): void {.importc: "ImPlot_PlotBarGroups_U64Ptr".}
proc ipPlotBars*(label_id: cstring, values: ptr float32, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotBars_FloatPtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr cfloat64, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotBars_doublePtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr int8, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotBars_S8PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr uint8, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotBars_U8PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr int16, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotBars_S16PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr uint16, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotBars_U16PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr int32, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotBars_S32PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr uint32, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotBars_U32PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr int64, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotBars_S64PtrInt".}
proc ipPlotBars*(label_id: cstring, values: ptr uint64, count: int, bar_size: cfloat64 = 0.67, shift: cfloat64 = 0, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotBars_U64PtrInt".}
proc ipPlotBars*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotBars_FloatPtrFloatPtr".}
proc ipPlotBars*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotBars_doublePtrdoublePtr".}
proc ipPlotBars*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotBars_S8PtrS8Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotBars_U8PtrU8Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotBars_S16PtrS16Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotBars_U16PtrU16Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotBars_S32PtrS32Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotBars_U32PtrU32Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotBars_S64PtrS64Ptr".}
proc ipPlotBars*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotBars_U64PtrU64Ptr".}
proc ipPlotBarsG*(label_id: cstring, getter: ImPlotGetter, data: pointer, count: int, bar_size: cfloat64, flags: ImPlotBarsFlags = 0.ImPlotBarsFlags): void {.importc: "ImPlot_PlotBarsG".}
proc ipPlotDigital*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotDigital_FloatPtr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotDigital_doublePtr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotDigital_S8Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotDigital_U8Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotDigital_S16Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotDigital_U16Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotDigital_S32Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotDigital_U32Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotDigital_S64Ptr".}
proc ipPlotDigital*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotDigital_U64Ptr".}
proc ipPlotDigitalG*(label_id: cstring, getter: ImPlotGetter, data: pointer, count: int, flags: ImPlotDigitalFlags = 0.ImPlotDigitalFlags): void {.importc: "ImPlot_PlotDigitalG".}
proc ipPlotDummy*(label_id: cstring, flags: ImPlotDummyFlags = 0.ImPlotDummyFlags): void {.importc: "ImPlot_PlotDummy".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr float32, ys: ptr float32, err: ptr float32, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, err: ptr cfloat64, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int8, ys: ptr int8, err: ptr int8, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, err: ptr uint8, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int16, ys: ptr int16, err: ptr int16, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, err: ptr uint16, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int32, ys: ptr int32, err: ptr int32, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, err: ptr uint32, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int64, ys: ptr int64, err: ptr int64, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, err: ptr uint64, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrInt".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr float32, ys: ptr float32, neg: ptr float32, pos: ptr float32, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrFloatPtr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, neg: ptr cfloat64, pos: ptr cfloat64, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrdoublePtr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int8, ys: ptr int8, neg: ptr int8, pos: ptr int8, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrS8Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, neg: ptr uint8, pos: ptr uint8, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrU8Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int16, ys: ptr int16, neg: ptr int16, pos: ptr int16, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrS16Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, neg: ptr uint16, pos: ptr uint16, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrU16Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int32, ys: ptr int32, neg: ptr int32, pos: ptr int32, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrS32Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, neg: ptr uint32, pos: ptr uint32, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrU32Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr int64, ys: ptr int64, neg: ptr int64, pos: ptr int64, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrS64Ptr".}
proc ipPlotErrorBars*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, neg: ptr uint64, pos: ptr uint64, count: int, flags: ImPlotErrorBarsFlags = 0.ImPlotErrorBarsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrU64Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr float32, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_FloatPtr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr cfloat64, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_doublePtr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr int8, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_S8Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr uint8, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_U8Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr int16, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_S16Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr uint16, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_U16Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr int32, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_S32Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr uint32, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_U32Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr int64, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_S64Ptr".}
proc ipPlotHeatmap*(label_id: cstring, values: ptr uint64, rows: int, cols: int, scale_min: cfloat64 = 0, scale_max: cfloat64 = 0, label_fmt: cstring = "%.1f", bounds_min: ImPlotPoint = ImPlotPoint(x:0,y:0), bounds_max: ImPlotPoint = ImPlotPoint(x:1,y:1), flags: ImPlotHeatmapFlags = 0.ImPlotHeatmapFlags): void {.importc: "ImPlot_PlotHeatmap_U64Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr float32, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_FloatPtr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr cfloat64, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_doublePtr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr int8, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_S8Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr uint8, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_U8Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr int16, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_S16Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr uint16, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_U16Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr int32, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_S32Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr uint32, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_U32Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr int64, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_S64Ptr".}
proc ipPlotHistogram*(label_id: cstring, values: ptr uint64, count: int, bins: int = ImPlotBin.Sturges.int, bar_scale: cfloat64 = 1.0, Range: ImPlotRange = ImPlotRange(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram_U64Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_FloatPtr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_doublePtr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_S8Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_U8Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_S16Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_U16Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_S32Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_U32Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_S64Ptr".}
proc ipPlotHistogram2D*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, x_bins: int = ImPlotBin.Sturges.int, y_bins: int = ImPlotBin.Sturges.int, Range: ImPlotRect = ImPlotRect(), flags: ImPlotHistogramFlags = 0.ImPlotHistogramFlags): cfloat64 {.importc: "ImPlot_PlotHistogram2D_U64Ptr".}
proc ipPlotImage*(label_id: cstring, user_texture_id: ImTextureID, bounds_min: ImPlotPoint, bounds_max: ImPlotPoint, uv0: ImVec2 = ImVec2(x: 0, y: 0), uv1: ImVec2 = ImVec2(x: 1, y: 1), tint_col: ImVec4 = ImVec4(x: 1, y: 1, z: 1, w: 1), flags: ImPlotImageFlags = 0.ImPlotImageFlags): void {.importc: "ImPlot_PlotImage".}
proc ipPlotInfLines*(label_id: cstring, values: ptr float32, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotInfLines_FloatPtr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr cfloat64, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotInfLines_doublePtr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr int8, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotInfLines_S8Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr uint8, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotInfLines_U8Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr int16, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotInfLines_S16Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr uint16, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotInfLines_U16Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr int32, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotInfLines_S32Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr uint32, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotInfLines_U32Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr int64, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotInfLines_S64Ptr".}
proc ipPlotInfLines*(label_id: cstring, values: ptr uint64, count: int, flags: ImPlotInfLinesFlags = 0.ImPlotInfLinesFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotInfLines_U64Ptr".}
proc ipPlotLine*(label_id: cstring, values: ptr float32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotLine_FloatPtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr cfloat64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotLine_doublePtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr int8, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotLine_S8PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr uint8, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotLine_U8PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr int16, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotLine_S16PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr uint16, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotLine_U16PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr int32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotLine_S32PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr uint32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotLine_U32PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr int64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotLine_S64PtrInt".}
proc ipPlotLine*(label_id: cstring, values: ptr uint64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotLine_U64PtrInt".}
proc ipPlotLine*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotLine_FloatPtrFloatPtr".}
proc ipPlotLine*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotLine_doublePtrdoublePtr".}
proc ipPlotLine*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotLine_S8PtrS8Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotLine_U8PtrU8Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotLine_S16PtrS16Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotLine_U16PtrU16Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotLine_S32PtrS32Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotLine_U32PtrU32Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotLine_S64PtrS64Ptr".}
proc ipPlotLine*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotLine_U64PtrU64Ptr".}
proc ipPlotLineG*(label_id: cstring, getter: ImPlotGetter, data: pointer, count: int, flags: ImPlotLineFlags = 0.ImPlotLineFlags): void {.importc: "ImPlot_PlotLineG".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr float32, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_FloatPtr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr cfloat64, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_doublePtr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr int8, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_S8Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr uint8, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_U8Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr int16, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_S16Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr uint16, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_U16Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr int32, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_S32Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr uint32, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_U32Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr int64, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_S64Ptr".}
proc ipPlotPieChart*(label_ids: ptr cstring, values: ptr uint64, count: int, x: cfloat64, y: cfloat64, radius: cfloat64, label_fmt: cstring = "%.1f", angle0: cfloat64 = 90, flags: ImPlotPieChartFlags = 0.ImPlotPieChartFlags): void {.importc: "ImPlot_PlotPieChart_U64Ptr".}
proc ipPlotScatter*(label_id: cstring, values: ptr float32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotScatter_FloatPtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr cfloat64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotScatter_doublePtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr int8, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotScatter_S8PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr uint8, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotScatter_U8PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr int16, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotScatter_S16PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr uint16, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotScatter_U16PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr int32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotScatter_S32PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr uint32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotScatter_U32PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr int64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotScatter_S64PtrInt".}
proc ipPlotScatter*(label_id: cstring, values: ptr uint64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotScatter_U64PtrInt".}
proc ipPlotScatter*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotScatter_FloatPtrFloatPtr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotScatter_doublePtrdoublePtr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotScatter_S8PtrS8Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotScatter_U8PtrU8Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotScatter_S16PtrS16Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotScatter_U16PtrU16Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotScatter_S32PtrS32Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotScatter_U32PtrU32Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotScatter_S64PtrS64Ptr".}
proc ipPlotScatter*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotScatter_U64PtrU64Ptr".}
proc ipPlotScatterG*(label_id: cstring, getter: ImPlotGetter, data: pointer, count: int, flags: ImPlotScatterFlags = 0.ImPlotScatterFlags): void {.importc: "ImPlot_PlotScatterG".}
proc ipPlotShaded*(label_id: cstring, values: ptr float32, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotShaded_FloatPtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr cfloat64, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotShaded_doublePtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr int8, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotShaded_S8PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr uint8, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotShaded_U8PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr int16, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotShaded_S16PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr uint16, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotShaded_U16PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr int32, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotShaded_S32PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr uint32, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotShaded_U32PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr int64, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotShaded_S64PtrInt".}
proc ipPlotShaded*(label_id: cstring, values: ptr uint64, count: int, yref: cfloat64 = 0, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotShaded_U64PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotShaded_FloatPtrFloatPtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotShaded_doublePtrdoublePtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotShaded_S8PtrS8PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotShaded_U8PtrU8PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotShaded_S16PtrS16PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotShaded_U16PtrU16PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotShaded_S32PtrS32PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotShaded_U32PtrU32PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotShaded_S64PtrS64PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, yref: cfloat64 = 0, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotShaded_U64PtrU64PtrInt".}
proc ipPlotShaded*(label_id: cstring, xs: ptr float32, ys1: ptr float32, ys2: ptr float32, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotShaded_FloatPtrFloatPtrFloatPtr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr cfloat64, ys1: ptr cfloat64, ys2: ptr cfloat64, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotShaded_doublePtrdoublePtrdoublePtr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int8, ys1: ptr int8, ys2: ptr int8, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotShaded_S8PtrS8PtrS8Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint8, ys1: ptr uint8, ys2: ptr uint8, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotShaded_U8PtrU8PtrU8Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int16, ys1: ptr int16, ys2: ptr int16, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotShaded_S16PtrS16PtrS16Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint16, ys1: ptr uint16, ys2: ptr uint16, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotShaded_U16PtrU16PtrU16Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int32, ys1: ptr int32, ys2: ptr int32, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotShaded_S32PtrS32PtrS32Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint32, ys1: ptr uint32, ys2: ptr uint32, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotShaded_U32PtrU32PtrU32Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr int64, ys1: ptr int64, ys2: ptr int64, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotShaded_S64PtrS64PtrS64Ptr".}
proc ipPlotShaded*(label_id: cstring, xs: ptr uint64, ys1: ptr uint64, ys2: ptr uint64, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotShaded_U64PtrU64PtrU64Ptr".}
proc ipPlotShadedG*(label_id: cstring, getter1: ImPlotGetter, data1: pointer, getter2: ImPlotGetter, data2: pointer, count: int, flags: ImPlotShadedFlags = 0.ImPlotShadedFlags): void {.importc: "ImPlot_PlotShadedG".}
proc ipPlotStairs*(label_id: cstring, values: ptr float32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotStairs_FloatPtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr cfloat64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotStairs_doublePtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr int8, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotStairs_S8PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr uint8, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotStairs_U8PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr int16, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotStairs_S16PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr uint16, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotStairs_U16PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr int32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotStairs_S32PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr uint32, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotStairs_U32PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr int64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotStairs_S64PtrInt".}
proc ipPlotStairs*(label_id: cstring, values: ptr uint64, count: int, xscale: cfloat64 = 1, xstart: cfloat64 = 0, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotStairs_U64PtrInt".}
proc ipPlotStairs*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotStairs_FloatPtrFloatPtr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotStairs_doublePtrdoublePtr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotStairs_S8PtrS8Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotStairs_U8PtrU8Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotStairs_S16PtrS16Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotStairs_U16PtrU16Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotStairs_S32PtrS32Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotStairs_U32PtrU32Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotStairs_S64PtrS64Ptr".}
proc ipPlotStairs*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotStairs_U64PtrU64Ptr".}
proc ipPlotStairsG*(label_id: cstring, getter: ImPlotGetter, data: pointer, count: int, flags: ImPlotStairsFlags = 0.ImPlotStairsFlags): void {.importc: "ImPlot_PlotStairsG".}
proc ipPlotStems*(label_id: cstring, values: ptr float32, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotStems_FloatPtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr cfloat64, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotStems_doublePtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr int8, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotStems_S8PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr uint8, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotStems_U8PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr int16, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotStems_S16PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr uint16, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotStems_U16PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr int32, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotStems_S32PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr uint32, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotStems_U32PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr int64, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotStems_S64PtrInt".}
proc ipPlotStems*(label_id: cstring, values: ptr uint64, count: int, `ref`: cfloat64 = 0, scale: cfloat64 = 1, start: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotStems_U64PtrInt".}
proc ipPlotStems*(label_id: cstring, xs: ptr float32, ys: ptr float32, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(float32).int32): void {.importc: "ImPlot_PlotStems_FloatPtrFloatPtr".}
proc ipPlotStems*(label_id: cstring, xs: ptr cfloat64, ys: ptr cfloat64, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(cdouble).int32): void {.importc: "ImPlot_PlotStems_doublePtrdoublePtr".}
proc ipPlotStems*(label_id: cstring, xs: ptr int8, ys: ptr int8, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int8).int32): void {.importc: "ImPlot_PlotStems_S8PtrS8Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr uint8, ys: ptr uint8, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint8).int32): void {.importc: "ImPlot_PlotStems_U8PtrU8Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr int16, ys: ptr int16, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int16).int32): void {.importc: "ImPlot_PlotStems_S16PtrS16Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr uint16, ys: ptr uint16, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint16).int32): void {.importc: "ImPlot_PlotStems_U16PtrU16Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr int32, ys: ptr int32, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int32).int32): void {.importc: "ImPlot_PlotStems_S32PtrS32Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr uint32, ys: ptr uint32, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint32).int32): void {.importc: "ImPlot_PlotStems_U32PtrU32Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr int64, ys: ptr int64, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(int64).int32): void {.importc: "ImPlot_PlotStems_S64PtrS64Ptr".}
proc ipPlotStems*(label_id: cstring, xs: ptr uint64, ys: ptr uint64, count: int, `ref`: cfloat64 = 0, flags: ImPlotStemsFlags = 0.ImPlotStemsFlags, offset: int = 0, stride: int = sizeof(uint64).int32): void {.importc: "ImPlot_PlotStems_U64PtrU64Ptr".}
proc ipPlotText*(text: cstring, x: cfloat64, y: cfloat64, pix_offset: ImVec2 = ImVec2(x: 0, y: 0), flags: ImPlotTextFlags = 0.ImPlotTextFlags): void {.importc: "ImPlot_PlotText".}
proc ipPlotToPixelsNonUDT*(pOut: ptr ImVec2, plt: ImPlotPoint, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_PlotToPixels_PlotPoInt".}
proc ipPlotToPixelsNonUDT2*(pOut: ptr ImVec2, x: cfloat64, y: cfloat64, x_axis: ImAxis = cast[ImAxis](-1), y_axis: ImAxis = cast[ImAxis](-1)): void {.importc: "ImPlot_PlotToPixels_double".}
proc ipPopColormap*(count: int = 1): void {.importc: "ImPlot_PopColormap".}
proc ipPopPlotClipRect*(): void {.importc: "ImPlot_PopPlotClipRect".}
proc ipPopStyleColor*(count: int = 1): void {.importc: "ImPlot_PopStyleColor".}
proc ipPopStyleVar*(count: int = 1): void {.importc: "ImPlot_PopStyleVar".}
proc ipPrecision*(val: cfloat64): int {.importc: "ImPlot_Precision".}
proc ipPushColormap*(cmap: ImPlotColormap): void {.importc: "ImPlot_PushColormap_PlotColormap".}
proc ipPushColormap*(name: cstring): void {.importc: "ImPlot_PushColormap_Str".}
proc ipPushPlotClipRect*(expand: float32 = 0): void {.importc: "ImPlot_PushPlotClipRect".}
proc ipPushStyleColor*(idx: ImPlotCol, col: uint32): void {.importc: "ImPlot_PushStyleColor_U32".}
proc ipPushStyleColor*(idx: ImPlotCol, col: ImVec4): void {.importc: "ImPlot_PushStyleColor_Vec4".}
proc ipPushStyleVar*(idx: ImPlotStyleVar, val: float32): void {.importc: "ImPlot_PushStyleVar_Float".}
proc ipPushStyleVar*(idx: ImPlotStyleVar, val: int): void {.importc: "ImPlot_PushStyleVar_Int".}
proc ipPushStyleVar*(idx: ImPlotStyleVar, val: ImVec2): void {.importc: "ImPlot_PushStyleVar_Vec2".}
proc ipRangesOverlap*(r1: ImPlotRange, r2: ImPlotRange): bool {.importc: "ImPlot_RangesOverlap".}
proc ipRegisterOrGetItem*(label_id: cstring, flags: ImPlotItemFlags, just_created: ptr bool = nullptr): ptr ImPlotItem {.importc: "ImPlot_RegisterOrGetItem".}
proc ipRenderColorBar*(colors: ptr uint32, size: int, drawList: ptr ImDrawList, bounds: ImRect, vert: bool, reversed: bool, continuous: bool): void {.importc: "ImPlot_RenderColorBar".}
proc ipResetCtxForNextAlignedPlots*(ctx: ptr ImPlotContext): void {.importc: "ImPlot_ResetCtxForNextAlignedPlots".}
proc ipResetCtxForNextPlot*(ctx: ptr ImPlotContext): void {.importc: "ImPlot_ResetCtxForNextPlot".}
proc ipResetCtxForNextSubplot*(ctx: ptr ImPlotContext): void {.importc: "ImPlot_ResetCtxForNextSubplot".}
proc ipRoundTimeNonUDT*(pOut: ptr ImPlotTime, t: ImPlotTime, unit: ImPlotTimeUnit): void {.importc: "ImPlot_RoundTime".}
proc ipRoundTo*(val: cfloat64, prec: int): cfloat64 {.importc: "ImPlot_RoundTo".}
proc ipSampleColormapNonUDT*(pOut: ptr ImVec4, t: float32, cmap: ImPlotColormap = cast[ImPlotcolormap](-1)): void {.importc: "ImPlot_SampleColormap".}
proc ipSampleColormapU32*(t: float32, cmap: ImPlotColormap): uint32 {.importc: "ImPlot_SampleColormapU32".}
proc ipSetAxes*(x_axis: ImAxis, y_axis: ImAxis): void {.importc: "ImPlot_SetAxes".}
proc ipSetAxis*(axis: ImAxis): void {.importc: "ImPlot_SetAxis".}
proc ipSetCurrentContext*(ctx: ptr ImPlotContext): void {.importc: "ImPlot_SetCurrentContext".}
proc ipSetImGuiContext*(ctx: ptr ImGuiContext): void {.importc: "ImPlot_SetImGuiContext".}
proc ipSetNextAxesLimits*(x_min: cfloat64, x_max: cfloat64, y_min: cfloat64, y_max: cfloat64, cond: ImPlotCond = ImPlotCond.Once): void {.importc: "ImPlot_SetNextAxesLimits".}
proc ipSetNextAxesToFit*(): void {.importc: "ImPlot_SetNextAxesToFit".}
proc ipSetNextAxisLimits*(axis: ImAxis, v_min: cfloat64, v_max: cfloat64, cond: ImPlotCond = ImPlotCond.Once): void {.importc: "ImPlot_SetNextAxisLimits".}
proc ipSetNextAxisLinks*(axis: ImAxis, link_min: ptr cfloat64, link_max: ptr cfloat64): void {.importc: "ImPlot_SetNextAxisLinks".}
proc ipSetNextAxisToFit*(axis: ImAxis): void {.importc: "ImPlot_SetNextAxisToFit".}
proc ipSetNextErrorBarStyle*(col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: -1), size: float32 = -1, weight: float32 = -1): void {.importc: "ImPlot_SetNextErrorBarStyle".}
proc ipSetNextFillStyle*(col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: -1), alpha_mod: float32 = -1): void {.importc: "ImPlot_SetNextFillStyle".}
proc ipSetNextLineStyle*(col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: -1), weight: float32 = -1): void {.importc: "ImPlot_SetNextLineStyle".}
proc ipSetNextMarkerStyle*(marker: ImPlotMarker = -1.ImPlotMarker, size: float32 = -1, fill: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: -1), weight: float32 = -1, outline: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: -1)): void {.importc: "ImPlot_SetNextMarkerStyle".}
proc ipSetupAxes*(x_label: cstring, y_label: cstring, x_flags: ImPlotAxisFlags = 0.ImPlotAxisFlags, y_flags: ImPlotAxisFlags = 0.ImPlotAxisFlags): void {.importc: "ImPlot_SetupAxes".}
proc ipSetupAxesLimits*(x_min: cfloat64, x_max: cfloat64, y_min: cfloat64, y_max: cfloat64, cond: ImPlotCond = ImPlotCond.Once): void {.importc: "ImPlot_SetupAxesLimits".}
proc ipSetupAxis*(axis: ImAxis, label: cstring = nullptr, flags: ImPlotAxisFlags = 0.ImPlotAxisFlags): void {.importc: "ImPlot_SetupAxis".}
proc ipSetupAxisFormat*(axis: ImAxis, fmt: cstring): void {.importc: "ImPlot_SetupAxisFormat_Str".}
proc ipSetupAxisFormat*(axis: ImAxis, formatter: ImPlotFormatter, data: pointer = nullptr): void {.importc: "ImPlot_SetupAxisFormat_PlotFormatter".}
proc ipSetupAxisLimits*(axis: ImAxis, v_min: cfloat64, v_max: cfloat64, cond: ImPlotCond = ImPlotCond.Once): void {.importc: "ImPlot_SetupAxisLimits".}
proc ipSetupAxisLimitsConstraints*(axis: ImAxis, v_min: cfloat64, v_max: cfloat64): void {.importc: "ImPlot_SetupAxisLimitsConstraints".}
proc ipSetupAxisLinks*(axis: ImAxis, link_min: ptr cfloat64, link_max: ptr cfloat64): void {.importc: "ImPlot_SetupAxisLinks".}
proc ipSetupAxisScale*(axis: ImAxis, scale: ImPlotScale): void {.importc: "ImPlot_SetupAxisScale_PlotScale".}
proc ipSetupAxisScale*(axis: ImAxis, forward: ImPlotTransform, inverse: ImPlotTransform, data: pointer = nullptr): void {.importc: "ImPlot_SetupAxisScale_PlotTransform".}
proc ipSetupAxisTicks*(axis: ImAxis, values: ptr cfloat64, n_ticks: int, labels: ptr cstring = nullptr, keep_default: bool = false): void {.importc: "ImPlot_SetupAxisTicks_doublePtr".}
proc ipSetupAxisTicks*(axis: ImAxis, v_min: cfloat64, v_max: cfloat64, n_ticks: int, labels: ptr cstring = nullptr, keep_default: bool = false): void {.importc: "ImPlot_SetupAxisTicks_double".}
proc ipSetupAxisZoomConstraints*(axis: ImAxis, z_min: cfloat64, z_max: cfloat64): void {.importc: "ImPlot_SetupAxisZoomConstraints".}
proc ipSetupFinish*(): void {.importc: "ImPlot_SetupFinish".}
proc ipSetupLegend*(location: ImPlotLocation, flags: ImPlotLegendFlags = 0.ImPlotLegendFlags): void {.importc: "ImPlot_SetupLegend".}
proc ipSetupLock*(): void {.importc: "ImPlot_SetupLock".}
proc ipSetupMouseText*(location: ImPlotLocation, flags: ImPlotMouseTextFlags = 0.ImPlotMouseTextFlags): void {.importc: "ImPlot_SetupMouseText".}
proc ipShowAltLegend*(title_id: cstring, vertical: bool = true, size: ImVec2 = ImVec2(x: 0, y: 0), interactable: bool = true): void {.importc: "ImPlot_ShowAltLegend".}
proc ipShowAxisContextMenu*(axis: ptr ImPlotAxis, equal_axis: ptr ImPlotAxis, time_allowed: bool = false): void {.importc: "ImPlot_ShowAxisContextMenu".}
proc ipShowColormapSelector*(label: cstring): bool {.importc: "ImPlot_ShowColormapSelector".}
proc ipShowDatePicker*(id: cstring, level: ptr int, t: ptr ImPlotTime, t1: ptr ImPlotTime = nullptr, t2: ptr ImPlotTime = nullptr): bool {.importc: "ImPlot_ShowDatePicker".}
proc ipShowDemoWindow*(p_open: ptr bool = nullptr): void {.importc: "ImPlot_ShowDemoWindow".}
proc ipShowInputMapSelector*(label: cstring): bool {.importc: "ImPlot_ShowInputMapSelector".}
proc ipShowLegendContextMenu*(legend: ptr ImPlotLegend, visible: bool): bool {.importc: "ImPlot_ShowLegendContextMenu".}
proc ipShowLegendEntries*(items: ptr ImPlotItemGroup, legend_bb: ImRect, interactable: bool, pad: ImVec2, spacing: ImVec2, vertical: bool, drawList: ptr ImDrawList): bool {.importc: "ImPlot_ShowLegendEntries".}
proc ipShowMetricsWindow*(p_popen: ptr bool = nullptr): void {.importc: "ImPlot_ShowMetricsWindow".}
proc ipShowPlotContextMenu*(plot: ptr ImPlotPlot): void {.importc: "ImPlot_ShowPlotContextMenu".}
proc ipShowStyleEditor*(`ref`: ptr ImPlotStyle = nullptr): void {.importc: "ImPlot_ShowStyleEditor".}
proc ipShowStyleSelector*(label: cstring): bool {.importc: "ImPlot_ShowStyleSelector".}
proc ipShowSubplotsContextMenu*(subplot: ptr ImPlotSubplot): void {.importc: "ImPlot_ShowSubplotsContextMenu".}
proc ipShowTimePicker*(id: cstring, t: ptr ImPlotTime): bool {.importc: "ImPlot_ShowTimePicker".}
proc ipShowUserGuide*(): void {.importc: "ImPlot_ShowUserGuide".}
proc ipStyleColorsAuto*(dst: ptr ImPlotStyle = nullptr): void {.importc: "ImPlot_StyleColorsAuto".}
proc ipStyleColorsClassic*(dst: ptr ImPlotStyle = nullptr): void {.importc: "ImPlot_StyleColorsClassic".}
proc ipStyleColorsDark*(dst: ptr ImPlotStyle = nullptr): void {.importc: "ImPlot_StyleColorsDark".}
proc ipStyleColorsLight*(dst: ptr ImPlotStyle = nullptr): void {.importc: "ImPlot_StyleColorsLight".}
proc ipSubplotNextCell*(): void {.importc: "ImPlot_SubplotNextCell".}
proc ipTagX*(x: cfloat64, col: ImVec4, round: bool = false): void {.importc: "ImPlot_TagX_Bool".}
proc ipTagX*(x: cfloat64, col: ImVec4, fmt: cstring): void {.importc: "ImPlot_TagX_Str", varargs.}
proc ipTagXV*(x: cfloat64, col: ImVec4, fmt: cstring): void {.importc: "ImPlot_TagXV", varargs.}
proc ipTagY*(y: cfloat64, col: ImVec4, round: bool = false): void {.importc: "ImPlot_TagY_Bool".}
proc ipTagY*(y: cfloat64, col: ImVec4, fmt: cstring): void {.importc: "ImPlot_TagY_Str", varargs.}
proc ipTagYV*(y: cfloat64, col: ImVec4, fmt: cstring): void {.importc: "ImPlot_TagYV", varargs.}
proc ipTransformForward_Log10*(v: cfloat64, noname1: pointer): cfloat64 {.importc: "ImPlot_TransformForward_Log10".}
proc ipTransformForward_Logit*(v: cfloat64, noname1: pointer): cfloat64 {.importc: "ImPlot_TransformForward_Logit".}
proc ipTransformForward_SymLog*(v: cfloat64, noname1: pointer): cfloat64 {.importc: "ImPlot_TransformForward_SymLog".}
proc ipTransformInverse_Log10*(v: cfloat64, noname1: pointer): cfloat64 {.importc: "ImPlot_TransformInverse_Log10".}
proc ipTransformInverse_Logit*(v: cfloat64, noname1: pointer): cfloat64 {.importc: "ImPlot_TransformInverse_Logit".}
proc ipTransformInverse_SymLog*(v: cfloat64, noname1: pointer): cfloat64 {.importc: "ImPlot_TransformInverse_SymLog".}

{.pop.} # push dynlib / nodecl, etc...
{.pop.} # push warning[HoleEnumConv]: off


proc igStyleColorsCherry*(dst: ptr ImGuiStyle = nil): void =
  ## To conmemorate this bindings this style is included as a default.
  ## Style created originally by r-lyeh
  var style = igGetStyle()
  if dst != nil:
    style = dst

  const ImVec4 = proc(x: float32, y: float32, z: float32, w: float32): ImVec4 = ImVec4(x: x, y: y, z: z, w: w)
  const igHI = proc(v: float32): ImVec4 = ImVec4(0.502f, 0.075f, 0.256f, v)
  const igMED = proc(v: float32): ImVec4 = ImVec4(0.455f, 0.198f, 0.301f, v)
  const igLOW = proc(v: float32): ImVec4 = ImVec4(0.232f, 0.201f, 0.271f, v)
  const igBG = proc(v: float32): ImVec4 = ImVec4(0.200f, 0.220f, 0.270f, v)
  const igTEXT = proc(v: float32): ImVec4 = ImVec4(0.860f, 0.930f, 0.890f, v)

  style.colors[ImGuiCol.Text.int32]                 = igTEXT(0.88f)
  style.colors[ImGuiCol.TextDisabled.int32]         = igTEXT(0.28f)
  style.colors[ImGuiCol.WindowBg.int32]             = ImVec4(0.13f, 0.14f, 0.17f, 1.00f)
  style.colors[ImGuiCol.PopupBg.int32]              = igBG(0.9f)
  style.colors[ImGuiCol.Border.int32]               = ImVec4(0.31f, 0.31f, 1.00f, 0.00f)
  style.colors[ImGuiCol.BorderShadow.int32]         = ImVec4(0.00f, 0.00f, 0.00f, 0.00f)
  style.colors[ImGuiCol.FrameBg.int32]              = igBG(1.00f)
  style.colors[ImGuiCol.FrameBgHovered.int32]       = igMED(0.78f)
  style.colors[ImGuiCol.FrameBgActive.int32]        = igMED(1.00f)
  style.colors[ImGuiCol.TitleBg.int32]              = igLOW(1.00f)
  style.colors[ImGuiCol.TitleBgActive.int32]        = igHI(1.00f)
  style.colors[ImGuiCol.TitleBgCollapsed.int32]     = igBG(0.75f)
  style.colors[ImGuiCol.MenuBarBg.int32]            = igBG(0.47f)
  style.colors[ImGuiCol.ScrollbarBg.int32]          = igBG(1.00f)
  style.colors[ImGuiCol.ScrollbarGrab.int32]        = ImVec4(0.09f, 0.15f, 0.16f, 1.00f)
  style.colors[ImGuiCol.ScrollbarGrabHovered.int32] = igMED(0.78f)
  style.colors[ImGuiCol.ScrollbarGrabActive.int32]  = igMED(1.00f)
  style.colors[ImGuiCol.CheckMark.int32]            = ImVec4(0.71f, 0.22f, 0.27f, 1.00f)
  style.colors[ImGuiCol.SliderGrab.int32]           = ImVec4(0.47f, 0.77f, 0.83f, 0.14f)
  style.colors[ImGuiCol.SliderGrabActive.int32]     = ImVec4(0.71f, 0.22f, 0.27f, 1.00f)
  style.colors[ImGuiCol.Button.int32]               = ImVec4(0.47f, 0.77f, 0.83f, 0.14f)
  style.colors[ImGuiCol.ButtonHovered.int32]        = igMED(0.86f)
  style.colors[ImGuiCol.ButtonActive.int32]         = igMED(1.00f)
  style.colors[ImGuiCol.Header.int32]               = igMED(0.76f)
  style.colors[ImGuiCol.HeaderHovered.int32]        = igMED(0.86f)
  style.colors[ImGuiCol.HeaderActive.int32]         = igHI(1.00f)
  style.colors[ImGuiCol.ResizeGrip.int32]           = ImVec4(0.47f, 0.77f, 0.83f, 0.04f)
  style.colors[ImGuiCol.ResizeGripHovered.int32]    = igMED(0.78f)
  style.colors[ImGuiCol.ResizeGripActive.int32]     = igMED(1.00f)
  style.colors[ImGuiCol.PlotLines.int32]            = igTEXT(0.63f)
  style.colors[ImGuiCol.PlotLinesHovered.int32]     = igMED(1.00f)
  style.colors[ImGuiCol.PlotHistogram.int32]        = igTEXT(0.63f)
  style.colors[ImGuiCol.PlotHistogramHovered.int32] = igMED(1.00f)
  style.colors[ImGuiCol.TextSelectedBg.int32]       = igMED(0.43f)

  style.windowPadding     = ImVec2(x: 6f, y: 4f)
  style.windowRounding    = 0.0f
  style.framePadding      = ImVec2(x: 5f, y: 2f)
  style.frameRounding     = 3.0f
  style.itemSpacing       = ImVec2(x: 7f, y: 1f)
  style.itemInnerSpacing  = ImVec2(x: 1f, y: 1f)
  style.touchExtraPadding = ImVec2(x: 0f, y: 0f)
  style.indentSpacing     = 6.0f
  style.scrollbarSize     = 12.0f
  style.scrollbarRounding = 16.0f
  style.grabMinSize       = 20.0f
  style.grabRounding      = 2.0f

  style.windowTitleAlign.x = 0.50f

  style.colors[ImGuiCol.Border.int32] = ImVec4(0.539f, 0.479f, 0.255f, 0.162f)
  style.frameBorderSize  = 0.0f
  style.windowBorderSize = 1.0f

  style.displaySafeAreaPadding.y = 0
  style.framePadding.y = 1
  style.itemSpacing.y = 1
  style.windowPadding.y = 3
  style.scrollbarSize = 13
  style.frameBorderSize = 1
  style.tabBorderSize = 1