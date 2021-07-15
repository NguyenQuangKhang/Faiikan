import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/models/cart_item.dart' as cart;
import 'package:faiikan/models/input_order_item.dart';
import 'package:faiikan/models/order_item.dart';
import 'package:faiikan/screens/address_screen/select_address.dart';
import 'package:faiikan/screens/successful_order/successful_order.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatefulWidget {
  final String userId;
  final List<cart.CartItem> listItems;


  const PaymentScreen({Key? key, required this.userId, required this.listItems})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool haveAddress = false;

  String Voucher = "Chọn hoặc nhập voucher";

  @override
  void initState() {
    // TODO: implement initState
//    listItems = context
//        .read<CartBloc>()
//        .list_data
//        .where((element) => element.isChosen)
//        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          title: Text(
            "Thanh toán",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocListener(
          listener: (context,state) {
            if(state is CreateOrderSuccessfulState)
              {
                context.read<CartBloc>().add(DeleteListCartItemEvent(id: widget.listItems.map((e) => e.cartId.toString()).toList()));
                Navigator.push(context, MaterialPageRoute(builder: (_)=> BlocProvider.value(value: context.read<ProductBloc>(),child: BlocProvider.value(value: context.read<AccountBloc>(),child: BlocProvider.value(value:context.read<CartBloc>(),child: SuccessfulOrder())))));
              }
            if(state is DeleteListItemSuccessfulState)
              {
                context.read<CartBloc>().add(GetCartEvent(person_id: widget.userId,));
              }
          },
          bloc: context.read<CartBloc>(),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if(state is CartLoadingState)
                Center(child: CircularProgressIndicator(backgroundColor:Colors.redAccent ,),);
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: BlocBuilder<AddressBloc, AddressState>(
                                    builder: (context, state) {
                                      if (state is LoadAddress)
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.grey,
                                          ),
                                        );
                                      return InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BlocProvider.value(
                                                          value: context.read<
                                                              AddressBloc>(),
                                                          child:
                                                              SelectAddressScreen(
                                                            userId: widget.userId,
                                                          )))).then((value) {});
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment: haveAddress
                                                  ? CrossAxisAlignment.start
                                                  : CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                context
                                                            .read<AddressBloc>()
                                                            .currentAddress !=
                                                        null
                                                    ? Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        spacing: 10,
                                                        direction: Axis.vertical,
                                                        children: [
                                                          Text(
                                                            "Địa chỉ nhận hàng",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            context
                                                                    .read<
                                                                        AddressBloc>()
                                                                    .currentAddress!
                                                                    .name +
                                                                " | " +
                                                                context
                                                                    .read<
                                                                        AddressBloc>()
                                                                    .currentAddress!
                                                                    .numberPhone,
                                                            style: TextStyle(
                                                              color: Colors.black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            context
                                                                .read<
                                                                    AddressBloc>()
                                                                .currentAddress!
                                                                .specificAddress,
                                                            style: TextStyle(
                                                              color: Colors.black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                            ),
                                                          ),
                                                          Text(
                                                              context
                                                                  .read<
                                                                  AddressBloc>()
                                                                  .currentAddress!
                                                                  .ward
                                                                  .prefix +" " +  context
                                                                    .read<
                                                                        AddressBloc>()
                                                                    .currentAddress!
                                                                    .ward
                                                                    .name +
                                                                " - " +
                                                                  context
                                                                      .read<
                                                                      AddressBloc>()
                                                                      .currentAddress!
                                                                      .district
                                                                      .prefix +" " + context
                                                                    .read<
                                                                        AddressBloc>()
                                                                    .currentAddress!
                                                                    .district
                                                                    .name +
                                                                " - " +
                                                                context
                                                                    .read<
                                                                        AddressBloc>()
                                                                    .currentAddress!
                                                                    .province
                                                                    .name,
                                                            style: TextStyle(
                                                              color: Colors.black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        "Vui lòng chọn địa chỉ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0.5,
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )),
                              Container(
                                color: Color(0xffEDEDED),
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sản phẩm",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Color(0xffEDEDED),
                              ),
                              Container(
                                height: widget.listItems.length == 1
                                    ? (MediaQuery.of(context).size.height / 7 +
                                        10 +
                                        40)
                                    : (MediaQuery.of(context).size.height / 7 +
                                                10) *
                                            2 +
                                        40,
                                child: ListView.builder(
                                    itemCount: widget.listItems.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            child: OrderItemCard(
                                              userId: 0,
                                              orderItem: widget.listItems[index],
                                              index: index,
                                              isOrderDetail: true,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              Container(
                                color: Color(0xffEDEDED),
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Đơn vị vận chuyển",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Color(0xffEDEDED),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Giao hàng tiết kiệm",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Nhận hàng vào " + DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 5))),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: "vi")
                                              .format(20000)
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Colors.black.withOpacity(0.6),
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Color(0xffEDEDED),
                                height: 5,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10, right: 15),
                                  child: Stack(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                CustomIcon.voucher,
                                                color: Color(0xffF87328),
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text("Voucher"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                Voucher,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                color:
                                                    Colors.black.withOpacity(0.6),
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (Voucher != "Chọn hoặc nhập voucher")
                                        Positioned(
                                          right: 5,
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ),
                                        ),
                                    ],
                                  )),
                              Container(
                                color: Color(0xffEDEDED),
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Phương thức thanh toán",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Chọn phương thức \nthanh toán",
                                          maxLines: null,
                                          style: TextStyle(
                                            color: Color(0xffEA1313)
                                                .withOpacity(0.6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Colors.black.withOpacity(0.6),
                                          size: 15,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Color(0xffEDEDED),
                                height: 1,
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tổng tiền hàng",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: "vi")
                                              .format(20000)
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tổng tiền phí vận chuyển",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.simpleCurrency(
                                                  locale: "vi")
                                              .format(
                                                  totalPrice(widget.listItems))
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tiền khuyến mãi",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        Text(
                                          "-" +
                                              NumberFormat.simpleCurrency(
                                                      locale: "vi")
                                                  .format(20000)
                                                  .toString(),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tổng thanh toán",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: "vi")
                                                .format(
                                                    totalPrice(widget.listItems))
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                            blurRadius: 2,
                          )
                        ]),
                        margin: EdgeInsets.only(
                          top: 3,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Tổng Cộng: ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black38),
                                    ),
                                    Text(
                                      NumberFormat.simpleCurrency(locale: "vi")
                                          .format(totalPrice(widget.listItems)),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xffF34646),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF34646),
                                  ),
                                  width: MediaQuery.of(context).size.width - 20,
                                  child: Center(
                                    child: Text(
                                      "Mua Hàng",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (context.read<AddressBloc>().currentAddress !=
                                      null)
                                    context.read<CartBloc>().add(CreateOrderEvent(
                                        userId: widget.userId,
                                        addressId: context
                                            .read<AddressBloc>()
                                            .currentAddress!
                                            .id
                                            .toString(),
                                        content: "",
                                        discount: 10000,
                                        grandTotal: totalPrice(widget.listItems),
                                        listItem: widget.listItems
                                            .map((e) => new InputOrderItem(
                                                productId: e.productId,
                                                productOptionId: e.optionProduct
                                                    .productOptionId,
                                                imageUrl:
                                                    e.optionProduct.image.value,
                                                price: e.optionProduct.price.value
                                                    .toInt(),
                                                quantity: e.amount))
                                            .toList(),
                                        paymentMethod: 1,
                                        shipping: 1,
                                        shippingFee: 10000,
                                        status: 1,
                                        subTotal: totalPrice(widget.listItems)));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state is CartLoadingState)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                ],
              );
            },
          ),
        ));
  }
}

double totalPrice(List<cart.CartItem> cartItems) {
  double total = 0;
  for (var item in cartItems) {
    total += item.amount * item.optionProduct.price.value;
  }
  return total;
}
