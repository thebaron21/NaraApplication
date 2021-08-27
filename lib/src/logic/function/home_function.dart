import 'dart:async';

enum Nav { HOME, CATEGOIRES, BRAND, MYBAD, CELEBRIES }

class ControllerAppNara {
  StreamController<Nav> _controllerAppNara = StreamController<Nav>.broadcast();
  Stream<Nav> get getControllerAppNara => _controllerAppNara.stream;
  StreamSink<Nav> get setControllerAppNara => _controllerAppNara.sink;

  ControllerAppNara() {
    _controllerAppNara.add(Nav.HOME);
  }
  void close() {
    _controllerAppNara.close();
    setControllerAppNara.close();
  }
}