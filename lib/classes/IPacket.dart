part of neonday_network_ex;

@Deprecated("Need to review")
abstract class IPacket {
  final BufferPointer pointer;
  IPacket.construct() : pointer = BufferPointer.construct();
  IPacket.destruct(this.pointer);

  bool isEqual(BufferPointer pointer);
  bool isCorrect(BufferPointer pointer);
  BufferPointer build(BufferPointer? pointer);
  IPacket dissect(BufferPointer pointer, IPacket? packet);
}