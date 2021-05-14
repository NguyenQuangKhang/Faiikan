import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/models/category.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category2Dropdown extends StatefulWidget {
  final Category data;
  final VoidCallback onTap;
  final VoidCallback onTapDropdownItem;

  const Category2Dropdown({required this.data, required this.onTap, required this.onTapDropdownItem});

  @override
  _Category2DropdownState createState() => _Category2DropdownState();
}

class _Category2DropdownState extends State<Category2Dropdown> {
  bool isExpanded = false;
  late List<Category> subCat=[];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: InkWell(
                  onTap: widget.onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.data.name,
                        style: TextStyle(color: Colors.black87, fontSize: 10),
                      ),
                      Container(
                        width: 1,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () async {
                    isExpanded = !isExpanded;


                    if (subCat.isEmpty) {
                      setState(() {
                        isLoading = true;
                      });

                      final response = await http.get(Uri.parse(
                          "http://$server:8080/api/v1/categories/${widget.data
                              .id.toString()}/sub-categories"));
                      subCat = json
                          .decode(response.body)
                          .cast<Map<String, dynamic>>()
                          .map<Category>((json) => Category.fromJson(json))
                          .toList();

                      setState(() {
                        isLoading = false;
                      });
                    }
                                        setState(() {});

                  },
                  child: Center(
                    child: Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (isExpanded)
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.only(
                bottom: 5,
              ),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: 4 / 6,
                mainAxisSpacing: 5,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 5,
                children: List.generate(
                  subCat.length,
                      (index) => InkWell(
                    onTap: (){
//                      Navigator.push(context,MaterialPageRoute(
//                          builder: (context)=> BlocProvider<ProductBloc>(
//                            create: (context){
//                              return ProductBloc(
//
//                              )..add(ProductByCategoryCodeEvent(categoryPath: subCat[index].categoryPath));
//                            },
//                            child:  Products_Screen(title: subCat[index].name, categoryPath: subCat[index].categoryPath),
//                          )
//                      )
//                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CachedNetworkImage(
                                imageUrl: subCat[index].icon,
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
                          flex: 2,
                          child: Text(
                            subCat[index].name,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
      ],
    );
  }
}