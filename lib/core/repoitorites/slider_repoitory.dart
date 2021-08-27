import 'package:myapp3/core/model/slider_model.dart';

class SliderModelRespoitory {
  List<SliderImage> sliders;
  Map<String, dynamic> error;
  String exception;

  SliderModelRespoitory.fromMap(var json)
      : sliders = (json["data"]["data"] as List).map((e) => SliderImage.fromJson(e)).toList(),
        error = null,
        exception = null;

  SliderModelRespoitory.withError(var ex)
      : sliders = null,
        error = ex["errors"],
        exception = null;

  SliderModelRespoitory.withException(String ex)
      : sliders = null,
        error = null,
        exception = ex;
}
