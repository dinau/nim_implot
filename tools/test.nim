type
  test {.pure, size:int32.sizeof.} = enum
    a,b,c

var res =  cast[test](-1)
inc res
echo res

