part of neonday_network_ex;

@Deprecated("Need to review")
abstract class NetworkEx {
  
  static Future<void> getAvailableAddresses(
    // INPUT
    Iterable<InternetAddress> oldList,

    // OUTPUT
    List<InternetAddress> outToBind,
    List<InternetAddress> outToUnbind,
  ) async {
    var interfaces = await NetworkInterface.list(
      includeLoopback: false,
      includeLinkLocal: true,
      type: InternetAddressType.IPv4,
    );

    List<InternetAddress> newList = [];
    for(var list in interfaces.map((net) => net.addresses).toList()) {
      newList.addAll(list);
    } newList.removeWhere((e) => e.address.startsWith("169."));


    outToBind.addAll(
      newList.where((n) {
        for(var o in oldList)
          if(_containsAddress(n, o))
            return false;
        return true;
      },
    ));

    outToUnbind.addAll(
      oldList.where((o) {
        for(var n in newList)
          if(_containsAddress(n, o))
            return false;
        return true;
      },
    ));

    // if(toBind.length > 0) {
    //   Log.d(TAG, "toBind = $toBind");
    // }

    // if(toUnbind.length > 0) {
    //   Log.d(TAG, "toUnbind = $toUnbind");
    // }
  }




  /// if 0.0.0.255 then 0.0.0.xxx equals
  static bool _containsAddress(InternetAddress a1, InternetAddress a2) {
    Uint8List r1, r2;
    r1 = a1.rawAddress;
    r2 = a2.rawAddress;

    
    for(int i = 0;  i < r1.length; i++) {
      if(r1[i] == 0xFF || r2[i] == 0xFF) {
        r1[i] = 0;
        r2[i] = 0;
      } if(r1[i] != r2[i])
        return false;
    } return true;
    // if(new InternetAddress.fromRawAddress(r1) == new InternetAddress.fromRawAddress(r2))
    //   return true;
    // return false;
  }
}