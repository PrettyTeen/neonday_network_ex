part of neonday_network_ex;

/// TODO REWRITE
class BufferPointer {
  final _ByteBuilder _builder = new _ByteBuilder();
  final ByteData? _byteData;
  Uint8List? buffer;
  int offset = 0;
  BufferPointer(this.buffer) : _byteData = new ByteData.view(buffer!.buffer);
  BufferPointer.construct() : _byteData = null;

  int   get length    => buffer?.length ?? _builder.length;
  int   get remaining => (buffer?.length ?? 0) - offset;

  void reset() => offset = 0;
  bool skip(int length)  {
    if(offset + length > buffer!.length)
      return false;
    offset += length;
    return true;
  }

  bool flip(int length)  {
    if(offset - length < 0)
      return false;
    offset -= length;
    return true;
  }

  // GETTERS
  //==========================================================================\\
  int? getByte() {
    if(offset + 1 > buffer!.length)
      return null;
    return buffer![offset++];
  }

  Uint8List? getBytes(int len) {
    if(offset + len > buffer!.length)
      return null;
    Uint8List out = Uint8List(len);
    for(int i = 0; i < len; i++) {
      out[i] = buffer![offset + i];
    } offset += len;
    return out;
  }

  String? getString(int len) {
    if(offset + len > buffer!.length)
      return null;
    return new String.fromCharCodes(buffer!.getRange(offset, offset + len));
  }

  int? getInt16() {
    if(offset + 2 > buffer!.length)
      return null;
    var out = _byteData!.getInt16(offset);
    offset += 2;
    return out;
  }

  int? getUint16() {
    if(offset + 2 > buffer!.length)
      return null;
    var out = _byteData!.getUint16(offset);
    offset += 2;
    return out;
  }

  int? getInt32() {
    if(offset + 4 > buffer!.length)
      return null;
    var out = _byteData!.getInt32(offset);
    offset += 4;
    return out;
  }

  int? getUint32() {
    if(offset + 4 > buffer!.length)
      return null;
    var out = _byteData!.getUint32(offset);
    offset += 4;
    return out;
  }

  int? getInt64() {
    if(offset + 8 > buffer!.length)
      return null;
    var out = _byteData!.getInt64(offset);
    offset += 8;
    return out;
  }

  int? getUint64() {
    if(offset + 8 > buffer!.length)
      return null;
    var out = _byteData!.getUint64(offset);
    offset += 8;
    return out;
  }
  //==========================================================================\\


  // SETTERS
  //==========================================================================\\
  void pushByte(int value) {
    _builder.add([value]);
  }

  void pushBytes(List<int> value) {
    _builder.add(value);
  }

  void pushString(String value) {
    _builder.add(Uint8List.fromList(value.codeUnits));
  }

  void pushInt16(int value) {
    var data = ByteData(2)..setInt16(0, value);
    _builder.add(data.buffer.asUint8List());
  }

  void pushUInt16(int value) {
    var data = ByteData(2)..setUint16(0, value);
    _builder.add(data.buffer.asUint8List());
  }

  void pushInt32(int value) {
    var data = ByteData(4)..setInt32(0, value);
    _builder.add(data.buffer.asUint8List());
  }

  void pushUInt32(int value) {
    var data = ByteData(4)..setUint32(0, value);
    _builder.add(data.buffer.asUint8List());
  }

  void pushInt64(int value) {
    var data = ByteData(8)..setInt64(0, value);
    _builder.add(data.buffer.asUint8List());
  }

  void pushUInt64(int value) {
    var data = ByteData(8)..setUint64(0, value);
    _builder.add(data.buffer.asUint8List());
  }
  //==========================================================================\\


  void build() => buffer = _builder.build();
  String stringify() => new String.fromCharCodes(buffer ?? new Uint8List.fromList("BUFFER_IS_NULL".codeUnits));
}
