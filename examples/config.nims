switch "warning","HoleEnumConv:off"

# Compilation options
switch "define","release"
switch "nimcache",".nimcache"

# Notice: Very important option at this time for Nim-2.0.0
# Effects DigitalPlots.nim
switch "mm","refc"
#when (NimMajor, NimMinor, NimPatch) >= (2, 0, 0):
#  switch "mm","refc"

