import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/CartBloc/CartEvent.dart';
import 'package:faiikan/models/order_item.dart';
import 'package:faiikan/widgets/attribute_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final images = [
  'https://img.zanado.com/media/catalog/product/cache/all/thumbnail/360x420/7b8fef0172c2eb72dd8fd366c999954c/8/_/ao_khoac_nam_xo_ngon_pa_fashion_6729.jpg',
  'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg'
];

class OrderItemCard extends StatelessWidget {
  final OrderItem orderItem;
  final int index;

  const OrderItemCard(
      {required this.orderItem,
      required this.index,
      this.isOrderDetail = false});

  final bool isOrderDetail;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isOrderDetail?Color(0xffEFEBEB):Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: isOrderDetail?EdgeInsets.all(15):EdgeInsets.zero,
            child: Image.network(
              orderItem.productImgURL,
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
                              orderItem.productName,
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
                    GestureDetector(
                      onTap: () {
                       if(!isOrderDetail) showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return AttributesSheet(
                                images: images,
                                isSheet: true,
                              );
                            });
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
                                  orderItem
                                      .Color +
                                  ", " +
                                  orderItem.Size,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          NumberFormat.simpleCurrency(locale: "vi")
                              .format(orderItem.productPrice)
                              .toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                              decorationColor: Colors.black54,
                              decorationStyle: TextDecorationStyle.solid),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          NumberFormat.simpleCurrency(locale: "vi")
                              .format(orderItem.productPrice)
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
                                orderItem.count.toString(),
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
                                  if (orderItem.count > 0)
                                    context.read<CartBloc>().add(
                                        UpdateCartEvent(
                                            id: orderItem.id,
                                            amount: orderItem.count - 1,
                                            index: index));
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 16,
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
                                height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
//                                      color: Color(0xffF34646),
                                      border: Border.all(
                                    width: 1,
                                    color: Color(0xffD7DEE1),
                                  )),
                                  child: Center(
                                      child: Text(orderItem.count.toString(),style: TextStyle(color: Color(0xffFA4747)),))),
                              InkWell(
                                onTap: () {
                                  context.read<CartBloc>().add(UpdateCartEvent(
                                      id: orderItem.id,
                                      amount: orderItem.count + 1,
                                      index: index));
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 16,
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
