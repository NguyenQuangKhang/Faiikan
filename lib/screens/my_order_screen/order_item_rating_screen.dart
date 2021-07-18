import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_bloc.dart';
import 'package:faiikan/blocs/orderItem_rating/orderitem_rating_state.dart';
import 'package:faiikan/screens/my_order_screen/update_order_item_rating_screen.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItemRatingScreen extends StatelessWidget {
  final String userId;

  const OrderItemRatingScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<OrderItemRatingBloc, OrderItemRatingState>(
          builder: (context, state) {
        if (state is LoadOrderItemRating)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
            ),
          );
        return Stack(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    rating: context
                        .read<OrderItemRatingBloc>()
                        .OrderItemRatings
                        .star!
                        .toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                  ),
                  if (context
                          .read<OrderItemRatingBloc>()
                          .OrderItemRatings
                          .comment !=
                      null)
                    if (context
                        .read<OrderItemRatingBloc>()
                        .OrderItemRatings
                        .comment!
                        .isNotEmpty)
                      SizedBox(
                        height: 5,
                      ),
                  if (context
                          .read<OrderItemRatingBloc>()
                          .OrderItemRatings
                          .comment !=
                      null)
                    if (context
                        .read<OrderItemRatingBloc>()
                        .OrderItemRatings
                        .comment!
                        .isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          context
                              .read<OrderItemRatingBloc>()
                              .OrderItemRatings
                              .comment!,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffC4C4C4).withOpacity(0.5),
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffC4C4C4).withOpacity(0.7),
                                  width: 1))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                context
                                    .read<OrderItemRatingBloc>()
                                    .OrderItemRatings
                                    .imageProduct!,
                                height: 40,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context
                                          .read<OrderItemRatingBloc>()
                                          .OrderItemRatings
                                          .nameProduct!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 0.5,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "Phân loại: " +
                                            (context
                                                    .read<OrderItemRatingBloc>()
                                                    .OrderItemRatings
                                                    .size ??
                                                "") +
                                            (context
                                                    .read<OrderItemRatingBloc>()
                                                    .OrderItemRatings
                                                    .color ??
                                                ""),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 10,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      context
                          .read<OrderItemRatingBloc>()
                          .OrderItemRatings
                          .timeUpdated!,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 10,
                          letterSpacing: 0.5),
                    ),
                  ),
                  if (context
                          .read<OrderItemRatingBloc>()
                          .OrderItemRatings
                          .fileRating!
                          .length >
                      0)
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: context
                                .read<OrderItemRatingBloc>()
                                .OrderItemRatings
                                .fileRating!
                                .length,
                            itemBuilder: (context, i) {
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
                                  child: context
                                              .read<OrderItemRatingBloc>()
                                              .OrderItemRatings
                                              .fileRating![i]
                                              .contentType ==
                                          "image"
                                      ? CachedNetworkImage(
                                          imageUrl: context
                                              .read<OrderItemRatingBloc>()
                                              .OrderItemRatings
                                              .fileRating![i]
                                              .linkUrl!
                                              .replaceAll("localhost", server),
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 100,
                                          colorBlendMode: BlendMode.darken,
                                        )
                                      : VideoItems(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  context
                                                      .read<
                                                          OrderItemRatingBloc>()
                                                      .OrderItemRatings
                                                      .fileRating![i]
                                                      .linkUrl!
                                                      .replaceAll(
                                                          "localhost", server)),
                                        ));
                            })),
                ],
              ),
            ),
            Positioned(
              right: 10,
                top: 10,
                child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<OrderItemRatingBloc>(),
                          child: UpdateRatingScreen(
                                orderDetail: context
                                    .read<OrderItemRatingBloc>()
                                    .OrderItemRatings,
                                userId: userId,
                              ),
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.redAccent)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                  child: Text(
                    "Sửa",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )),

          ],
        );
      }),
    );
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
              width: MediaQuery.of(context).size.width / 4,
              height: 100,
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
