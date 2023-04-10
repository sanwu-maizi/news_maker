//import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:news_maker/page/content_page/content_page.dart';
import 'package:news_maker/page/list_page/model.dart';
import 'package:news_maker/page/button/scrolltotopbutton.dart';
import 'package:news_maker/page/list_page/entity.dart';

class ListPage extends StatefulWidget {
  final String type;
  final ValueNotifier<Color> appBarColor;
  static List<Data> history = [];
  const ListPage({Key? key, required this.type, required this.appBarColor}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final NewsListModel _model = NewsListModel();
  List<Data>? _list;
  var _curPage = 1;
  //final dragController = DragController();

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _list = null;
      // 重置页码为1
    });
    _curPage = 1;
    await _loadData();
  }

  Future<void> _loadData() async {
    final entity = await _model.getData(type: widget.type, page: _curPage);
    setState(() {
      _list = entity?.data;
    });
  }

  //bool _isLoading = false;

  Future<void> _loadNewPage() async {
    _curPage++;
    final entity = await _model.getData(type: widget.type, page: _curPage);
    setState(() {
      _list!.addAll(entity?.data ?? []);
    });
  }

  @override
  void initState() {
    super.initState();
    //_isLoading = false;
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadNewPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //initialData: NewsListEntity(data: []),
      future: _model.getData(type: widget.type),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //print(snapshot.data);
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(children: [
              RefreshIndicator(
                  onRefresh: _refreshData,
                  child: Scrollbar(
                    child: _list == null
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            controller: _scrollController,
                            itemCount: _list!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: widget.appBarColor.value.withOpacity(0.1),
                                child:
                                  ListTile(
                                    //backgroundColor: Colors.yellow,
                                    title: Text(
                                      _list![index].title!,
                                      softWrap: false,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_list![index].date!),
                                        const Divider(
                                          color: Colors.black12,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      toContentPage(context,
                                          snapshot.data!.data![index].link);
                                      if (ListPage.history
                                          .contains(_list![index])) {
                                        final int existingIndex =
                                            ListPage.history.indexOf(_list![index]);
                                        ListPage.history.removeAt(existingIndex);
                                        ListPage.history.add(_list![index]);
                                      } else {
                                        setState(() {
                                          ListPage.history.add(_list![index]);
                                        });
                                      }
                                    },
                                  ),
                              );
                            },
                            //ScrollToTopButton(controller: _scrollController),
                          ),
                  )),
              //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
              // ],
              // ),
              //
              //   GestureDetector(onVerticalDragStart: (details) {},
              //     child:DraggableWidget(
              //       bottomMargin: 10,
              //       topMargin: 10,
              //       intialVisibility: true,
              //       horizontalSpace: 20,
              //       shadowBorderRadius: 50,
              //       child: Container(
              //         height: 80,
              //         width: 80,
              //         decoration: BoxDecoration(
              //           color: Colors.blue,
              //           shape: BoxShape.circle,
              //         ),
              //       ),
              //       initialPosition: AnchoringPosition.bottomLeft,
              //       dragController: dragController,
              //     ),
              //   )
              // ])
              ScrollToTopButton(
                controller: _scrollController,
                checkToShow: false,
              ),
            ]),
          );
        } else {
          // return Scaffold(
          //   appBar: null,
          //   body: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text("请耐心等待捏...(╹ڡ╹ )"),
          //       CircularProgressIndicator(
          //         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // 设置加载动画颜色为白色
          //       ),
          //     ],
          //   )
          // );
          return Center(
            child: Text("请耐心等待捏...(╹ڡ╹ )"),
          );
        }
      },
      //initialData: _futureBuildFunc,
    );
  }

  // Widget _buildProgressIndicator() {
  //   return const Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Center(child: CircularProgressIndicator()),
  //   );
  //}
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
