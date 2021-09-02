part of neonday_network_ex;

abstract class IRequestResult {
  final NetworkTimes timings;

  late INotifier<bool> connectedState;

  IRequestResult({
    required this.timings,
  });
}