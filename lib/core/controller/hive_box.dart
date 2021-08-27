import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';

class HiveBox {
  Box bodx;
  final boxNaraApp = Hive.box(Boxs.NaraApp);
  
  close() {
    if (bodx.isOpen == true) bodx.close();
  }

  closeNaraApp() {
    if (boxNaraApp.isOpen == true) bodx.close();
  }
}

final hiveBox = HiveBox();
