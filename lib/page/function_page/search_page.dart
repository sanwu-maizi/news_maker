import 'package:flutter/material.dart';
import 'package:news_maker/page/list_page/list_page.dart';
import 'package:news_maker/page/navigator_page.dart';
import '../content_page/content_page.dart';
import '../button/scrolltotopbutton.dart';

toSearchPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return SearchPage();
  }));
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            toNavigatorPage(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Clear the list
              setState(() {
                ListPage.history.clear();
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
        title: const Text('历史记录'),
      ),
      body: Stack(
        children: [
          Scrollbar(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: ListPage.history.length,
                itemBuilder: (BuildContext context, int index) {
                  var reversedIndex = ListPage.history.length - index - 1;
                  return ListTile(
                    onTap: () {
                      toContentPage(
                          context, ListPage.history[reversedIndex].link!);
                      if (ListPage.history
                          .contains(ListPage.history[reversedIndex])) {
                        final int existingIndex = ListPage.history
                            .indexOf(ListPage.history[reversedIndex]);
                        ListPage.history.removeAt(existingIndex);
                        ListPage.history.add(ListPage.history[reversedIndex]);
                      } else {
                        setState(() {
                          ListPage.history.add(ListPage.history[reversedIndex]);
                        });
                      }
                    },
                    title: Text(ListPage.history[reversedIndex].title!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ListPage.history[reversedIndex].date!),
                        const Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          ScrollToTopButton(controller: _scrollController, checkToShow: false,),
        ],
      ),
    );
  }
}
