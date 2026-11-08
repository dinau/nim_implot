# Modified for ImPlot by dinau 2023/09
# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

import strutils, json, strformat, tables,
       algorithm, sets, re, ./utils
import pegs

const specPlotProcs = [
  "ImPlot_PlotBarGroups", "ImPlot_PlotBars", "ImPlot_PlotBarsG",
  "ImPlot_PlotBubbles", "ImPlot_PlotDigital", "ImPlot_PlotDigitalG",
  "ImPlot_PlotDummy", "ImPlot_PlotErrorBars", "ImPlot_PlotHeatmap",
  "ImPlot_PlotHistogram", "ImPlot_PlotHistogram2D", "ImPlot_PlotImage",
  "ImPlot_PlotInfLines", "ImPlot_PlotLine", "ImPlot_PlotLineG",
  "ImPlot_PlotPieChart", "ImPlot_PlotPolygon", "ImPlot_PlotScatter",
  "ImPlot_PlotScatterG", "ImPlot_PlotShaded", "ImPlot_PlotShadedG",
  "ImPlot_PlotStairs", "ImPlot_PlotStairsG", "ImPlot_PlotStems",
  "ImPlot_PlotText"
]
const nextStyleProcs = [
  "ImPlot_SetNextErrorBarStyle", "ImPlot_SetNextFillStyle",
  "ImPlot_SetNextLineStyle", "ImPlot_SetNextMarkerStyle"
]

var enums: HashSet[string]
var enumsCount: Table[string, int]

proc decho(str:string){.used.} =
  echo str

proc translateType(name: string): string # translateProc needs this

proc uncapitalize(str: string): string =
  if str.len < 1:
    result = ""
  else:
    result = toLowerAscii(str[0]) & str[1 ..< str.len]

proc isUpper(str: string): bool =
  for c in str:
    if not c.isUpperAscii():
      return false
  return true

proc translateProc(name: string): string =
  var nameSplit = name.replace(";", "").split("(*)", 1)
  let procType = nameSplit[0].translateType()

  nameSplit[1] = nameSplit[1][1 ..< nameSplit[1].len - 1]
  var isVarArgs = false
  var argsSplit = nameSplit[1].split(',')
  var argSeq: seq[tuple[name: string, kind: string]]
  var unnamedArgCounter = 0
  for arg in argsSplit:
    let argPieces = arg.replace(" const", "").rsplit(' ', 1)
    if argPieces[0] == "...":
      isVarArgs = true
      continue
    var argName = if argPieces.len == 1:
      inc(unnamedArgCounter)
      "unamed_arg_{unnamedArgCounter}".fmt
    else:
      argPieces[1]
    var argType = argPieces[0]
    if argName.contains('*'):
      argType.add('*')
      argName = argName.replace("*", "")
    if reservedWordsDictionary.contains(argName):
      argName = "`{argName}`".fmt
    argType = argType.translateType()
    argSeq.add((name: argName, kind: argType))

  result = "proc("
  for arg in argSeq:
    result.add("{arg.name}: {arg.kind}, ".fmt)
  if argSeq.len > 0:
    result = result[0 ..< result.len - 2]
  if isVarArgs:
    result.add("): {procType} {{.cdecl.}}".fmt)
  else:
    result.add("): {procType} {{.cdecl, varargs.}}".fmt)

proc translateArray(name: string): tuple[size: string, name: string] =
  let nameSplit = name.rsplit('[', 1)
  var arraySize = nameSplit[1]
  arraySize = arraySize[0 ..< arraySize.len - 1]
  if arraySize.contains("COUNT"):
    arraySize = $enumsCount[arraySize]
  if arraySize == "(0xFFFF+1)/4096/8": # If more continue to appear automate it
    arraySize = "2"
  result.size = arraySize
  result.name = nameSplit[0]

proc translateType(name: string): string =
  if name.contains("(") and name.contains(")"):
    return name.translateProc()
  if name == "const char* const[]":
    return "ptr cstring"
  result = name.replace("const ", "")
  result = result.replace("unsigned ", "u")
  result = result.replace("signed ", "")

  var depth = result.count('*')
  result = result.replace(" ", "")
  result = result.replace("*", "")
  result = result.replace("&", "")

  result = result.replace("time_t", "int32")
  result = result.replace("double", "cdouble") # TODO
  result = result.replace("structtm", "tm")
  result = result.replace("cfloat64", "cdouble") # TODO
  result = result.replace(" int", " int32")
  result = result.replace("size_t", "uint") # uint matches pointer size just like size_t
  result = result.replace("int3264_t", "int64")
  result = result.replace("float", "float32")
  result = result.replace("double", "float64") # TODO
  result = result.replace("short", "int16")
  result = result.replace("_Simple", "")
  if result.contains("char") and not result.contains("Wchar"):
    if result.contains("uchar"):
      result = "uint8"
    elif depth > 0:
      result = result.replace("char", "cstring")
      depth.dec
      if result.startsWith("u"):
        result = result[1 ..< result.len]
    else:
      result = result.replace("char", "int8")
  if depth > 0 and result.contains("void"):
    result = result.replace("void", "pointer")
    depth.dec

  result = result.replace("ImBitArrayForNamedKeys", "ImU32")
  result = result.replace("ImBitArray", "ImU32")
  result = result.replace("ImGuiWindowPtr", "ptr ImGuiWindow")
  result = result.replace("ImS8", "int8") # Doing it a little verbose to avoid issues in the future.
  result = result.replace("ImS16", "int16")
  result = result.replace("ImS32", "int32")
  result = result.replace("ImS64", "int64")
  result = result.replace("ImU8", "uint8")
  result = result.replace("ImU16", "uint16")
  result = result.replace("ImU32", "uint32")
  result = result.replace("ImU64", "uint64")
  result = result.replace("Pair", "ImPair")
  result = result.replace("ImFontPtr", "ptr ImFont")

  if result.startsWith("ImVector_"):
    result = result["ImVector_".len ..< result.len]
    result = "ImVector[{result}]".fmt

  result = result.replace("ImChunkStream_T", "ImChunkStream")

  result = result.replace("ImGuiStorageImPair", "ImGuiStoragePair")

  for d in 0 ..< depth:
    result = "ptr " & result
    if result == "ptr ptr ImDrawList":
      result = "UncheckedArray[ptr ImDrawList]"

  if result == "":
    result = "void"

