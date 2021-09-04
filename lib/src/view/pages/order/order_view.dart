import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/model/model_order.dart';
import 'package:myapp3/src/logic/repository/my_order_repository.dart';
import 'package:myapp3/src/logic/res/res_order_cart.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(
          context: context,
          title: AppLocale.of(context).getTranslated("my_order"),
          isCart: true,
        ),
        body: StreamBuilder(
          stream: ResOrderCart.getOrder().asStream(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return _buildListView(size, snapshot.data.myorders);
            } else if (snapshot.hasError) {
              return WidgetFuture.error(context, () => setState(() {}));
            } else {
              return WidgetFuture.loading();
            }
          },
        ));
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
}
