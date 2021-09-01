part of neonday_network_ex;

class NetworkTimeouts {
  final Duration connection;
  final Duration response;
  final Duration receiveTotal;
  final Duration idle;
  final Duration closing;
  const NetworkTimeouts({
    this.connection = const Duration(seconds: 6),
    this.response = const Duration(seconds: 10),
    this.receiveTotal = const Duration(minutes: 2),
    this.idle = const Duration(seconds: 10),
    this.closing = const Duration(seconds: 5),
  });
}