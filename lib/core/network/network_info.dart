import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Class to handle the network info
abstract class NetworkInfo {
  // This method is used to check if the device is connected to the internet
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
