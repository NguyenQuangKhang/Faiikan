import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductBloc.dart';
import 'package:faiikan/blocs/product_bloc/ProductEvent.dart';
import 'package:faiikan/blocs/product_bloc/ProductState.dart';
import 'package:faiikan/models/category.dart';
import 'package:faiikan/screens/product_screen/ProductWithCatLv3_Screen.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Category2Dropdown extends StatefulWidget {
  final SubCategory data;
  final VoidCallback onTap;
  final VoidCallback onTapDropdownItem;
  final int userId;

  const Category2Dropdown({required this.data, required this.onTap, required this.onTapDropdownItem,required this.userId});

  @override
  _Category2DropdownState createState() => _Category2DropdownState();
}

class _Category2DropdownState extends State<Category2Dropdown> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: widget.onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.data.name,
                      style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600,letterSpacing: 0.5),
                    ),
                    Container(
                      width: 1,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Xem tất cả",style: TextStyle(color: Color(0xff0C73D2),fontSize: 10,letterSpacing: 0.5,fontWeight: FontWeight.w400,),),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Color(0xff0C73D2),
                  ),
                ],
              ),
            ],
          ),
        ),
      if(widget.data.subCategory.length>0)  Container(
        height: MediaQuery.of(context).size.height/6,
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.only(
                bottom: 5,
              ),
              child: ListView.builder(itemCount:widget.data.subCategory.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BlocProvider<ProductBloc>(
                                create: (_) {
                                  return ProductBloc(
                                    InitialProductState(
                                      data: [],
                                      error: "",
                                      sortBy: 0,
                                    ),
                                  )..add(ProductByCategoryCodeEvent(
                                      categoryId: widget.data
                                          .subCategory[index]
                                          .id
                                          .toString(),
                                      filter: "popular"));
                                },
                                child: BlocProvider.value(
                                    value: context.read<CartBloc>(),
                                    child: ProductWithSubCat_Screen(
                                        userId: widget.userId,
                                        title: widget.data
                                            .subCategory[index]
                                            .name,
                                        category: new Category(
                                          id: widget.data
                                              .subCategory[index]
                                              .id,
                                          name: widget.data
                                              .subCategory[index]
                                              .name,
                                          icon: widget.data
                                              .subCategory[index]
                                              .icon,
                                          level: widget.data
                                              .subCategory[index]
                                              .level,
                                          subCat:widget.data
                                              .subCategory[index]
                                              .subCategory,
                                        ))),
                              ),
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex:6,
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CachedNetworkImage(
                                imageUrl: widget.data.subCategory[index].icon,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex:2,
                          child: Text(
                            widget.data.subCategory[index].name,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              ),
            )
      ],
    );
  }
}