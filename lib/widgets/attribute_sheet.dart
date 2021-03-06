import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/category_bloc/category_event.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_bloc.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_event.dart';
import 'package:faiikan/blocs/my_order_bloc/my_order_state.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/screens/my_order_screen/my_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AttributesSheet extends StatefulWidget {
  final List<String> images;
  final bool hasMuaHang;
  final bool hasThemGioHang;

  AttributesSheet({required this.images, required this.hasMuaHang,required this.hasThemGioHang});

  @override
  _AttributesSheetState createState() => _AttributesSheetState();
}

class _AttributesSheetState extends State<AttributesSheet> {
  int count = 1;
  late var listIndexSelected;
 late double height;
  @override
  void initState() {
    height=220;
   if( context
        .read<ProductDetailBloc>()
        .productDetail
        .attributes
        .where((att) => att.code == "color").isNotEmpty)
     height+= 150;
   if( context
        .read<ProductDetailBloc>()
        .productDetail
        .attributes
        .where((att) => att.code != "image" && att.code !="color").isNotEmpty)
     height+= 90*context
         .read<ProductDetailBloc>()
         .productDetail
         .attributes
         .where((att) => att.code != "image" && att.code !="color").length;

    // TODO: implement initState
    listIndexSelected = new List<int>.filled(context
        .read<ProductDetailBloc>()
        .productDetail
        .attributes
        .where((att) => att.code != "image").length, 0, growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//print(context
//    .read<ProductDetailBloc>()
//    .productDetail
//    .attributes
//    .where((att) => att.code != "image").length);
//    print(context
//        .read<ProductDetailBloc>()
//        .productDetail.optionProducts.firstWhere((e) {
//         for(int i=0;i<listIndexSelected.length;i++)
//           {
//             if(e.option.where((a) => a.id == context
//                 .read<ProductDetailBloc>()
//                 .productDetail
//                 .attributes
//                 .where((att) => att.code != "image").toList()[i].options[listIndexSelected[i]].id).isEmpty)
//               return false;
//           }
//          return true;
//     }).quantity.value);
    return Container(
      height: height,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( width: MediaQuery.of(context).size.width-20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          NumberFormat.simpleCurrency(locale: "vi")
                              .format(context
                              .read<ProductDetailBloc>()
                              .productDetail.optionProducts.firstWhere((e) {
                            for(int i=0;i<listIndexSelected.length;i++)
                            {
                              if(e.option.where((a) => a.id == context
                                  .read<ProductDetailBloc>()
                                  .productDetail
                                  .attributes
                                  .where((att) => att.code != "image").toList()[i].options[listIndexSelected[i]].id).isEmpty)
                                return false;
                            }
                            return true;
                          }).price.value)
                              .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF65151),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        InkWell(onTap: (){Navigator.of(context).pop();},child: Icon(Icons.cancel_outlined,color: Colors.grey,))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kho: " + context
                        .read<ProductDetailBloc>()
                        .productDetail.optionProducts.firstWhere((e) {
                      for(int i=0;i<listIndexSelected.length;i++)
                      {
                        if(e.option.where((a) => a.id == context
                            .read<ProductDetailBloc>()
                            .productDetail
                            .attributes
                            .where((att) => att.code != "image").toList()[i].options[listIndexSelected[i]].id).isEmpty)
                          return false;
                      }
                      return true;
                    }).quantity.value.toString(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 1,
            color: Colors.black26,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      context
                          .read<ProductDetailBloc>()
                          .productDetail
                          .attributes
                          .where((att) => att.code != "image")
                          .length, (index) {
                    if (context
                        .read<ProductDetailBloc>()
                        .productDetail
                        .attributes
                        .where((att) => att.code != "image").toList()[index]
                        .code ==
                        "color")
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ma??u:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: context
                                        .read<ProductDetailBloc>()
                                        .productDetail
                                        .attributes
                                        .where((att) => att.code != "image").toList()[index]
                                    /*.firstWhere((element) => element.code == "color")*/
                                        .options
                                        .length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            listIndexSelected[index] = i;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: i ==
                                                      listIndexSelected[index]
                                                      ? Color(0xffFA4747)
                                                      : Colors.black
                                                      .withOpacity(0.1),
                                                  width: 1,
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: context
                                                    .read<ProductDetailBloc>()
                                                    .productDetail
                                                    .optionProducts
                                                    .firstWhere((element) {
                                                  for (var u
                                                  in element.option) {
                                                    if (u.id ==
                                                        context
                                                            .read<ProductDetailBloc>()
                                                            .productDetail
                                                            .attributes
                                                            .where((att) => att.code != "image").toList()[index]
                                                        /* .firstWhere((a) => a.code == "color")*/
                                                            .options[i]
                                                            .id) return true;
                                                  }
                                                  return false;
                                                })
                                                    .option
                                                    .firstWhere((e) =>
                                                e.value.length > 3 &&
                                                    e.value.substring(0, 4) ==
                                                        "http")
                                                    .value,
                                                height: 100,
                                                width: 80,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                        CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                            Text(
                                              context
                                                  .read<ProductDetailBloc>()
                                                  .productDetail
                                                  .attributes
                                                  .firstWhere((element) =>
                                              element.code == "color")
                                                  .options[i]
                                                  .value,
                                              style: TextStyle(
                                                color:
                                                i == listIndexSelected[index]
                                                    ? Color(0xffFA4747)
                                                    : Colors.black,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      );
                    else
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context
                                .read<ProductDetailBloc>()
                                .productDetail
                                .attributes
                                .where((att) => att.code != "image").toList()[index].code,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: context
                                          .read<ProductDetailBloc>()
                                          .productDetail
                                          .attributes
                                          .where((att) => att.code != "image").toList()[index]
                                          .options
                                          .length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              listIndexSelected[index] = i;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: i ==
                                                        listIndexSelected[
                                                        index]
                                                        ? Color(0xffFA4747)
                                                        : Color(0xffC4C4C4)
                                                        .withOpacity(0.5)),
                                                color:
                                                i == listIndexSelected[index]
                                                    ? Colors.white
                                                    : Color(0xffC4C4C4)
                                                    .withOpacity(0.5)),
                                            height: 30,
                                            width: 70,
                                            child: Center(
                                              child: Text(
                                                context
                                                    .read<ProductDetailBloc>()
                                                    .productDetail
                                                    .attributes
                                                    .where((att) => att.code != "image").toList()[index]
                                                    .options[i]
                                                    .value,
                                                style: TextStyle(
                                                  color: i ==
                                                      listIndexSelected[index]
                                                      ? Color(0xffFA4747)
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      );
                  }),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "S???? l??????ng:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (count > 1)
                              setState(() {
                                count--;
                              });
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
                                child: Text(
                                  count.toString(),
                                  style: TextStyle(color: Color(0xffFA4747)),
                                ))),
                        InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                            });
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
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
               if(widget.hasThemGioHang) Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<ProductDetailBloc>().optionProductId=context
                          .read<ProductDetailBloc>()
                          .productDetail.optionProducts.firstWhere((e) {
                        for(int i=0;i<listIndexSelected.length;i++)
                        {
                          if(e.option.where((a) => a.id == context
                              .read<ProductDetailBloc>()
                              .productDetail
                              .attributes
                              .where((att) => att.code != "image").toList()[i].options[listIndexSelected[i]].id).isEmpty)
                            return false;
                        }
                        return true;
                      }).productOptionId.toString();
                      context.read<ProductDetailBloc>().amount=count;
                      Navigator.of(context).pop("Th??m va??o gio?? ha??ng");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff188A31),
                            width: 1,
                          )),
                      child: Center(
                        child: Text(
                          "Th??m va??o gio?? ha??ng",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff188A31),
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.hasMuaHang && widget.hasThemGioHang)
                  SizedBox(
                    width: 10,
                  ),
                if (widget.hasMuaHang)
                  Expanded(
                    child: InkWell(
                      onTap: () {

                        context.read<ProductDetailBloc>().optionProductId=context
                            .read<ProductDetailBloc>()
                            .productDetail.optionProducts.firstWhere((e) {
                          for(int i=0;i<listIndexSelected.length;i++)
                          {
                            if(e.option.where((a) => a.id == context
                                .read<ProductDetailBloc>()
                                .productDetail
                                .attributes
                                .where((att) => att.code != "image").toList()[i].options[listIndexSelected[i]].id).isEmpty)
                              return false;
                          }
                          return true;
                        }).productOptionId.toString();
                        context
                            .read<ProductDetailBloc>().options=context.read<ProductDetailBloc>().productDetail.optionProducts.firstWhere((e) {
                          for(int i=0;i<listIndexSelected.length;i++)
                          {
                            if(e.option.where((a) => a.id == context.read<ProductDetailBloc>().productDetail
                                .attributes
                                .where((att) => att.code != "image").toList()[i].options[listIndexSelected[i]].id).isEmpty)
                              return false;
                          }
                          return true;
                        }).option.where((e) => !e.value.contains("http")).map((a) => a.value).toList();
                        context.read<ProductDetailBloc>().amount=count;
                      Navigator.of(context).pop("Mua ngay");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffF34646),
                        ),
                        child: Center(
                          child: Text(
                            "Mua ngay",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('listIndexSelected', listIndexSelected));
  }
}