proc cWrapperType(name: string): string =
  if name in ["ImPlotPoint", "ImPlotRange", "ImPlotRect", "ImPlotTime", "ImPlotDateTimeSpec",
              "ImVec2", "ImVec4", "ImTextureRef"]:
    result = name & "_c"
  else:
    result = name

proc cWrapperArgType(procName, argName, argType: string): string =
  if procName == "ImPlot_ColormapSlider" and argName == "out" or
     procName == "ImPlot_AddColormap_Vec4Ptr" and argName == "cols":
    result = "ptr ImVec4Cpp"
  else:
    result = cWrapperType(argType)

proc cWrapperCast(sourceType, destType, expression: string): string =
  if sourceType == destType:
    result = expression
  elif sourceType.startsWith("ptr "):
    result = "cast[{destType}]({expression})".fmt
  else:
    result = "cast[ptr {destType}](unsafeAddr({expression}))[]".fmt


proc genEnums(output: var string) =
  let file = readFile("src/implot/private/cimplot/generator/output/structs_and_enums.json")
  let data = file.parseJson()

  output.add("\n# Enums\ntype\n")

  var tableNamedKeys: Table[string, int]
  for name, obj in data["enums"].pairs:
    var enumName = name
    if enumName.endsWith("_"):
      enumName = name[0 ..< name.len - 1] # 末尾のアンダースコアをカット

    output.add("  {enumName}* {{.pure, size: int32.sizeof.}} = enum\n".fmt)
    enums.incl(enumName)
    var table: Table[int, string]
    for data in obj:
      var dataName = data["name"].getStr()          # ImAxis_X1
      let dataValue = data["calc_value"].getInt()   # 値は0
      dataName = dataName.replace("__", "_")
      dataName = dataName.split("_", 1)[1]          # dataName = X1 とする
      if dataName.endsWith("_"):                    # X1の末尾にアンダースコアがあれば排除
        dataName = dataName[0 ..< dataName.len - 1]
      if dataName.match(re"^[0-9]"):                # X1の先頭文字が 非数字 なら
        dataName = "`\"" & dataName & "\"`"         # `"X1"` とする
      if dataName.match(re".*COUNT$"):              #  "COUNT"を含むなら
        # enumsCount[ "ImPlotXXX_COUNT" ] = enumの値 とする
        enumsCount[data["name"].getStr()] = data["calc_value"].getInt()
        #echo data
        #continue
      if table.hasKey(dataValue):                   # enum値(=0)が既に存在するなら
        echo "Notice: Enum {enumName}.{dataName} already exists as {enumName}.{table[dataValue]} with value {dataValue}, use constant {enumName}_{dataName} to access it".fmt
        tableNamedKeys[enumName & "_" & dataName] = dataValue
        #tableNamedKeys[ "ImAxis" & "_" & "X1"]   = 0
        continue
      table[dataValue] = dataName                   # 0に `"X1"` を対応させる

    if enumName == "ImPlotMarker":
      table.clear()
      table[-2] = "None"
      table[-1] = "Auto"
      table[0] = "Circle"
      table[1] = "Square"
      table[2] = "Diamond"
      table[3] = "Up"
      table[4] = "Down"
      table[5] = "Left"
      table[6] = "Right"
      table[7] = "Cross"
      table[8] = "Plus"
      table[9] = "Asterisk"
      table[10] = "Vertical"
      table[11] = "Horizontal"
      table[12] = "COUNT"
    elif enumName == "ImPlotLegendFlags":
      table[128] = "Reverse"
    elif enumName == "ImPlotDragToolFlags":
      table[16] = "NoMove"
      table[32] = "NoResize"
    elif enumName == "ImPlotPieChartFlags":
      table[8192] = "NoSliceBorder"
    elif enumName == "ImPlotAxisFlags":
      table[65536] = "TickLabelsInside"
    elif enumName == "ImPlotCol":
      # The checked-in enum metadata is from a different ImPlot revision.
      table.clear()
      table[0] = "FrameBg"
      table[1] = "PlotBg"
      table[2] = "PlotBorder"
      table[3] = "LegendBg"
      table[4] = "LegendBorder"
      table[5] = "LegendText"
      table[6] = "TitleText"
      table[7] = "InlayText"
      table[8] = "AxisText"
      table[9] = "AxisGrid"
      table[10] = "AxisTick"
      table[11] = "AxisBg"
      table[12] = "AxisBgHovered"
      table[13] = "AxisBgActive"
      table[14] = "Selection"
      table[15] = "Crosshairs"
      table[16] = "COUNT"
      enumsCount["ImPlotCol_COUNT"] = 16
    elif enumName == "ImPlotStyleVar":
      # The checked-in enum metadata is stale; match the current implot.h declaration.
      table.clear()
      table[0] = "PlotDefaultSize"
      table[1] = "PlotMinSize"
      table[2] = "PlotBorderSize"
      table[3] = "MinorAlpha"
      table[4] = "MajorTickLen"
      table[5] = "MinorTickLen"
      table[6] = "MajorTickSize"
      table[7] = "MinorTickSize"
      table[8] = "MajorGridSize"
      table[9] = "MinorGridSize"
      table[10] = "PlotPadding"
      table[11] = "LabelPadding"
      table[12] = "LegendPadding"
      table[13] = "LegendInnerPadding"
      table[14] = "LegendSpacing"
      table[15] = "MousePosPadding"
      table[16] = "AnnotationPadding"
      table[17] = "FitPadding"
      table[18] = "DigitalPadding"
      table[19] = "DigitalSpacing"
      table[20] = "COUNT"
      enumsCount["ImPlotStyleVar_COUNT"] = 20

    var tableOrder: OrderedTable[int, string] # Weird error where data is erased if used directly
    for k, v in table.pairs: # Sort開始
      tableOrder[k] = v
    tableOrder.sort(system.cmp)

    for k, v in tableOrder.pairs: # Sort結果を出力
      output.add("    {v} = {k}\n".fmt) # X1 = 0

  if tableNamedKeys.len > 0: # 値が重複ものはconst に置き換える
    output.add("\n# Duplicate enums as consts\n")
    for k, v in tableNamedKeys.pairs:
      output.add("const {k}* = {v}\n".fmt)

