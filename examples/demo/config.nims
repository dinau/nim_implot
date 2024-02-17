# for development local path
#switch "path","../../../nimgl-imgui/src" # for imgui
switch "path","../../src" # for implot

#
switch "path","."
switch "path","plots"
switch "path","axes"
switch "path","subplots"
switch "path","tools"
switch "path","custom"
switch "path","config"
switch "path","help"

when (NimMajor, NimMinor, NimPatch) < (1, 6, 2):
  switch "gc","refc"
else:
  switch "mm","refc"
  # Notice: Very important option at this time for Nim-2.0.0. TODO
  # ,effects axes/TimeScale.nim

switch "warning","HoleEnumConv:off" # nim-1.6.0 or later

# Compilation options
switch "define","release"
switch "nimcache",".nimcache"
