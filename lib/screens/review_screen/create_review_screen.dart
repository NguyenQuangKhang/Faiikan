import 'package:faiikan/blocs/order_detail_bloc/order_detail_bloc.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_event.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_state.dart';
import 'package:faiikan/models/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateReviewScreen extends StatefulWidget {
  final OrderDetail orderDetail;
  final int index;
  final String userId;

  CreateReviewScreen(
      {required this.orderDetail, required this.userId, required this.index});

  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  TextEditingController txtReviewText = TextEditingController();

  bool valueSwitch = false;

  int star = 3;

  List<AssetEntity>? listImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Viết đánh giá",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocListener(
          bloc: context.read<OrderDetailBloc>(),
          listener: (context, state) {
            if (state is CreateReviewSuccessState) {
              Navigator.pop(context);
              context.read<OrderDetailBloc>().add(InitiateOrderDetailEvent(
                  orderId: widget.orderDetail.id!.toString()));
            }
          },
          child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffC4C4C4)
                                              .withOpacity(0.7),
                                          width: 1))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    widget.orderDetail.listItem![widget.index].imageUrl!,
                                    height: 25,
                                    width: 20,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.orderDetail.listItem![widget.index].name!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          "Phân loại: " +
                                              (widget.orderDetail
                                                      .listItem![widget.index].color ??
                                                  "") +
                                              "," +
                                              (widget.orderDetail
                                                      .listItem![widget.index].size ??
                                                  ""),
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                star = rating.toInt();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                           if(listImage ==null) InkWell(
                              onTap: () async {
                                await AssetPicker.pickAssets(context,requestType: RequestType.all,textDelegate: EnglishTextDelegate() )
                                    .then((assets) {
                                      listImage =assets;
                                      setState(() {
                                      });
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                      color: Color(0xffF87070),
                                      width: 1,
                                    )),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xffF87070),
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Thêm ảnh/ video",
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontSize: 14,
                                          color: Color(0xffF87070),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            else
                              Container(height: MediaQuery.of(context).size.height/6,width: MediaQuery.of(context).size.width,child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: listImage!.length,itemBuilder: (context,index) =>Container(margin: EdgeInsets.only(right: 10),child: Image(image: AssetEntityImageProvider(listImage![index], isOriginal: false),height: MediaQuery.of(context).size.height/6,width: MediaQuery.of(context).size.height/6,),)),),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                height: MediaQuery.of(context).size.height/4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(3)),
                                child: TextField(
                                  controller: txtReviewText,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Hãy chia sẻ cảm nhận, đánh giá của bạn về sản phẩm",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.4),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  maxLength: 1000,
                                  maxLines: null,
                                )),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Ẩn danh"),
                                  CupertinoSwitch(
                                    value: valueSwitch,
                                    onChanged: (value) {},
                                    activeColor: Colors.redAccent,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<OrderDetailBloc>().add(CreateReviewEvent(
                              orderItem: context.read<OrderDetailBloc>().orderDetail.listItem![widget.index].id!.toString(),
                              userId: widget.userId,
                              comment: txtReviewText.text,
                              incognito: valueSwitch,
                              listImage: listImage,
                              star: star));
                        },
                        child: Container(
                          height: 50,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color(0xffF34646),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 2)
                              ]),
                          child: Center(
                            child: Text(
                              "Đánh giá",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state is LoadingOrderDetail)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                      ),
                    )
                ],
              );
            },
          ),
        ));
  }
}