proc genTypeDefs(output: var string) =
  # Must be run after genEnums
  let file = readFile("src/implot/private/cimplot/generator/output/typedefs_dict.json")
  let data = file.parseJson()

  output.add("\n# TypeDefs\ntype\n")

  for name, obj in data.pairs:
    let ignorable = ["const_iterator", "iterator", "value_type", "ImS8",
                     "ImS16", "ImS32", "ImS64", "ImU8", "ImU16", "ImU32",
                     "ImU64", "ImBitArrayForNamedKeys"]
    if obj.getStr().startsWith("struct") or enums.contains(name) or ignorable.contains(name):
      continue
    output.add("  {name}* = {obj.getStr().translateType()}\n".fmt)


proc genTypes(output: var string) =
  # Does not add a `type` keyword
  # Must be run after genEnums
  let file = readFile("src/implot/private/cimplot/generator/output/structs_and_enums.json")
  let data = file.parseJson()

  output.add("\n")
  #output.add(notDefinedStructs)

  for name, obj in data["structs"].pairs:
    if name == "Pair" or name == "ImGuiStoragePair" or name == "ImGuiStyleMod" or name == "ImGuiInputEvent":
      continue

    if name == "ImPlotStyle":
      output.add("""
  ImPlotStyle* {.importc: "ImPlotStyle", implot_header.} = object
    plotDefaultSize* {.importc: "PlotDefaultSize".}: ImVec2
    plotMinSize* {.importc: "PlotMinSize".}: ImVec2
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
    digitalPadding* {.importc: "DigitalPadding".}: float32
    digitalSpacing* {.importc: "DigitalSpacing".}: float32
    colors* {.importc: "Colors".}: array[16, ImVec4]
    colormap* {.importc: "Colormap".}: ImPlotColormap
    useLocalTime* {.importc: "UseLocalTime".}: bool
    useISO8601* {.importc: "UseISO8601".}: bool
    use24HourClock* {.importc: "Use24HourClock".}: bool
""")
      continue

    if name == "ImDrawChannel":
      output.add("  ImDrawChannel* {.importc: \"ImDrawChannel\", implot_header.} = ptr object\n")
      continue

    output.add("  {name}* {{.importc: \"{name}\", implot_header.}} = object\n".fmt)
    for member in obj:
      var memberName = member["name"].getStr()
      if memberName == "Ptr":
        memberName = "`ptr`"
      if memberName == "Type":
        memberName = "`type`"
      var memberImGuiName = "{{.importc: \"{memberName}\".}}".fmt
      if memberName.startsWith("_"):
        memberName = memberName[1 ..< memberName.len]
      if memberName.isUpper():
        memberName = memberName.normalize()
      memberName = memberName.uncapitalize()

      if memberImGuiName.contains('['):
        memberImGuiName = memberImGuiName[0 ..< memberImGuiName.find('[')] & "\".}"

      if not memberName.contains("["):
        if not member.contains("template_type"):
          output.add("    {memberName}* {memberImGuiName}: {member[\"type\"].getStr().translateType()}\n".fmt)
        else:
          # Assuming all template_type containers are ImVectors
          var templateType = member["template_type"].getStr()
          if templateType == "ImGui*OrIndex":
            templateType = "ImGuiPtrOrIndex"
          templateType = templateType.translateType()

          if templateType == "ImGuiTabBar": # Hope I don't regret this hardocoded if
            output.add("    {memberName}* {memberImGuiName}: ptr ImPool\n".fmt)
          elif templateType == "ImGuiColumns":
            output.add("    {memberName}* {memberImGuiName}: ImVectorImGuiColumns\n".fmt)
          else:
            output.add("    {memberName}* {memberImGuiName}: ImVector[{templateType}]\n".fmt)
        continue

      let arrayData = memberName.translateArray()
      output.add("    {arrayData[1]}* {memberImGuiName}: array[{arrayData[0]}, {member[\"type\"].getStr().translateType()}]\n".fmt)

  output.add("""
  ImVec2_c* {.importc: "ImVec2_c", implot_header.} = object
    x* {.importc: "x".}: float32
    y* {.importc: "y".}: float32
  ImVec4_c* {.importc: "ImVec4_c", implot_header.} = object
    x* {.importc: "x".}: float32
    y* {.importc: "y".}: float32
    z* {.importc: "z".}: float32
    w* {.importc: "w".}: float32
  ImVec4Cpp {.importc: "ImVec4", implot_header.} = object
  ImTextureRef_c* {.importc: "ImTextureRef_c", implot_header.} = object
    texData* {.importc: "_TexData".}: ptr ImTextureData
    texID* {.importc: "_TexID".}: ImTextureID
  ImPlotSpec* {.importc: "ImPlotSpec_c", implot_header.} = object
    lineColor* {.importc: "LineColor".}: ImVec4
    lineColors* {.importc: "LineColors".}: ptr uint32
    lineWeight* {.importc: "LineWeight".}: float32
    fillColor* {.importc: "FillColor".}: ImVec4
    fillColors* {.importc: "FillColors".}: ptr uint32
    fillAlpha* {.importc: "FillAlpha".}: float32
    marker* {.importc: "Marker".}: ImPlotMarker
    markerSize* {.importc: "MarkerSize".}: float32
    markerSizes* {.importc: "MarkerSizes".}: ptr float32
    markerLineColor* {.importc: "MarkerLineColor".}: ImVec4
    markerLineColors* {.importc: "MarkerLineColors".}: ptr uint32
    markerFillColor* {.importc: "MarkerFillColor".}: ImVec4
    markerFillColors* {.importc: "MarkerFillColors".}: ptr uint32
    size* {.importc: "Size".}: float32
    offset* {.importc: "Offset".}: cint
    stride* {.importc: "Stride".}: cint
    flags* {.importc: "Flags".}: ImPlotItemFlags
""")

  for name in ["ImPlotPoint", "ImPlotRange", "ImPlotRect", "ImPlotTime", "ImPlotDateTimeSpec"]:
    if not data["structs"].hasKey(name):
      continue
    output.add("  {name}_c* {{.importc: \"{name}_c\", implot_header.}} = object\n".fmt)
    for member in data["structs"][name]:
      let originalName = member["name"].getStr()
      var fieldName = originalName
      if fieldName == "Ptr":
        fieldName = "`ptr`"
      if fieldName == "Type":
        fieldName = "`type`"
      var pragma = "{{.importc: \"{originalName}\".}}".fmt
      if fieldName.startsWith("_"):
        fieldName = fieldName[1 ..< fieldName.len]
      if fieldName.isUpper():
        fieldName = fieldName.normalize()
      fieldName = fieldName.uncapitalize()
      if pragma.contains('['):
        pragma = pragma[0 ..< pragma.find('[')] & "\".}"
      output.add("    {fieldName}* {pragma}: {cWrapperType(member[\"type\"].getStr().translateType())}\n".fmt)

