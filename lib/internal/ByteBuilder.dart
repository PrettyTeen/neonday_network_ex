part of neonday_network_ex;

class _ByteBuilder {
  int length = 0;
  List<List<int>> _chunks = [];
  void add(List<int> data) {
    length += data.length;
    _chunks.add(data);
  }

  Uint8List build() {
    Uint8List out;

    int length = 0;
    for(var chunk in _chunks)
      length += chunk.length;

    int offset = 0;
    out = Uint8List(length);
    for(var chunk in _chunks) {
      for(var byte in chunk)
        out[offset++] = byte;
    } return out;
  }
}