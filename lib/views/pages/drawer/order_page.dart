import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/model/order_model.dart';
import 'package:myapp3/core/repoitorites/my_order_repository.dart';
import 'package:myapp3/core/response/order_response.dart';
import 'package:myapp3/views/widgets/row_product.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderResponse _response = OrderResponse();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
        context: context,
        title: AppLocale.of(context).getTranslated("my_order"),
        isCart: true,
      ),
      body: FutureBuilder<MyOrderRespoitory>(
        future: _response.getOrder(),
        builder: (context, AsyncSnapshot<MyOrderRespoitory> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.errors == null) {
              return _buildListView(size, snapshot.data.myorders);
            } else {
              return _buildError(snapshot.data.errors);
            }
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildListView(Size size, List<GetOrderModel> myorders) {
    return ListView.builder(
      itemCount: myorders.length,
      itemBuilder: (BuildContext context, int index) {
        return _card(size, myorders[index]);
      },
    );
  }

  _card(Size size, GetOrderModel myorder) {
    return Container(
      width: size.width * 0.96,
      height: size.height * .55,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          )
        ],
        border: Border.all(color: Colors.teal, width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "معلومات الطلب",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "رقم الطلب : ${myorder.id}",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "قيمة الطلب \$ ${myorder.price}",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "نوع وسيلة الدفع : ${myorder.paymentType}",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "حالة الطلب : ${myorder.statusValue}",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "الحالة : ${myorder.paymenyStatus}",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: kcPrimaryColor,
          ),
          _address(myorder.address),
        ],
      ),
    );
  }

  _address(GetAddress address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "تفاصيل العنوان",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        _row("رقم العنوان ", " ${address.id}"),
        _row("الاسم", "${address.name}"),
        _row("المدينة ", "${address.city}"),
        _row("البلد", "${address.state}"),
        _row("رقم الهاتف", " ${address.phone}"),
        _row(" الشارع", address.street)
      ],
    );
  }

  _row(s, m) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          m,
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
        SizedBox(width: 10),
        Text(":"),
        SizedBox(width: 10),
        Text(
          s,
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildError(error) {
    return Center(
      child: Text(error.toString()),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kcPrimaryColor,
      ),
    );
  }
}
