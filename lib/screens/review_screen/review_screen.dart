import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final images = [
  'https://img.zanado.com/media/catalog/product/cache/all/thumbnail/360x420/7b8fef0172c2eb72dd8fd366c999954c/8/_/ao_khoac_nam_xo_ngon_pa_fashion_6729.jpg',
  'https://img.zanado.com/media/cache_img/wysiwyg/2015/themhinh2015/thang-10/156513/ao_khoac_nam_xo_ngon_pa_fashion_a76a.jpg'
];

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Đánh giá",
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
      ),
      body: Column(
        children: [
          Container(
//            padding: EdgeInsets.all(20),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 15,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Đánh giá trung bình: ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: RatingBarIndicator(
                          rating: 4.5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.5" + "/5.0",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    spacing: 15,
                    alignment: WrapAlignment.center,
                    runSpacing: 15,
                    direction: Axis.horizontal,
                    children: List.generate(7, (index) {
                      if (index == 0)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Text("Tất cả"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "(" + "50" + ")",
                                  style: TextStyle(
                                      color: selected == index
                                          ? Color(0xffF34040)
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      if (index == 1)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Text("Có hình ảnh"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("(" + "0" + ")",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Color(0xffF34040)
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        );
                      if (index == 2)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                  child: RatingBarIndicator(
                                    rating: 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("(" + "40" + ")",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Color(0xffF34040)
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        );

                      if (index == 3)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 85) / 4,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                  child: RatingBarIndicator(
                                    rating: 4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 4,
                                    itemSize: 15.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("(" + "40" + ")",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Color(0xffF34040)
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        );
                      if (index == 4)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 85) / 4,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                  child: RatingBarIndicator(
                                    rating: 3,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 3,
                                    itemSize: 15.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("(" + "40" + ")",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Color(0xffF34040)
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        );
                      if (index == 5)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 85) / 4,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                  child: RatingBarIndicator(
                                    rating: 2,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 2,
                                    itemSize: 15.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("(" + "40" + ")",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Color(0xffF34040)
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        );
                      if (index == 6)
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 85) / 4,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: selected == index
                                  ? Color(0xffF34040)
                                  : Color(0xffA89D9D),
                              width: 1,
                            )),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                  child: RatingBarIndicator(
                                    rating: 1,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 1,
                                    itemSize: 15.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("(" + "40" + ")",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Color(0xffF34040)
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        );

                      return Container();
                    }),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 5,
            color: Color(0xffE7E7E7),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/236x/b5/0e/31/b50e311008e481dafae4be71f44f5d1f.jpg"),
                              radius: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Nguyễn Thị A',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                            ),
                            SizedBox(
                              height: 15,
                              child: RatingBarIndicator(
                                rating: 4.8,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Sản Phẩm chất lượng, đúng mô tả.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 35,),
                        Text(
                          "30-03-2021 12:00 | Phân loại: Đỏ, L",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              String image = images[index];
                              return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            offset: Offset(0, 0))
                                      ]),
                                  margin: EdgeInsets.only(right: 15),
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.fill,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 100,
                                    colorBlendMode: BlendMode.darken,
                                  ));
                            })),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 30,
                  right: 20,
                  child: Icon(
                    Icons.thumb_up_alt,
                    color: Colors.black.withOpacity(0.5),
                    size: 25,
                  ))
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/236x/b5/0e/31/b50e311008e481dafae4be71f44f5d1f.jpg"),
                              radius: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Nguyễn Thị A',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                            ),
                            SizedBox(
                              height: 15,
                              child: RatingBarIndicator(
                                rating: 4.8,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Sản Phẩm chất lượng, đúng mô tả.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 35,),
                        Text(
                          "30-03-2021 12:00 | Phân loại: Đỏ, L",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              String image = images[index];
                              return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            offset: Offset(0, 0))
                                      ]),
                                  margin: EdgeInsets.only(right: 15),
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.fill,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height: 100,
                                    colorBlendMode: BlendMode.darken,
                                  ));
                            })),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 30,
                  right: 20,
                  child: Icon(
                    Icons.thumb_up_alt,
                    color: Colors.black.withOpacity(0.5),
                    size: 25,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
