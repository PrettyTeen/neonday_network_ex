part of neonday_network_ex;

@Deprecated("")
abstract class IRequestResult {
  NetworkTimes get timings;

  
  bool get connected;

  INotifier<bool> get connectedState;
}