proc genProcs(output: var string) =
  let file = readFile("src/implot/private/cimplot/generator/output/definitions.json")
  let data = file.parseJson()
  var wrapperOutput = ""

  output.add("\n{preProcs}\n".fmt)

  for name, obj in data.pairs:
    var isNonUDT = false
    var nonUDTNumber = 0
    for variation in obj:
      if variation.contains("nonUDT"):
        nonUDTNumber.inc
        isNonUDT = true
      if blackListProc.contains(variation["cimguiname"].getStr()):
        continue
      if nextStyleProcs.contains(variation["cimguiname"].getStr()):
        continue
      if variation["cimguiname"].getStr() == "ImPlot_BeginItem":
        output.add("proc ipBeginItemRaw*(label_id: cstring, spec: ImPlotSpec, item_col: ImVec4_c, item_mkr: ImPlotMarker): bool {.importc: \"ImPlot_BeginItem\".}\n")
        wrapperOutput.add("""
proc ipBeginItem*(label_id: cstring, flags: ImPlotItemFlags = 0.ImPlotItemFlags,
                  recolor_from: ImPlotCol = cast[ImPlotCol](-1)): bool {.discardable.} =
  var spec = initImPlotSpec()
  spec.flags = flags
  var itemCol = ImVec4_c(x: 0, y: 0, z: 0, w: -1)
  if recolor_from != cast[ImPlotCol](-1):
    itemCol = ipGetStyleColorVec4NonUDTRaw(recolor_from)
  result = ipBeginItemRaw(label_id, spec, itemCol, cast[ImPlotMarker](-1))
""")
        continue

      # Name
      var funcname = ""
      if variation.contains("stname") and variation["stname"].getStr() != "":
        if variation.contains("destructor"):
          funcname = "destroy"
        else:
          funcname = variation["funcname"].getStr()
      else:
        funcname = variation["cimguiname"].getStr()
        #funcname = funcname.rsplit("_", 1)[1]

      if isNonUDT:
        funcname = funcname & "NonUDT"
        if nonUDTNumber != 1:
          funcname = funcname & $nonUDTNumber

      if variation.contains("constructor"):
        if funcname.startsWith("ImVector"):
          continue
        funcname = "new" & funcname.capitalizeAscii()

      if funcname.isUpper():
        funcname = funcname.normalize()
      funcname = funcname.uncapitalize()

      if funcname.startsWith("_"):
        funcname = funcname[1 ..< funcname.len]

      if reservedWordsDictionary.contains(funcname):
        funcname = "`{funcname}`".fmt

      var isGeneric = false
      var isVarArgs = variation.contains("isvararg") and variation["isvararg"].getBool()
      let isSpecProc = specPlotProcs.contains(variation["cimguiname"].getStr())

      var argsOutput = ""
      var cArgsOutput = ""
      var plainCallArgs = ""
      var specArgsOutput = ""
      var specNimArgsOutput = ""
      var specCallArgs = ""
      var specCallNimArgs = ""
      var specFlagsName = ""
      var specOffsetName = ""
      var specStrideName = ""
      let isOutParamWrapper = variation.contains("nonUDT") and
                              variation["argsT"].len > 0 and
                              variation["argsT"][0]["name"].getStr() == "pOut"
      var rawArgsOutput = ""
      var rawCallArgs = ""
      var rawReturnType = ""
      var outParamType = ""
      var hasCWrapperTypes = false
      # Args
      for arg in variation["argsT"]:
        var argName = arg["name"].getStr()
        var argType = arg["type"].getStr().translateType()
        if variation["cimguiname"].getStr() == "ImPlot_PlotImage" and
           argName == "user_texture_id":
          argType = "ImTextureRef"
        if arg.contains("custom_type"):
          let ctype = arg["custom_type"].getStr().split('_') # custom_type = "ImPlotPoint_getter"
          argType = ctype[0] & ctype[1][0].toUpperAscii() & ctype[1][1 ..< ctype[1].len]
          # argType == "ImPlotPointGetter"

        var argDefault = ""
        if variation.contains("defaults") and variation["defaults"].kind == JObject and
           variation["defaults"].contains(argName):
          argDefault = variation["defaults"][argName].getStr()
          argDefault = argDefault.replace("4294967295", "high(uint32)")
          argDefault = argDefault.replace("(((ImU32)(255)<<24)|((ImU32)(255)<<16)|((ImU32)(255)<<8)|((ImU32)(255)<<0))", "high(uint32)")
          argDefault = argDefault.replace("(((ImU32)(255)<<24)|((ImU32)(0)<<16)|((ImU32)(0)<<8)|((ImU32)(255)<<0))", "4278190335")
          argDefault = argDefault.replace("4278190335", "4278190335'u32")
          argDefault = argDefault.replace("FLT_MAX", "high(float32)")
          argDefault = argDefault.replace("((void*)0)", "nil")
          argDefault = argDefault.replace("NULL", "nil")
          argDefault = argDefault.replace("-FLT_MIN", "0")
          argDefault = argDefault.replace("~0", "-1")
          argDefault = argDefault.replace("sizeof(float)", "sizeof(float32).int32")

          argDefault = argDefault.replace("ImS8)" ,   "int8).int32") # Doing it a little verbose to avoid issues in the future.
          argDefault = argDefault.replace("ImS16)",  "int16).int32")
          argDefault = argDefault.replace("ImS32)",  "int32).int32")
          argDefault = argDefault.replace("ImS64)",  "int64).int32")
          argDefault = argDefault.replace("ImU8)" ,  "uint8).int32")
          argDefault = argDefault.replace("ImU16)", "uint16).int32")
          argDefault = argDefault.replace("ImU32)", "uint32).int32")
          argDefault = argDefault.replace("ImU64)", "uint64).int32")

          if argDefault.startsWith("ImVec"):
            let letters = ['x', 'y', 'z', 'w']
            var argPices = argDefault[7 ..< argDefault.len - 1].split(',')
            argDefault = argDefault[0 ..< 7]
            for p in 0 ..< argPices.len:
              argDefault.add("{letters[p]}: {argPices[p]}, ".fmt)
            argDefault = argDefault[0 ..< argDefault.len - 2] & ")"

          if (argType.startsWith("ImPlot") or argType.startsWith("Im")) and not argType.contains("Callback") and not argType.contains("ImVec"): # Ugly hack, should fix later
            argDefault.add(".{argType}".fmt)

        if argName.startsWith("_"):
          argName = argName[1 ..< argName.len]
        if argName.isUpper():
          argName = argName.normalize()
        argName = argName.uncapitalize()
        if argName == "range":
          argName = "Range"

        if reservedWordsDictionary.contains(argName):
          argName = "`{argName}`".fmt

        if argType.contains('[') and not argType.contains("ImVector[") and not argType.contains("UncheckedArray["):
          let arrayData = argType.translateArray()
          if arrayData[1].contains("cstringconst"):
            echo "{name}\n{obj.pretty}".fmt
          argType = "var array[{arrayData[0]}, {arrayData[1]}]".fmt
        argType = argType.replace(" {.cdecl.}", "")

        if argName == "..." or argType == "..." or argType == "va_list":
          isVarArgs = true
          continue
        if argType == "T" or argType == "ptr T":
          isGeneric = true

        let originalArgName = arg["name"].getStr()
        var wrapperProcName = variation["cimguiname"].getStr()
        if variation.contains("ov_cimguiname"):
          wrapperProcName = variation["ov_cimguiname"].getStr()
        let cArgType = cWrapperArgType(wrapperProcName, originalArgName, argType)
        var cArgDefault = argDefault
        if cArgType != argType and cArgType.endsWith("_c"):
          cArgDefault = cArgDefault.replace(argType & "(", cArgType & "(")
          cArgDefault = cArgDefault.replace("." & argType, "")
          if cArgType in ["ImPlotPoint_c", "ImPlotRange_c"] and
             cArgDefault.startsWith(cArgType & "("):
            let valuesStart = cArgType.len + 1
            let valuesEnd = cArgDefault.find(')', valuesStart)
            if valuesEnd >= 0:
              let values = cArgDefault[valuesStart ..< valuesEnd].split(',')
              if values.len == 2:
                let fields = if cArgType == "ImPlotPoint_c": ["x", "y"] else: ["min", "max"]
                cArgDefault = "{cArgType}({fields[0]}: {values[0].strip()}, {fields[1]}: {values[1].strip()})".fmt
        if cArgType != argType:
          hasCWrapperTypes = true
        if argDefault == "":
          cArgsOutput.add("{argName}: {cArgType}, ".fmt)
        else:
          cArgsOutput.add("{argName}: {cArgType} = {cArgDefault}, ".fmt)
        if plainCallArgs.len > 0:
          plainCallArgs.add(", ")
        plainCallArgs.add(cWrapperCast(argType, cArgType, argName))
        if argDefault == "":
          argsOutput.add("{argName}: {argType}, ".fmt)
        else:
          argsOutput.add("{argName}: {argType} = {argDefault}, ".fmt)
        if isOutParamWrapper:
          if originalArgName == "pOut":
            outParamType = argType.replace("ptr ", "")
            rawReturnType = cWrapperType(outParamType)
          else:
            if rawCallArgs.len > 0:
              rawCallArgs.add(", ")
            rawCallArgs.add(cWrapperCast(argType, cArgType, argName))
            if argDefault == "":
              rawArgsOutput.add("{argName}: {cArgType}, ".fmt)
            else:
              rawArgsOutput.add("{argName}: {cArgType} = {cArgDefault}, ".fmt)
        if isSpecProc:
          let specArgType = cArgType
          if originalArgName == "flags":
            specFlagsName = argName
          elif originalArgName == "offset":
            specOffsetName = argName
          elif originalArgName == "stride":
            specStrideName = argName
          else:
            if specCallArgs.len > 0:
              specCallArgs.add(", ")
            specCallArgs.add(cWrapperCast(argType, specArgType, argName))
            if specCallNimArgs.len > 0:
              specCallNimArgs.add(", ")
            specCallNimArgs.add(argName)
            if argDefault == "":
              specArgsOutput.add("{argName}: {specArgType}, ".fmt)
              specNimArgsOutput.add("{argName}: {argType}, ".fmt)
            else:
              specArgsOutput.add("{argName}: {specArgType} = {cArgDefault}, ".fmt)
              specNimArgsOutput.add("{argName}: {argType} = {argDefault}, ".fmt)
      if variation["argsT"].len > 0:
        argsOutput = argsOutput[0 ..< argsOutput.len - 2]
        cArgsOutput = cArgsOutput[0 ..< cArgsOutput.len - 2]
      if specArgsOutput.len > 0:
        specArgsOutput = specArgsOutput[0 ..< specArgsOutput.len - 2]
      if specNimArgsOutput.len > 0:
        specNimArgsOutput = specNimArgsOutput[0 ..< specNimArgsOutput.len - 2]
      if rawArgsOutput.len > 0:
        rawArgsOutput = rawArgsOutput[0 ..< rawArgsOutput.len - 2]

      # Ret
      var argRet = "void"
      if variation.contains("ret"):
        argRet = variation["ret"].getStr().translateType()
      if argRet == "T" or argRet == "ptr T":
        isGeneric = true
      if argRet == "explicit":
        argRet = "ptr ImVec2ih" # Ugly solution for a temporal problem
      let cArgRet = cWrapperType(argRet)
      if cArgRet != argRet:
        hasCWrapperTypes = true

      var pragmaName = variation["cimguiname"].getStr()
      if variation.contains("ov_cimguiname"):
        pragmaName = variation["ov_cimguiname"].getStr()
      for arg in variation["argsT"]:
        if arg.contains("custom_type") and
           arg["custom_type"].getStr() == "ImPlotPoint_getter":
          pragmaName.add("_LJ")
          break
      if pragmaName == "ImPlot_PlotToPixels_PlotPoInt":
        pragmaName = "ImPlot_PlotToPixels_PlotPoint"
      var specFuncname = funcname
      if specFuncname.startsWith("imPlot_"):
        specFuncname = "ip" & specFuncname["imPlot_".len ..< specFuncname.len]
      if isOutParamWrapper:
        let rawFuncname = specFuncname & "Raw"
        output.add("proc {rawFuncname}*".fmt)
        output.add(if isGeneric: "[T](" else: "(")
        output.add(rawArgsOutput)
        output.add("): {rawReturnType}".fmt)
        output.add(" {" & ".importc: \"{pragmaName}\"".fmt)
        output.add(".}\n")
        wrapperOutput.add("proc {funcname}*".fmt)
        wrapperOutput.add("(")
        wrapperOutput.add(argsOutput)
        wrapperOutput.add("): void {.discardable.} =\n")
        wrapperOutput.add("  let cResult = {rawFuncname}({rawCallArgs})\n".fmt)
        wrapperOutput.add("  pOut[] = {cWrapperCast(rawReturnType, outParamType, \"cResult\")}\n".fmt)
      elif isSpecProc:
        let hasCSpecArgs = specArgsOutput != specNimArgsOutput
        let rawSpecFuncname = if hasCSpecArgs or cArgRet == argRet:
          specFuncname & "_spec"
        else:
          specFuncname & "_specRaw"
        output.add("proc {rawSpecFuncname}*".fmt)
        output.add(if isGeneric: "[T](" else: "(")
        output.add(specArgsOutput)
        if specArgsOutput.len > 0:
          output.add(", ")
        output.add("spec: ImPlotSpec): {cArgRet}".fmt)
        output.add(" {" & ".importc: \"{pragmaName}\"".fmt)
        if isVarArgs:
          output.add(", varargs")
        output.add(".}\n")
        if hasCSpecArgs or cArgRet != argRet:
          wrapperOutput.add("proc {funcname}_spec*".fmt)
          wrapperOutput.add(if isGeneric: "[T](" else: "(")
          wrapperOutput.add(specNimArgsOutput)
          if specNimArgsOutput.len > 0:
            wrapperOutput.add(", ")
          wrapperOutput.add("spec: ImPlotSpec): {argRet} {{.discardable.}} =\n".fmt)
          if argRet != "void":
            if cArgRet != argRet:
              wrapperOutput.add("  let cResult = {rawSpecFuncname}({specCallArgs}, spec)\n".fmt)
              wrapperOutput.add("  result = {cWrapperCast(cArgRet, argRet, \"cResult\")}\n".fmt)
            else:
              wrapperOutput.add("  result = {rawSpecFuncname}({specCallArgs}, spec)\n".fmt)
          else:
            wrapperOutput.add("  {rawSpecFuncname}({specCallArgs}, spec)\n".fmt)

      if isSpecProc:
        wrapperOutput.add("proc {funcname}*".fmt)
        wrapperOutput.add(if isGeneric: "[T](" else: "(")
        wrapperOutput.add(argsOutput)
        wrapperOutput.add("): {argRet} {{.discardable.}} =\n".fmt)
        wrapperOutput.add("  var spec = initImPlotSpec()\n")
        wrapperOutput.add("  applyNextStyle(spec)\n")
        if specFlagsName.len > 0:
          wrapperOutput.add("  spec.flags = cast[ImPlotItemFlags]({specFlagsName})\n".fmt)
        if specOffsetName.len > 0:
          wrapperOutput.add("  spec.offset = {specOffsetName}.cint\n".fmt)
        if specStrideName.len > 0:
          wrapperOutput.add("  spec.stride = {specStrideName}.cint\n".fmt)
        if argRet != "void":
          if cArgRet != argRet:
            wrapperOutput.add("  let cResult = ")
          else:
            wrapperOutput.add("  result = ")
        else:
          wrapperOutput.add("  ")
        wrapperOutput.add("{specFuncname}_spec({specCallNimArgs}, spec)".fmt)
        if argRet != "void" and cArgRet != argRet:
          wrapperOutput.add("\n  result = {cWrapperCast(cArgRet, argRet, \"cResult\")}".fmt)
        wrapperOutput.add("\n")
      elif not isOutParamWrapper:
        if hasCWrapperTypes and not isVarArgs:
          let rawFuncname = specFuncname & "Raw"
          output.add("proc {rawFuncname}*".fmt)
          output.add(if isGeneric: "[T](" else: "(")
          output.add(cArgsOutput)
          output.add("): {cArgRet}".fmt)
          output.add(" {" & ".importc: \"{pragmaName}\"".fmt)
          output.add(".}\n")
          wrapperOutput.add("proc {funcname}*".fmt)
          wrapperOutput.add(if isGeneric: "[T](" else: "(")
          wrapperOutput.add(argsOutput)
          wrapperOutput.add("): {argRet} {{.discardable.}} =\n".fmt)
          if argRet != "void":
            if cArgRet != argRet:
              wrapperOutput.add("  let cResult = {rawFuncname}({plainCallArgs})\n".fmt)
              wrapperOutput.add("  result = {cWrapperCast(cArgRet, argRet, \"cResult\")}\n".fmt)
            else:
              wrapperOutput.add("  result = {rawFuncname}({plainCallArgs})\n".fmt)
          else:
            wrapperOutput.add("  {rawFuncname}({plainCallArgs})\n".fmt)
        else:
          output.add("proc {funcname}*".fmt)
          output.add(if isGeneric: "[T](" else: "(")
          output.add(argsOutput)
          output.add("): ")
          output.add(argRet)
          output.add(" {" & ".importc: \"{pragmaName}\"".fmt)
          if isVarArgs:
            output.add(", varargs")
          output.add(".}\n")

          let outSplit = output.rsplit("\n", 3)
          if outSplit[1] == outSplit[2] or outSplit[1].split('{')[0] == outSplit[2].split('{')[0]:
            output = "{outSplit[0]}\n{outSplit[1]}\n".fmt

  output.add("\n{postProcs}\n".fmt)
  output.add(wrapperOutput)

