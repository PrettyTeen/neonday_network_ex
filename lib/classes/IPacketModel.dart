part of neonday_network_ex;


//==========================================================================\\
// PACKET STRUCTURE:
// /---------------------------------------------\
// |-IDENTIFIER-|-CHECKSUM-|--LENGTH--|---DATA---|
// |------------|----------|----------|----------|
// |   N BYTES  |  2 BYTES |  2 BYTES |  N BYTES |
// \---------------------------------------------/
// 
// NOTE:
// - checksum checks length+data
//==========================================================================\\

class _Level0 {
  int? checksum;
  int? payloadLength;
}

///TODO REWRITE
abstract class IPacketModel extends IPacket {
  final _Level0 level0 = new _Level0();

  // ignore: non_constant_identifier_names
  final IPacketIdentifier IDENTIFIER;

  IPacketModel.construct(this.IDENTIFIER) : super.construct();
  
  IPacketModel.destruct(this.IDENTIFIER, BufferPointer pointer) : super.destruct(pointer);
  
  
  @override
  bool isEqual(BufferPointer pointer) {
    pointer.reset();
    // -IDENTIFIER-
    //--------------------------------------------------------------------------
    var id = pointer.getBytes(IDENTIFIER.value.length);
    if(id == null || !IPacketModel.equals(id, IDENTIFIER.value))
      return false;
    //--------------------------------------------------------------------------

    // -CHECKSUM-
    //--------------------------------------------------------------------------
    if(pointer.skip(2) == null)
      return false;
    //--------------------------------------------------------------------------

    // -LENGTH-
    //--------------------------------------------------------------------------
    var length = pointer.getUint16();
    if(length == null)
      return false;
    //--------------------------------------------------------------------------

    // -PAYLOAD-
    //--------------------------------------------------------------------------
    if(pointer.skip(length) == null)
      return false;
    //--------------------------------------------------------------------------
    
    pointer.flip(length);
    return true;
  }

  @override
  bool isCorrect(BufferPointer pointer) {
    pointer.reset();
    // -IDENTIFIER-
    //--------------------------------------------------------------------------
    var id = pointer.getBytes(IDENTIFIER.value.length);
    if(id == null || !IPacketModel.equals(id, IDENTIFIER.value))
      return false;
    //--------------------------------------------------------------------------

    // -CHECKSUM-
    //--------------------------------------------------------------------------
    var checksum = pointer.getUint16();
    if(checksum == null)
      return false;
    //--------------------------------------------------------------------------

    // -LENGTH-
    //--------------------------------------------------------------------------
    var length = pointer.getUint16();
    if(length == null)
      return false;
    //--------------------------------------------------------------------------

    // -PAYLOAD-
    //--------------------------------------------------------------------------
    if(pointer.skip(length) == null)
      return false;
    //--------------------------------------------------------------------------
    

    // Checking checksum
    //--------------------------------------------------------------------------
    pointer.offset = IDENTIFIER.value.length + 2;
    var buffer = pointer.getBytes(2 + length);
    if(IPacketModel._calculateChecksum([buffer!]) != checksum)
      return false;
    //--------------------------------------------------------------------------
    
    pointer.flip(length);
    return true;
  }

  @override
  BufferPointer build(BufferPointer? pointer) {
    pointer?.build();
    if(pointer == null || pointer.buffer == null || pointer.buffer!.length == 0)
      throw(new Exception("$runtimeType called $runtimeType.build() with null data"));
      
    var data = pointer.buffer;
    pointer = new BufferPointer.construct();

    int checksum;
    int length    = data!.length;


    Uint8List rawChecksum;
    Uint8List rawLength;

    rawLength = DataConverter.int2Uint16(length);
    checksum = IPacketModel._calculateChecksum([rawLength, data]);
    rawChecksum = DataConverter.int2Uint16(checksum);


    pointer.pushBytes(IDENTIFIER.value);
    pointer.pushBytes(rawChecksum);
    pointer.pushBytes(rawLength);
    pointer.pushBytes(data);

    pointer.build();
    return pointer;
  }

  @override
  IPacketModel dissect(BufferPointer pointer, covariant IPacketModel packet) {
    pointer.reset();
    pointer.offset += IDENTIFIER.value.length;
    packet.level0.checksum = pointer.getInt16();
    packet.level0.payloadLength = pointer.getInt16();
    return packet;
  }


  static int _calculateChecksum(List<Uint8List> buffers) {
    int checksum = 0;
    for(var buffer in buffers) {
      for(var byte in buffer)
        checksum += byte;
    } return checksum & DataConverter.MASK_UINT16;
  }





  static final Uint8List nullList = Uint8List(0);
  static final Uint8List null16   = Uint8List(2);
  static final Uint8List null32   = Uint8List(4);
  static final Uint8List null64   = Uint8List(8);

  static Uint8List crop(Uint8List buffer, int start, int length) {
    Uint8List out;

    int newLength = buffer.length - start;
    if(newLength <= 0)
      out = nullList;
    else if(length < newLength)
      newLength = length;
    out = new Uint8List.fromList(buffer.getRange(start, start + newLength).toList());
    return out;
  }

  static bool equals(Uint8List buf1, Uint8List buf2) {
    if(buf1.length != buf2.length)
      return false;
    for(int i = 0; i < buf1.length; i++) {
      if(buf1[i] != buf2[i])
        return false;
    } return true;
  }
}