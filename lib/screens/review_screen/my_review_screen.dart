import 'package:cached_network_image/cached_network_image.dart';
import 'package:faiikan/blocs/my_rating_bloc/my_rating_bloc.dart';
import 'package:faiikan/blocs/my_rating_bloc/my_rating_event.dart';
import 'package:faiikan/blocs/my_rating_bloc/my_rating_state.dart';
import 'package:faiikan/models/product_detail.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';

class MyReviewScreen extends StatefulWidget {
  final String userId;

  const MyReviewScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _MyReviewScreenState createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  int selectedIndex = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        int star = 0;
        switch (selectedIndex) {
          case 0:
            star = 0;
            break;
          case 1:
            star = 5;
            break;
          case 2:
            star = 4;
            break;
          case 3:
            star = 3;
            break;
          case 4:
            star = 2;
            break;
          case 5:
          default:
            star = 1;
            break;
        }
        context
            .read<MyRatingBloc>()
            .add(LoadMoreMyRatingEvent(person_id: widget.userId, star: star));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Đánh giá của tôi",
          style: TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<MyRatingBloc, MyRatingState>(builder: (context, state) {
        if (state is InitialMyRatingState)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
            ),
          );
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  color: Color(0xff24C3A1),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: Color(0xff24C3A1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              calAverageStarRating(context.read<MyRatingBloc>().count).toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RatingBarIndicator(
                          rating: calAverageStarRating(context.read<MyRatingBloc>().count),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          itemCount: 5,
                          itemSize: 15,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Wrap(
                    spacing: 15,
                    direction: Axis.horizontal,
                    runSpacing: 5,
                    children: List.generate(6, (index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            context.read<MyRatingBloc>().add(
                                ChangeStar(
                                    person_id: widget.userId, star: 0));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: (MediaQuery.of(context).size.width - 50) / 3,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color(0xff24C3A1)
                                    : Color(0xffC4C4C4).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2)),
                            child: Center(
                              child: Text(
                                "Tất cả" +
                                    (context
                                                .read<MyRatingBloc>()
                                                .count
                                                .totalStar1 +
                                            context
                                                .read<MyRatingBloc>()
                                                .count
                                                .totalStar2 +
                                            context
                                                .read<MyRatingBloc>()
                                                .count
                                                .totalStar3 +
                                            context
                                                .read<MyRatingBloc>()
                                                .count
                                                .totalStar4 +
                                            context
                                                .read<MyRatingBloc>()
                                                .count
                                                .totalStar5)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      if (index == 1) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            context.read<MyRatingBloc>().add(
                                ChangeStar(
                                    person_id: widget.userId, star: 5));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: (MediaQuery.of(context).size.width - 50) / 3,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color(0xff24C3A1)
                                    : Color(0xffC4C4C4).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2)),
                            child: Center(
                              child: Text(
                                "5 sao" +
                                    context
                                        .read<MyRatingBloc>()
                                        .count
                                        .totalStar5
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      if (index == 2) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            context.read<MyRatingBloc>().add(
                                ChangeStar(
                                    person_id: widget.userId, star: 4));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: (MediaQuery.of(context).size.width - 50) / 3,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color(0xff24C3A1)
                                    : Color(0xffC4C4C4).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2)),
                            child: Center(
                              child: Text(
                                "4 sao" +
                                    context
                                        .read<MyRatingBloc>()
                                        .count
                                        .totalStar4
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      if (index == 3) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            context.read<MyRatingBloc>().add(
                                ChangeStar(
                                    person_id: widget.userId, star: 3));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: (MediaQuery.of(context).size.width - 50) / 3,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color(0xff24C3A1)
                                    : Color(0xffC4C4C4).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2)),
                            child: Center(
                              child: Text(
                                "3 sao" +
                                    context
                                        .read<MyRatingBloc>()
                                        .count
                                        .totalStar3
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      if (index == 4) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            context.read<MyRatingBloc>().add(
                                ChangeStar(
                                    person_id: widget.userId, star: 2));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: (MediaQuery.of(context).size.width - 50) / 3,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color(0xff24C3A1)
                                    : Color(0xffC4C4C4).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2)),
                            child: Center(
                              child: Text(
                                "2 sao" +
                                    context
                                        .read<MyRatingBloc>()
                                        .count
                                        .totalStar2
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          context.read<MyRatingBloc>().add(
                              ChangeStar(
                                  person_id: widget.userId, star: 1));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: (MediaQuery.of(context).size.width - 50) / 3,
                          decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Color(0xff24C3A1)
                                  : Color(0xffC4C4C4).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(2)),
                          child: Center(
                            child: Text(
                              "1 sao" +
                                  context
                                      .read<MyRatingBloc>()
                                      .count
                                      .totalStar1
                                      .toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                  controller: scrollController,
                  itemCount: context.read<MyRatingBloc>().MyRatings.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color(0xffC4C4C4).withOpacity(0.7))),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: context
                              .read<MyRatingBloc>()
                              .MyRatings[index].star!.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                          ),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        if(context
                            .read<MyRatingBloc>()
                            .MyRatings[index]
                            .comment !=null)
                          if (context
                              .read<MyRatingBloc>()
                              .MyRatings[index]
                              .comment!
                              .isNotEmpty)
                            SizedBox(
                              height: 5,
                            ),
                        if(context
                            .read<MyRatingBloc>()
                            .MyRatings[index]
                            .comment !=null)
                          if (context
                              .read<MyRatingBloc>()
                              .MyRatings[index]
                              .comment!
                              .isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                context
                                    .read<MyRatingBloc>()
                                    .MyRatings[index]
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffC4C4C4).withOpacity(0.5),
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffC4C4C4)
                                            .withOpacity(0.7),
                                        width: 1))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      context
                                          .read<MyRatingBloc>()
                                          .MyRatings[index]
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context
                                                .read<MyRatingBloc>()
                                                .MyRatings[index]
                                                .nameProduct!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 0.5,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              "Phân loại: " +
                                                  (context
                                                      .read<
                                                      MyRatingBloc>()
                                                      .MyRatings[index]
                                                      .size ??
                                                      "") +
                                                  (context
                                                      .read<
                                                      MyRatingBloc>()
                                                      .MyRatings[index]
                                                      .color ??
                                                      ""),
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
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
                                .read<MyRatingBloc>()
                                .MyRatings[index]
                                .timeUpdated!,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 10,
                                letterSpacing: 0.5),
                          ),
                        ),
                        if (context
                            .read<MyRatingBloc>()
                            .MyRatings[index]
                            .fileRating!
                            .length >
                            0)
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: context
                                      .read<MyRatingBloc>()
                                      .MyRatings[index]
                                      .fileRating!
                                      .length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black
                                                  .withOpacity(0.2),
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
                                            .read<MyRatingBloc>()
                                            .MyRatings[index]
                                            .fileRating![i]
                                            .contentType ==
                                            "image"
                                            ? CachedNetworkImage(
                                          imageUrl: context
                                              .read<MyRatingBloc>()
                                              .MyRatings[index]
                                              .fileRating![i]
                                              .linkUrl!
                                              .replaceAll(
                                              "localhost", server),
                                          placeholder: (context, url) =>
                                              Center(
                                                  child:
                                                  CircularProgressIndicator()),
                                          errorWidget:
                                              (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              4,
                                          height: 100,
                                          colorBlendMode:
                                          BlendMode.darken,
                                        )
                                            : VideoItems(
                                          videoPlayerController:
                                          VideoPlayerController
                                              .network(context
                                              .read<
                                              MyRatingBloc>()
                                              .MyRatings[index]
                                              .fileRating![i]
                                              .linkUrl!
                                              .replaceAll(
                                              "localhost",
                                              server)),
                                        ));
                                  })),
                      ],
                    ),
                    );
                  },
                )),
              ],
            ),
            if (state is LoadMyRating)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                ),
              ),
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
double calAverageStarRating(TotalCount s) {
  if(s.totalStar1 + s.totalStar2 + s.totalStar3 + s.totalStar4 + s.totalStar5==0)
    return 0;
  return (s.totalStar1 + s.totalStar2 * 2 + s.totalStar3 * 3 + s.totalStar4 * 4 + s.totalStar5 * 5) /
      (s.totalStar1 + s.totalStar2 + s.totalStar3 + s.totalStar4 + s.totalStar5);
}
