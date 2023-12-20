# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

const srcHeader* = """
# Modified for ImPlot by dinau,2023
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
  cfloat64* = cdouble # NoReplace
  double* = cdouble
  Ims32* = cint
const
  nullptr* = nil
  IMPLOT_AUTO* = -1 # from <implot.h>

#--------------------------------------
# Enum: logical calculation definitions
#--------------------------------------
# Assumed enum size is 32bit.
# or
template `or`*[E:enum](a,b:E):E =
  cast[E](a.uint32 or b.uint32)
template `or`*[E:enum,I:SomeInteger](a:E,b:I):E =
  cast[E](a.uint32 or b.uint32)
template `or`*[E:enum,I:SomeInteger](a:I,b:E):E =
  cast[E](a.uint32 or b.uint32 )

# xor
template `xor`*[E:enum](a,b:E):E =
  cast[E](a.uint32 xor b.uint32)
template `xor`*[E:enum,I:SomeInteger](a:E,b:I):E =
  cast[E](a.uint32 xor b)
template `xor`*[E:enum,I:SomeInteger](a:I,b:E):E =
  cast[E](a.uint32 xor b.uint32 )

# and
template `and`*[E:enum](a,b:E):E =
  cast[E](a.uint32 and b.uint32)
template `and`*[E:enum,I:SomeInteger](a:E,b:I):E =
  cast[E](a.uint32 and b.uint32 )
template `and`*[E:enum,I:SomeInteger](a:I,b:E):E =
  cast[E](cast[uint32](a) and cast[uint32](b) )

#-----------
# templates
#-----------
template ptz*(val:untyped): untyped =
  val[0].addr
template pu32*(v: untyped) : untyped = cast[ptr uint32](v.addr)
template pi32*(v: untyped)  : untyped = cast[ptr int32](v.addr)
template cstringCast*(v: untyped) : untyped = cast[cstring](v)

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

when defined(windows):
  {.passC:"-static".}
  {.passL:"-static".}

"""

const preProcs* = """
# Procs

when not defined(cpp) or defined(cimguiDLL):
  {.push dynlib: imgui_dll, cdecl, discardable, header: currentSourceDir() & "/implot/private/ncimplot.h".}
else:
  {.push nodecl, discardable, header: currentSourceDir() & "/implot/private/ncimplot.h".}

type
  ImPlotPointGetter* = proc (data: pointer; idx: cint; point: ptr ImPlotPoint): pointer {.cdecl.}
"""

const postProcs* = """

{.pop.} # push dynlib / nodecl, etc...

"""

let reservedWordsDictionary* = [
"end", "type", "out", "in", "ptr", "ref"
]

let blackListProc* = [ "" ]
