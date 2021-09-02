part of neonday_network_ex;

abstract class IRequestResult {
  late NetworkTimes timings;

  late INotifier<bool> connectedState;
}