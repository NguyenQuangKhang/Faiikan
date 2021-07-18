import 'dart:io';
import 'dart:math';

import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_bloc.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_event.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_state.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_bloc.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_event.dart';
import 'package:faiikan/blocs/order_detail_bloc/order_detail_state.dart';
import 'package:faiikan/models/order_detail.dart';
import 'package:faiikan/models/order_item_rating.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CustomFile {
  late File file;
  late int type;

  CustomFile({required File file, required int type}) {
    this.file = file;
    this.type = type;
  }
}

class UpdateRatingScreen extends StatefulWidget {
  final OrderItemRating orderDetail;

  final String userId;

  UpdateRatingScreen({
    required this.orderDetail,
    required this.userId,
  });

  @override
  _UpdateRatingScreenState createState() => _UpdateRatingScreenState();
}

class _UpdateRatingScreenState extends State<UpdateRatingScreen> {
  TextEditingController txtReviewText = TextEditingController();

  bool valueSwitch = false;

  int star = 3;

  List<CustomFile> listImage = [];
  bool isLoading=true;

  @override
  void initState()  {

    if (widget.orderDetail.comment != null)
      txtReviewText.text = widget.orderDetail.comment!;
    super.initState();
    if (widget.orderDetail.fileRating != null)
      setUp(context);

  }

  void setUp(BuildContext context)
  async {
    for (int i = 0; i < widget.orderDetail.fileRating!.length; i++) {
      listImage.add(CustomFile(
          file: await urlToFile(widget
              .orderDetail.fileRating![i].linkUrl!
              .replaceAll("localhost", server)),
          type: widget.orderDetail.fileRating![i].contentType! == "image"
              ? 1
              : 2));
    }
    setState(() {
      isLoading=false;
    });
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

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
        body: isLoading?Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,)):BlocListener(
          bloc: context.read<OrderItemRatingBloc>(),
          listener: (context, state) {
            if (state is UpdateOrderItemRatingState) {
              Navigator.pop(context);
              context.read<OrderItemRatingBloc>().add(
                  InitiateOrderItemRatingEvent(
                      person_id: widget.userId,
                      productId: widget.orderDetail.idProduct!.toString(),
                      productOptionId:
                          widget.orderDetail.idProductOption!.toString()));
            }
          },
          child: BlocBuilder<OrderItemRatingBloc, OrderItemRatingState>(
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
                                    widget.orderDetail.imageProduct!,
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
                                        widget.orderDetail.nameProduct!,
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
                                              (widget.orderDetail.color ?? "") +
                                              "," +
                                              (widget.orderDetail.size ?? ""),
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
                            if (listImage == null)
                              InkWell(
                                onTap: () async {
                                  await AssetPicker.pickAssets(context,
                                          requestType: RequestType.all,
                                          textDelegate: EnglishTextDelegate())
                                      .then((assets) async {
                                    for (int i = 0; i < assets!.length; i++) {
                                      listImage.add(CustomFile(
                                          file: (await assets[i].file)!,
                                          type:
                                              assets[i].type == AssetType.image
                                                  ? 1
                                                  : 2));

                                    }

                                    setState(() {});
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
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listImage.length + 1,
                                    itemBuilder: (context, index) => index ==
                                            listImage.length
                                        ? InkWell(
                                            onTap: () async {
                                              await AssetPicker.pickAssets(
                                                      context,
                                                      requestType:
                                                          RequestType.all,
                                                      textDelegate:
                                                          EnglishTextDelegate())
                                                  .then((assets) async {
                                                for (int i = 0;
                                                    i < assets!.length;
                                                    i++) {
                                                  listImage.add(CustomFile(
                                                      file: (await assets[i]
                                                          .file)!,
                                                      type: assets[i].type ==
                                                              AssetType.image
                                                          ? 1
                                                          : 2));
                                                  print(assets[i].type == AssetType.image);
                                                }

                                                setState(() {});
                                              });
                                            },
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : listImage[index].type == 1
                                            ? Stack(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Image.file(
                                                      listImage[index].file,
                                                      fit:BoxFit.fill,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                    ),
                                                  ),
                                                  Positioned(
                                                      right: 10,
                                                      top: 0,
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              listImage
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black54),
                                                            child: Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color: Colors.white,
                                                              size: 30,
                                                            ),
                                                          )))
                                                ],
                                              )
                                            : Stack(
                                                children: [
                                                  VideoItems(
                                                      videoPlayerController:
                                                          VideoPlayerController
                                                              .file(listImage[
                                                                      index]
                                                                  .file)),
                                                  Positioned(
                                                    right: 10,
                                                      top: 0,
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              listImage
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black54),
                                                            child: Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color: Colors.white,
                                                              size: 30,
                                                            ),
                                                          )))
                                                ],
                                              )),
                              ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                height: MediaQuery.of(context).size.height / 4,
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
                                    onChanged: (value) {
                                      setState(() {
                                        valueSwitch = value;
                                      });
                                    },
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
                          context.read<OrderItemRatingBloc>().add(
                              UpdateOrderItemRatingEvent(
                                  comment: txtReviewText.text,
                                  incognito: valueSwitch,
                                  listFiles:
                                      listImage,
                                  star: star.toString(),
                                  ratingId: widget.orderDetail.id.toString()));
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
                              "Lưu",
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
                  if (state is LoadOrderItemRating)
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

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  VideoItems({
    required this.videoPlayerController,
  });

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  @override
  void initState() {
    super.initState();
    widget.videoPlayerController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: MediaQuery.of(context).size.height / 6,
              height: MediaQuery.of(context).size.height / 6,
              child: VideoPlayer(widget.videoPlayerController),
            ),
          ),
        ),
        Center(
          child: InkWell(
              onTap: () {
                if (widget.videoPlayerController.value.isPlaying)
                  widget.videoPlayerController.pause();
                else
                  widget.videoPlayerController.play();
              },
              child: Icon(
                widget.videoPlayerController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 30,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
