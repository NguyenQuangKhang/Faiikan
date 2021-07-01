import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostExplorer extends StatelessWidget {
  const PostExplorer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
//        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: RichText(
            text: TextSpan(
                text: "FAII",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: "KAN",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: Color(0xffEF5454),
                    ),
                  ),
                ]),
          ),
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
//                height: MediaQuery.of(context).size.height / 3 + 100,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://www.goladiesmag.com/wp-content/uploads/2015/05/product6-680x400.jpg",
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    30) /
                                                3,
                                        colorBlendMode: BlendMode.darken,
                                        color: Colors.black26,
                                      )),
                                  Positioned(
                                    bottom: 20,
                                    left: (MediaQuery.of(context).size.width -
                                                30) /
                                            6 -
                                        40,
                                    child: Container(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Kết hợp",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://www.sheebamagazine.com/wp-content/uploads/2019/08/How-To-Combine-Contrasting-Styles-in-One-Outfit-620x472.jpg",
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    30) /
                                                3,
                                        colorBlendMode: BlendMode.darken,
                                        color: Colors.black26,
                                      )),
                                  Positioned(
                                    bottom: 20,
                                    left: (MediaQuery.of(context).size.width -
                                                30) /
                                            6 -
                                        40,
                                    child: Container(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Gals",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://i.pinimg.com/564x/7b/d6/26/7bd62658ca2a7f51b284c3c5b1fa636c.jpg",
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    30) /
                                                3,
                                        colorBlendMode: BlendMode.darken,
                                        color: Colors.black26,
                                      )),
                                  Positioned(
                                    bottom: 20,
                                    left: (MediaQuery.of(context).size.width -
                                                30) /
                                            6 -
                                        40,
                                    child: Container(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Media",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text("Cuộc thi cực hot"),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 6,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: Row(
                                            children: [
                                              Image.network(
                                                "http://www.fashionbyfashion.com/wp-content/uploads/2020/01/organic-cotton-clothes.jpg",
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        6 -
                                                    40,
                                                fit: BoxFit.fill,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          child: Text(
                                                            "FAIIKAN-SUMMER",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              letterSpacing:
                                                                  0.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          child: Text(
                                                            "kết thúc sau ",
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              letterSpacing:
                                                                  0.5,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          color: Colors.black,
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Text(
                                                            "kết hợp",
                                                            style: TextStyle(
                                                              letterSpacing:
                                                                  0.5,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Text(
                                                            "3453 sản phẩm",
                                                            style: TextStyle(
                                                              letterSpacing:
                                                                  0.5,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
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
              SliverAppBar(
                floating: true,
                pinned: true,
//                expandedHeight: MediaQuery.of(context).size.height / 3 + 100,
//               collapsedHeight: 80,
//                toolbarHeight: 100,
                backgroundColor: Colors.white,
//                flexibleSpace: Container(height: 500,color: Colors.pink,),
                bottom: TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                  unselectedLabelColor: Colors.black.withOpacity(0.6),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Container(
                      // width: MediaQuery.of(context).size.width / 4 - 30,
                      child: Tab(
                        child: Text(
                          "GIỚI THIỆU CHO BẠN",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width / 4 - 30,
                      child: Tab(
                        child: Text(
                          "FAIIKAN STYLE",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width / 4 - 30,
                      child: Tab(
                        child: Text(
                          "FAIIKAN SUMMER",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width / 4 - 30,
                      child: Tab(
                        child: Text(
                          "FAIIKAN BEAUTY",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                color: Color(0xffC4C4C4).withOpacity(0.5),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        height: index == 0
                            ? MediaQuery.of(context).size.height / 3 + 60
                            : MediaQuery.of(context).size.height / 3,
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "https://expertphotography.com/wp-content/uploads/2018/04/Fashion-Photography-Composition-5.jpg",
                              fit: BoxFit.fill,
                              height: index == 0
                                  ? MediaQuery.of(context).size.height / 3 +
                                      60 -
                                      100
                                  : MediaQuery.of(context).size.height / 3 -
                                      100,
                              width:
                                  (MediaQuery.of(context).size.width - 30) / 2,
                              colorBlendMode: BlendMode.darken,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sự kết hợp giữa quần Jean và áo thun luôn là sự lựa chọn ưu tiên đối với những cuộc đi dạo",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff4B4A5A),
                                        fontWeight: FontWeight.w500),
//                            textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "David Bez Ben",
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (_) => StaggeredTile.fit(2)),
              ),
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
//        backgroundColor: Colors.grey,
      ),
    );
  }
}
