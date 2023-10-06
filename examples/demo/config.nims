# for development local path
switch "path","../../../nimgl-imgui/src" # for imgui
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

switch "warning","HoleEnumConv:off"

# Compilation options
switch "define","release"
switch "nimcache",".nimcache"

# Notice: Very important option at this time for Nim-2.0.0. TODO
# Effects axes/TimeScale.nim
switch "mm","refc"
#when (NimMajor, NimMinor, NimPatch) >= (2, 0, 0):
#  switch "mm","refc"
