part of neonday_network_ex;

abstract class IRequestResult {
  NetworkTimes get timings;

  
  bool get connected;

  INotifier<bool> get connectedState;
}