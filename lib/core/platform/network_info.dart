/// Class to handle the network info
abstract class NetworkInfo {
  // This method is used to check if the device is connected to the internet
  Future<bool> get isConnected;
}