proc fixAfter(fname:string) =
  var s:seq[string]
  for line in fname.lines:
    var st = line
    # ignore line
    if st.toLowerAscii.contains(peg" '#' \s* 'noreplace' "):
      s.add st
      continue
    # cast issue
    st = st.replace(peg"'-1.ImPlotColormap'","cast[ImPlotcolormap](-1)")
    st = st.replace(peg"'-1.ImPlotCol'","cast[ImPlotcol](-1)")
    st = st.replace(peg"'-1.ImAxis'","cast[ImAxis](-1)")
    #
    st = st.replace(peg"'ImPlotRange().ImPlotRange'","ImPlotRange()")
    st = st.replace(peg"'ImPlotRect().ImPlotRect'","ImPlotRect()")
    #
    st = st.replace(peg"'ImPlotCond_Once.ImPlotCond'","ImPlotCond.Once")
    st = st.replace(peg"'sizeof(double)'","sizeof(cdouble).int32")
    st = st.replacef(peg"'ImPlotPoint32'","ImPlotPoint")
    while st.contains(peg"'ImPlotPoint(' \d+ "):
      st = st.replacef(peg"{@}'ImPlotPoint(' {\d+} ',' {\d+} ').ImPlotPoint' {@}$","$1ImPlotPoint(x:$2,y:$3)$4")
    while st.contains(peg"'ImPlotBin_Sturges'"):
      st = st.replacef(peg"{@}'ImPlotBin_Sturges'{@}$","$1ImPlotBin.Sturges.int$2")
    # rename `proc implot_` to `proc ip`
    st = st.replace(peg"^'proc imPlot_'","proc ip")
    # replace `range`  to `Range`
    st = st.replace(peg"'range:'","Range:")
    st = st.replace(peg"' range* '"," Range* ")
    # replace cfloat64 to cdouble
    while st.contains(peg"'cfloat64'"):
      st = st.replacef(peg"{@}'cfloat64'{@}$","$1cdouble$2")

    s.add st

  writeFile(fname, s.join("\n").strip(leading = false, trailing = true) & "\n")

