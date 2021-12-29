part of neonday_network_ex;

@Deprecated("Need to review")
abstract class IPacketIdentifier {
  const IPacketIdentifier();

  factory IPacketIdentifier.string(String prefix) => new _StringIdentrifier(prefix);
  Uint8List get value;
}


@Deprecated("Need to review")
class _StringIdentrifier extends IPacketIdentifier {
  @override
  final Uint8List value;
  _StringIdentrifier(String prefix) : value = Uint8List.fromList(prefix.codeUnits);
}