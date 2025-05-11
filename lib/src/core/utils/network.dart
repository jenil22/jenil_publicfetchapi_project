import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  factory Internet() => _instance;

  Internet._internal() {
    connectivity = Connectivity();
  }

  static final Internet _instance = Internet._internal();

  late Connectivity connectivity;

  Future<bool> isAvailable() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }
}
