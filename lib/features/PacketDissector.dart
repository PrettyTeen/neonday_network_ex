part of neonday_network_ex;

@Deprecated("Need to review")
class PacketDissector<T extends IPacket> {
  final List<T> _packets = [];

  PacketDissector add(T packet) {
    _packets.add(packet);
    return this;
  }

  PacketDissector addAll(List<T> packets) {
    _packets.addAll(packets);
    return this;
  }

  PacketDissector remove(T packet) {
    _packets.remove(packet);
    return this;
  }

  IPacket? dissect(BufferPointer pointer) {
    for(var packet in _packets) {
      if(packet.isEqual(pointer) && packet.isCorrect(pointer))
        return packet.dissect(pointer, null);
    } return null;
  }
}