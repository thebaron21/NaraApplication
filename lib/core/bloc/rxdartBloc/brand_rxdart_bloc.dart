import 'package:myapp3/core/repoitorites/brand_repository.dart';
import 'package:myapp3/core/response/brand_response.dart';
import 'package:rxdart/rxdart.dart';

class BrandRxdartBlox {
  BrandResponse _response = BrandResponse();

  BehaviorSubject<BrandRepository> _brands = BehaviorSubject<BrandRepository>();
  BehaviorSubject<BrandRepository> _brand = BehaviorSubject<BrandRepository>();
  BehaviorSubject<BrandRepository2> _productBrand =
      BehaviorSubject<BrandRepository2>();

  getBrand(String id) async {
    var data = await _response.getBrand(id);
    if (_brand.isClosed == false) _brand.sink.add(data);
  }

  getBrands() async {
    var data = await _response.getBrands();
    if (_brand.isClosed == false) _brands.sink.add(data);
  }

  getProductBrand(String id) async {
    var data = await _response.getProductBrand(id);
    if (_brand.isClosed == false) _productBrand.sink.add(data);
  }

  Stream<BrandRepository> getBrandOnce({String name}) async* {}

  close() {
    if (_brands.isClosed == false) _brands.close();
    if (_brand.isClosed == false) _brand.close();
    if (_productBrand.isClosed == false) _productBrand.close();
  }

  BehaviorSubject<BrandRepository> get brand => _brand;
  BehaviorSubject<BrandRepository> get brands => _brands;
  BehaviorSubject<BrandRepository2> get productBrand => _productBrand;
}

final brandRxdartBloc = BrandRxdartBlox();
