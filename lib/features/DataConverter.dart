part of neonday_network_ex;

@Deprecated("Need to review")
abstract class DataConverter {
  static const int MASK_UINT32    = 0x00000000FFFFFFFF;
  static const int MASK_UINT16    = 0x000000000000FFFF;
  static const int MASK_UINT8     = 0x00000000000000FF;

  static Uint8List int2Uint8(int value) {
    Uint8List buffer = new Uint8List(1);
    buffer[0] = value & MASK_UINT8;
    return buffer;
  }

  static Uint8List int2Uint16(int value) {
    Uint8List buffer = new Uint8List(2);
    buffer[1] = value & MASK_UINT8;
    buffer[0] = (value >> 8) & MASK_UINT8;
    return buffer;
  }

  static Uint8List int2Uint32(int value) {
    Uint8List buffer = new Uint8List(4);
    buffer[3] = value & MASK_UINT8;
    buffer[2] = (value >> 8) & MASK_UINT8;
    buffer[1] = (value >> 16) & MASK_UINT8;
    buffer[0] = (value >> 24) & MASK_UINT8;
    return buffer;
  }
}