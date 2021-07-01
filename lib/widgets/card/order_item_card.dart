import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/blocs/CartBloc/CartState.dart';
import 'package:faiikan/models/cart_item.dart' as cart_item;
import 'package:faiikan/widgets/attribute_sheet.dart';
import 'package:faiikan/widgets/update_cart_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final images = [
  'https://img.zanado.com/media/catalog/product/cache/all/thumbnail/360x420/7b8fef0172c2eb72dd8fd366c999954c/8/_/ao_khoac_nam_xo_ngon_pa_fashion_6729.jpg',
  'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg'
];

class OrderItemCard extends StatelessWidget {
  final cart_item.CartItem orderItem;
  final int userId;
  final int index;
  final bool isOrderDetail;

  const OrderItemCard(
      {Key? key,
      required this.userId,
      required this.orderItem,
      required this.index,
      this.isOrderDetail = false})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isOrderDetail ? Color(0xffEFEBEB) : Colors.white,
//        boxShadow: [
//          BoxShadow(
//            color: Colors.black.withOpacity(0.5),
//            spreadRadius: 2,
//            blurRadius: 3,
//            offset: Offset(0, 0), // changes position of shadow
//          ),
//        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: isOrderDetail ? EdgeInsets.all(15) : EdgeInsets.zero,
            child: Image.network(
              orderItem.optionProduct.image.value,
              fit: BoxFit.fill,
            ),
            width: MediaQuery.of(context).size.width / 3 - 25,
            height: MediaQuery.of(context).size.height / 7 + 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 2 / 3 - 40,
            height: MediaQuery.of(context).size.height / 7 + 10,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 2 / 3 - 60,
                            child: Text(
                              orderItem.nameProduct,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (!isOrderDetail)
                      BlocListener<CartBloc, CartState>(
                        listenWhen: (beforeState, state) =>
                            index == context.read<CartBloc>().index,
                        listener: (context, state) async {
                          if (state is LoadedGetProductOptionState) {
                            await showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<CartBloc>(),
                                    child: UpdateCartSheet(
                                      images: images,
                                      isSheet: false,
                                    ),
                                  );
                                }).then((value) {
                              if (value == "Update") {
                                context.read<CartBloc>().add(
                                    UpdateCartBySheetEvent(
                                        userId: userId,
                                        id: orderItem.cartId,
                                        amount: context.read<CartBloc>().amount,
                                        index: index,
                                        optionId: context
                                            .read<CartBloc>()
                                            .optionProductId));
                              }
                            });
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().index = index;
                            context.read<CartBloc>().add(GetProductOptionEvent(
                                  productId: orderItem.productId.toString(),
                                ));
                          },
                          child: Container(
                            color: Color(0xffEEEEEE),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Phân loại: " +
                                      checkNullColor(
                                          orderItem.optionProduct.color) +
                                      ", " +
                                      checkNullSize(
                                          orderItem.optionProduct.size),
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        color: Color(0xffEEEEEE),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Phân loại: " +
                                  checkNullColor(
                                      orderItem.optionProduct.color) +
                                  ", " +
                                  checkNullSize(orderItem.optionProduct.size),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 12,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 20,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
//                        Text(
//                          NumberFormat.simpleCurrency(locale: "vi")
//                              .format(orderItem.optionProduct.price.value)
//                              .toString(),
//                          style: TextStyle(
//                              fontSize: 12,
//                              color: Colors.black54,
//                              decoration: TextDecoration.lineThrough,
//                              decorationThickness: 2,
//                              decorationColor: Colors.black54,
//                              decorationStyle: TextDecorationStyle.solid),
//                        ),
//                        SizedBox(
//                          width: 5,
//                        ),
                        Text(
                          NumberFormat.simpleCurrency(locale: "vi")
                              .format(orderItem.optionProduct.price.value)
                              .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xffF65151),
                          ),
//                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                isOrderDetail
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Số Lượng: ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                orderItem.amount.toString(),
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  if (orderItem.amount > 0)
                                    context.read<CartBloc>().add(
                                        UpdateCartBySheetEvent(
                                            id: orderItem.cartId,
                                            userId: userId,
                                            amount: orderItem.amount - 1,
                                            index: index,
                                            optionId: orderItem.optionProduct
                                                .productOptionId));
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 14,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
//                                      color: Color(0xffF34646),
                                      border: Border.all(
                                    width: 1,
                                    color: Color(0xffD7DEE1),
                                  )),
                                ),
                              ),
                              Container(
                                  height: 20,
                                  width: 30,
                                  decoration: BoxDecoration(
//                                      color: Color(0xffF34646),
                                      border: Border.all(
                                    width: 1,
                                    color: Color(0xffD7DEE1),
                                  )),
                                  child: Center(
                                      child: Text(
                                    orderItem.amount.toString(),
                                    style: TextStyle(color: Color(0xffFA4747)),
                                  ))),
                              InkWell(
                                onTap: () {
                                  context.read<CartBloc>().add(UpdateCartEvent(
                                      userId: userId,
                                      id: orderItem.cartId,
                                      amount: orderItem.amount + 1,
                                      index: index,
                                      optionId: orderItem
                                          .optionProduct.productOptionId));
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 14,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
//                                      color: Color(0xffF34646),
                                      border: Border.all(
                                    width: 1,
                                    color: Color(0xffD7DEE1),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String checkNullColor(cart_item.Color? str) {
  if (str == null)
    return "";
  else
    return str.value.toString();
}

String checkNullSize(cart_item.Size? str) {
  if (str == null)
    return "";
  else
    return str.value.toString();
}
