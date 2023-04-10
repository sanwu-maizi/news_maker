import 'package:flutter/material.dart';
import 'package:news_maker/page/content_page/entity.dart';
import 'package:news_maker/page/content_page/model.dart';
import 'package:news_maker/page/content_page/ui/content_image.dart';
import 'package:news_maker/page/content_page/ui/content_pdf.dart';
import 'package:news_maker/page/content_page/ui/content_text.dart';

import '../button/scrolltotopbutton.dart';

//toContentPage(BuildContext context, String link,ValueNotifier<Color> appBarColor) {
toContentPage(BuildContext context, String link) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return ContentPage(
      link: link,
      //appBarColor:appBarColor
    );
  }));
}

class ContentPage extends StatefulWidget {
  final String link;
  //final ValueNotifier<Color> appBarColor;

  //const ContentPage({Key? key, required this.link,required this.appBarColor}) : super(key: key);
  const ContentPage({Key? key, required this.link}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final NewsContentModel _model = NewsContentModel();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsContentEntity?>(
        builder:
            (BuildContext context, AsyncSnapshot<NewsContentEntity?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.title!),
              ),
              body: Stack(
                children: [
                  Scrollbar(
                    child: ListView.builder(
                      itemCount: snapshot.data!.contents!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Widget item = Container();
                        var content = snapshot.data!.contents![index];
                        switch (content.type) {
                          case "text":
                            item = ContentText(text: content.content!);
                            break;
                          case "pdf":
                            item = ContentPDF(url: content.content!);
                            break;
                          case "image":
                            item = ContentImage(url: content.content!);
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                          child: item,
                        );
                      },
                    ),
                  ),
                  ScrollToTopButton(
                    controller: _scrollController,
                    checkToShow: true,
                  ),
                  // FavButton(controller: _scrollController,be_liked: (ContentPage.favourite
                  //     .contains(_list![index])), , ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text("请耐心等待捏...(╹ڡ╹ )"),
              ),
            );
          }
        },
        future: _model.getData(link: widget.link));
  }
}
