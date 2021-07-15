import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/models/cart_item.dart' as cart;
import 'package:faiikan/models/order_item.dart';
import 'package:faiikan/screens/main_screen/home_tab_tab/for_you_tab.dart';
import 'package:faiikan/screens/payment_screen/payment_screen.dart';
import 'package:faiikan/styles/custom_icon_icons.dart';
import 'package:faiikan/widgets/card/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  final int person_id;

  const CartScreen({required this.person_id});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String Voucher = "Nhấn để chọn voucher";
  bool chooseAll = true;
  List<cart.CartItem> list_chosen = [];
  bool isRemoving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      chooseAll = true;
      for (int i = 0; i < state.data.length; i++) {
        if (state.data[i].isChosen == false) {
          chooseAll = false;
          break;
        }
      }

      if (state is InitialCart) return Container(color: Colors.white,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),));
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Giỏ hàng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.black,
            ),
          ),
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
          actions: <Widget>[
          ],
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: context.read<CartBloc>().list_data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(),
                          secondaryBackground: Container(
                            padding: EdgeInsets.only(right: 30),
                            margin: EdgeInsets.only(bottom: 20),
                            color: Color(0xffF34646),
                            width: 50,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Xóa",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {},
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            "Bạn có chắc chắn muốn bỏ sản phẩm này? ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                  onTap: () => Navigator.of(context)
                                                      .pop(false),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Color(0xffC4C4C4)
                                                                      .withOpacity(
                                                                          0.5))),
                                                      child: Center(
                                                          child: const Text(
                                                        "KHÔNG",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      )))),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  context
                                                      .read<CartBloc>()
                                                      .add(DeleteCartEvent(
                                                      index: index,
                                                      id:
                                                      context.read<CartBloc>().list_data[index].cartId.toString()
                                                  ));
                                                 Navigator.of(context).pop();
                                },
                                                child: Container(
//                                              padding: EdgeInsets.symmetric(
//                                                  vertical: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(0xffC4C4C4)
                                                              .withOpacity(0.5))),
                                                  child: Center(
                                                      child: const Text(
                                                    "ĐỒNG Ý",
                                                    style: TextStyle(
                                                      color: Color(0xffF34646),
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          key: Key(index.toString()),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.topCenter,
                                        child: Checkbox(
                                          value: context
                                              .read<CartBloc>()
                                              .list_data[index]
                                              .isChosen,
                                          activeColor: Color(0xffED2626),
                                          onChanged: (value) {
                                            chooseAll = false;
                                            context.read<CartBloc>().add(
                                                CheckItemCartEvent(
                                                    index: index, value: value!));
                                          },
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Stack(
                                        children: <Widget>[
                                          OrderItemCard(
                                            userId: widget.person_id,
                                            orderItem:
                                                context.read<CartBloc>().list_data[index],
                                            index: index,
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(height: 1,color: Color(0xffE7E7E7),),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white.withOpacity(0),
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 2 + 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                color: Color(0xffE7E7E7)),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          margin:
                                              EdgeInsets.only(top: 10, right: 10),
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.redAccent,
                                            size: 20,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2 - 50,
                                    child: ListView.builder(
                                      itemCount: 2,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 10, bottom: 10, right: 10),
                                          height: 80,
                                          color: Colors.white,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: Image.network(
                                                  "https://stc.shopiness.vn/deal/2020/02/26/e/f/8/0/1582709843928_540.png",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        4 *
                                                        2 -
                                                    30,
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        "Name Of Voucher",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "codeofvoucher",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black54),
                                                      ),
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        4 +
                                                    10,
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        "6 days remaining",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black38),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 5, left: 5),
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            color:
                                                                Color(0xffDB3022)),
                                                        child: Center(
                                                          child: Text(
                                                            "Apply",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                color:
                                                                    Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 0),
                          spreadRadius: 2,
                          blurRadius: 1)
                    ]),
                    margin: EdgeInsets.only(
                      top: 3,
                    ),
                    padding:
                        EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(
                              Voucher,
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        if (Voucher != "Nhấn để chọn voucher")
                          Positioned(
                            right: 5,
                            child: Icon(
                              Icons.cancel,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
//              height: 80,
                  child: Row(
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(shape: BoxShape.circle),
//                          margin: EdgeInsets.only(left: 10, top: 5),
                              child: Checkbox(
                                value: chooseAll,
                                activeColor: Color(0xffF34646),
                                onChanged: (value) {
                                  chooseAll = value!;
                                  context
                                      .read<CartBloc>()
                                      .add(CheckAllItemCartEvent(value: value));
                                },
                              )),
                          Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 0, top: 5),
                              child: Center(
                                child: Text(
                                  "Tất cả",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff909090),
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                  .format(state.totalPrice),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xffF34646),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF34646),
                            ),
                            width: MediaQuery.of(context).size.width - 20,
                            margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
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
                            list_chosen = [];
                            for (int i = 0; i < state.data.length; i++) {
                              if (state.data[i].isChosen)
                                list_chosen.add(state.data[i]);
                            }

//                print(list_chosen);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      value: context.read<CartBloc>(),
                                      child: BlocProvider(
                                          create: (_) => AddressBloc(LoadAddress())
                                            ..add(InitialAddressEvent(userId: widget.person_id.toString())),
                                          child:  BlocProvider.value(value: context.read<AccountBloc>(),child:BlocProvider.value(value: context.read<ProductBloc>(),child: PaymentScreen(userId: widget.person_id.toString(),listItems: list_chosen,))))),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if(state is LoadingGetProductOptionState)
              Center(child: CircularProgressIndicator(backgroundColor: Colors.black.withOpacity(0.2),),)
          ],
        ),
      );
    });
  }
}
