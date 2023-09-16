#[
// utility structure for realtime plot
struct ScrollingBuffer {
    int MaxSize;
    int Offset;
    ImVector<ImVec2> Data;
    ScrollingBuffer(int max_size = 2000) {
        MaxSize = max_size;
        Offset  = 0;
        Data.reserve(MaxSize);
    }
    void AddPoint(float x, float y) {
        if (Data.size() < MaxSize)
            Data.push_back(ImVec2(x,y));
        else {
            Data[Offset] = ImVec2(x,y);
            Offset =  (Offset + 1) % MaxSize;
        }
    }
    void Erase() {
        if (Data.size() > 0) {
            Data.shrink(0);
            Offset  = 0;
        }
    }
};
]#
import imgui

type
  ScrollingBuffer = object
    MaxSize,Offset:int32
    Data: seq[ImVec2]

proc newScrollBuffer(max_size:int32 = 2000): ScrollingBuffer =
  result = ScrollingBuffer(MaxSize:max_size,Offset:0,Data:newSeqOfCap[ImVec2](max_size))

proc AddPoint(self:var ScrollingBuffer,x,y:float32) =
  if self.Data.len < self.MaxSize:
    self.Data.add(ImVec2(x:x, y:y))
  else:
    self.Data[self.Offset] = ImVec2(x:x,y:y)
    self.Offset = (self.Offset + 1) mod self.MaxSize

proc Erase(self:var ScrollingBuffer) =
  if self.Data.len > 0:
#   self.Data.shrink(0)
    self.Offset = 0
