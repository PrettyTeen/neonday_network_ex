part of neonday_network_ex;

abstract class NetworkTimes {
  Duration? connection;
  Duration? beginRequest;
  Duration? beginResponse;
  Duration? close;
}