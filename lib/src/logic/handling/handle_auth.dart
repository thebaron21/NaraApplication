
class HandleAuth {
  // ignore: missing_return
  static Map login(var data) {
     if (data["data"] != null) {
      return {"token": data["data"]["token"], "status": true};
    } else if (data["errors"] != null) {
      return {"status": false, "errors": data["errors"]};
    }
  }

  // ignore: missing_return
  static Map register(var data) {
    if (data["data"] != null) {
      return {"token": data["data"]["token"], "status": true};
    } else if (data["errors"] != null) {
      return {"status": false, "errors": data["errors"]};
    }
  }
}