proc igGenerate*() =
  var output = srcHeader

  output.genEnums()
  output.genTypeDefs()
  output.genTypes()
  output.genProcs()
  output.add("""
proc ipFormatDateNonUDT*(t: ImPlotTime, buffer: cstring, size: int,
                         fmt: ImPlotDateFmt, use_iso_8601: bool): int {.discardable.} =
  ipFormatDate(t, buffer, size, fmt, use_iso_8601)

proc ipIsLastItemHidden*(): bool {.importc: "ImPlot_IsLastItemHidden".}
proc ipPlotBubbles_spec*(label_id: cstring, xs: ptr float32, ys: ptr float32,
                         sizes: ptr float32, count: int,
                         spec: ImPlotSpec): void {.cdecl, importc: "ImPlot_PlotBubbles_FloatPtrFloatPtrFloatPtr", nodecl.}

var
  gNextLineCol = implotAutoCol
  gNextLineWeight = -1'f32
  gNextLineSet = false
  gNextFillCol = implotAutoCol
  gNextFillAlpha = -1'f32
  gNextFillSet = false
  gNextMarker = cast[ImPlotMarker](-1)
  gNextMarkerSize = -1'f32
  gNextMarkerFill = implotAutoCol
  gNextMarkerWeight = -1'f32
  gNextMarkerOutline = implotAutoCol
  gNextMarkerSet = false
  gNextErrCol = implotAutoCol
  gNextErrSize = -1'f32
  gNextErrWeight = -1'f32
  gNextErrSet = false
  gNextFillAlphaOnly = -1'f32
  gNextFillAlphaOnlySet = false

proc applyNextStyle(spec: var ImPlotSpec) =
  if gNextLineSet:
    spec.lineColor = gNextLineCol
    if gNextLineWeight != -1: spec.lineWeight = gNextLineWeight
  if gNextFillSet:
    spec.fillColor = gNextFillCol
    if gNextFillAlpha != -1: spec.fillAlpha = gNextFillAlpha
  if gNextFillAlphaOnlySet:
    spec.fillAlpha = gNextFillAlphaOnly
  if gNextMarkerSet:
    if gNextMarker != -1.ImPlotMarker: spec.marker = gNextMarker
    if gNextMarkerSize != -1: spec.markerSize = gNextMarkerSize
    if gNextMarkerFill.w != -1: spec.markerFillColor = gNextMarkerFill
    if gNextMarkerWeight != -1: spec.lineWeight = gNextMarkerWeight
    if gNextMarkerOutline.w != -1: spec.markerLineColor = gNextMarkerOutline
  if gNextErrSet:
    if gNextErrCol.w != -1: spec.lineColor = gNextErrCol
    if gNextErrSize != -1: spec.size = gNextErrSize
    if gNextErrWeight != -1: spec.lineWeight = gNextErrWeight
  gNextLineSet = false
  gNextFillSet = false
  gNextFillAlphaOnlySet = false
  gNextMarkerSet = false
  gNextErrSet = false

proc ipSetNextErrorBarStyle*(col: ImVec4 = implotAutoCol, size: float32 = -1,
                             weight: float32 = -1): void =
  gNextErrCol = col
  gNextErrSize = size
  gNextErrWeight = weight
  gNextErrSet = true

proc ipSetNextFillStyle*(col: ImVec4 = implotAutoCol, alpha_mod: float32 = -1): void =
  gNextFillCol = col
  gNextFillAlpha = alpha_mod
  gNextFillSet = true

proc ipSetNextFillAlpha*(alpha: float32): void =
  gNextFillAlphaOnly = alpha
  gNextFillAlphaOnlySet = true

proc ipSetNextLineStyle*(col: ImVec4 = implotAutoCol, weight: float32 = -1): void =
  gNextLineCol = col
  gNextLineWeight = weight
  gNextLineSet = true

proc ipSetNextMarkerStyle*(marker: ImPlotMarker = cast[ImPlotMarker](-1),
                           size: float32 = -1, fill: ImVec4 = implotAutoCol,
                           weight: float32 = -1, outline: ImVec4 = implotAutoCol): void =
  gNextMarker = marker
  gNextMarkerSize = size
  gNextMarkerFill = fill
  gNextMarkerWeight = weight
  gNextMarkerOutline = outline
  gNextMarkerSet = true
""")

  writeFile("src/implot.nim", output)
  fixAfter("src/implot.nim")

when isMainModule:
  igGenerate()
