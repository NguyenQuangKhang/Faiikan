import 'package:faiikan/blocs/CartBloc/CartBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailBloc.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailEvent.dart';
import 'package:faiikan/blocs/product_detail_bloc/ProductDetailState.dart';
import 'package:faiikan/blocs/search_bloc/search_bloc.dart';
import 'package:faiikan/blocs/search_bloc/search_event.dart';
import 'package:faiikan/blocs/search_bloc/search_state.dart';
import 'package:faiikan/screens/product_detail_screen/product_detail_screen.dart';
import 'package:faiikan/widgets/card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> listHotSearch = [
  "ao hoodie",
  "quan jogger",
  "bikini",
  "Giay adidas",
  "ao hoodie",
  "quan jogger",
  "ao hoodie",
  "quan jogger",
  "bikini",
  "Giay adidas",
  "ao hoodie",
  "Giay adidas",
  "ao hoodie",
  "quan jogger",
  "bikini",
  "ao hoodie",
  "quan jogger",
  "bikini",
  "Giay adidas",
];

class SearchScreen extends StatefulWidget {
  final int userId;

  const SearchScreen({required this.userId});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          textInputAction: TextInputAction.search,
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintText: "Nhập để tìm kiếm",
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                letterSpacing: 0.5,
              )),
          onChanged: (value) {
            setState(() {});
          },
          onSubmitted: (value) {
            context.read<SearchBloc>().add(SearchTextEvent(
                text: controller.text, userId: widget.userId.toString()));
          },
          controller: controller,
        ),
        backgroundColor: Colors.white,
        actions: [
          if (controller.text.isNotEmpty)
            IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    controller.clear();
                  });
                  context.read<SearchBloc>().add(ResetSearchEvent());
                })
        ],
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is InitialSearchState || state is LoadSearch)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
              ),
            );
          if (state is ShowResultState)
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                  color: Color(0xffE7E7E7),
                                  width: 5,
                                ),
                                bottom: BorderSide(
                                  color: Color(0xffE7E7E7),
                                  width: 5,
                                ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.filter_list,
                                  size: 30,
                                  color: Color(0xff222222),
                                ),
                                Text(
                                  "Lọc",
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.refresh_rounded,
                                  color: Color(0xff222222),
                                  size: 30,
                                ),
                                Text(
                                  "Phổ biến",
                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
//                  SizedBox(
//                    height: 10,
//                  ),
                      BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return Stack(
                            children: <Widget>[
                              Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 5, vertical: 5),
                                color: Color(0xffE7E7E7),
                                height:
                                    MediaQuery.of(context).size.height - 130,
                                child: CustomScrollView(
                                    shrinkWrap: true,
                                    primary: false,
                                    controller: _scrollController,
                                    scrollDirection: Axis.vertical,
                                    slivers: <Widget>[
                                      SliverGrid(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      22 / 5) /
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          3 -
                                                      2.5),
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                          //childAspectRatio: AppSizes.tile_width / AppSizes.tile_height,
                                        ),
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            return GestureDetector(
                                                child: ProductCard(
                                                  onTapFavorite: () {},
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  product: context
                                                      .read<SearchBloc>()
                                                      .listSearch[index],
                                                  index: index,
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              MultiBlocProvider(
                                                                  providers: [
                                                                    BlocProvider(
                                                                        create: (_) => ProductDetailBloc(
                                                                            InitialProductDetail())
                                                                          ..add(
                                                                              ProductDetailLoadEvent(
                                                                            id: context.read<SearchBloc>().listSearch[index].id,
                                                                            person_id:
                                                                                widget.userId.toString(),
                                                                          ))),
                                                                    BlocProvider
                                                                        .value(
                                                                      value: context
                                                                          .read<
                                                                              CartBloc>(),
                                                                    ),
                                                                  ],
                                                                  child:
                                                                      ProductDetail(
                                                                    userId: widget
                                                                        .userId,
                                                                    percentStar: context
                                                                        .read<
                                                                            SearchBloc>()
                                                                        .listSearch[
                                                                            index]
                                                                        .percentStar,
                                                                    countRating: context
                                                                        .read<
                                                                            SearchBloc>()
                                                                        .listSearch[
                                                                            index]
                                                                        .countRating,
                                                                    price: context
                                                                        .read<
                                                                            SearchBloc>()
                                                                        .listSearch[
                                                                            index]
                                                                        .price,
                                                                    productId: context
                                                                        .read<
                                                                            SearchBloc>()
                                                                        .listSearch[
                                                                            index]
                                                                        .id,
                                                                  ))));
                                                });
                                          },
                                          childCount: context
                                              .read<SearchBloc>()
                                              .listSearch
                                              .length,
                                        ),
                                      ),
                                    ]),
                              ),
                              if (state is LoadMoreSearch)
                                Positioned(
                                  bottom: 10,
                                  left: MediaQuery.of(context).size.width / 2 -
                                      15,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Text(
                  "Tìm kiếm phổ biến",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 5,
                  spacing: 5,
                  children:
                      List<Widget>.generate(listHotSearch.length, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffE5E5E5).withAlpha(200),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        listHotSearch[index],
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 10,
                color: Color(0xffE5E5E5).withAlpha(200),
                thickness: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      "Lịch sử tìm kiếm",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 0.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                height: 0,
                color: Colors.black.withOpacity(0.2),
                thickness: 1,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Text(
                            context.read<SearchBloc>().listHistorySearch[index],
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 0.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    );
                  },
                  itemCount:
                      context.read<SearchBloc>().listHistorySearch.length,
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
