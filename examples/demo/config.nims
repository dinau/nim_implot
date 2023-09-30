switch "path","../../src"

switch "path","."
switch "path","plots"
switch "path","axes"
switch "path","subplots"

#switch "path","../../nimgl-imgui/src"
switch "warning","HoleEnumConv:off"

# Compilation options
switch "define","release"
switch "nimcache",".nimcache"

# Notice: Very important option at this time for Nim-2.0.0. TODO
# Effects DigitalPlots.nim
switch "mm","refc"
#when (NimMajor, NimMinor, NimPatch) >= (2, 0, 0):
#  switch "mm","refc"
