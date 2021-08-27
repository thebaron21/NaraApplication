import 'package:myapp3/core/repoitorites/product_respoitory.dart';
import 'package:myapp3/core/response/categories_reponse.dart';
import 'package:rxdart/rxdart.dart';

class ProductsRxdartBloc {
  CategoriesResponse _productsResponse = CategoriesResponse();

  final BehaviorSubject<ProductModelRespoitory> _subject =
      BehaviorSubject<ProductModelRespoitory>();
  final BehaviorSubject<ProductModelRespoitory> _subjectFillter =
      BehaviorSubject<ProductModelRespoitory>();

  getProducts(String id) async {
    ProductModelRespoitory data = await _productsResponse.getCategoryProducts(
        id: id); //getFilteredProducts(name:name,priceFrom: priceFrom,priceTo:priceTo,categoryID:categoryID,option:option);

    if (!_subject.isClosed) _subject.sink.add(data);
  }

  getProductsFillter({String name}) async {
    ProductModelRespoitory data = await _productsResponse.getFilteredProducts(name: name);
    if (!_subject.isClosed) _subject.sink.add(data);
  }

  close() {
    _subject.close();
    _subjectFillter.close();
  }

  BehaviorSubject<ProductModelRespoitory> get subject => _subject;
  BehaviorSubject<ProductModelRespoitory> get subjectFillter => _subjectFillter;
}

final productsRxdartBloc = ProductsRxdartBloc();
