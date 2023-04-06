import 'package:flutter/material.dart';
import 'package:news_maker/page/model.dart';
import 'package:news_maker/page/setting_page.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'list_page/list_page.dart';

//Theme.of(context).primaryColor
class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage>
    with SingleTickerProviderStateMixin {
  //,AutomaticKeepAliveClientMixin{
  late final NewsTypeModel _model = NewsTypeModel();
  late final TabController _controller =
      TabController(vsync: this, length: _model.data!.data!.length);
  late final ValueNotifier<Color> _appBarColor =
      ValueNotifier(Theme.of(context).primaryColor);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("矿大新闻"),
              backgroundColor: _appBarColor.value,
              actions: buildActions(),
              bottom: TabBar(
                isScrollable: true,
                controller: _controller,
                tabs: _model.data!.data!
                    .map((e) => Tab(
                          text: e.name,
                        ))
                    .toList(),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('麦子'),
                    accountEmail: Text('abc@qq.com'),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage('images/3.jpg')),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            opacity: 0.7,
                            fit: BoxFit.cover,
                            image: AssetImage('images/backimage1.png'))),
                  ),
                  ListTile(
                    title: Text('用户反馈'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text(
                              '如果对该软件有什么建议和改进，可以添加QQ：’1302140648‘或vx：‘y1302140648’提出',
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  '确定',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    trailing: Icon(Icons.feedback),
                  ),
                  ListTile(
                    title: Text('系统设置'),
                    onTap: () async {
                      //toSettingPage(context);
                      final newColor = await toSettingPage(context);
                    },
                    trailing: Icon(Icons.settings),
                  ),
                  ListTile(
                    title: Text('我要发布'),
                    trailing: Icon(Icons.send),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text('注销'),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: _model.data!.data!
                  .map((e) => ListPage(type: e.type!))
                  .toList(),
            ),
          );
        } else {
          return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('请耐心等待捏...(╹ڡ╹ )'),
              ));
        }
      },
      future: _model.getData(),
    );
  }

  List<Widget> buildActions() {
    return [
      const SizedBox(width: 1),
      Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: "搜索",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            fillColor: Colors.grey[300],
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
      const SizedBox(width: 1),
      PopupMenuButton<String>(
        itemBuilder: _buildItem,
        onSelected: _onSelectItem,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.white,
        ),
        position: PopupMenuPosition.under,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      )
    ];
  }

  List<PopupMenuEntry<String>> _buildItem(BuildContext context) {
    //String play = AppLocalizations.of(context)!.setting;
    return [
      const PopupMenuItem<String>(
        height: 35,
        value: "设置",
        child: Center(
            child: Text(
          "设置",
          style: TextStyle(fontSize: 14),
        )),
      )
    ];
  }

  void _onSelectItem(String value) async {
    if (value == "设置") {
      // navigate to SettingPage and wait for selected color
      final newColor = await Navigator.of(context)
          .push<Color>(Right2LeftRouter(child: const SettingPage()));

      if (newColor != null) {
        // update _appBarColor value
        setState(() {
          _appBarColor.value = newColor;
        });
      }
    }
  }
}

class Right2LeftRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int durationMs;
  final Curve curve;

  Right2LeftRouter(
      {required this.child,
      this.durationMs = 200,
      this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (ctx, a1, a2) => child,
            transitionsBuilder: (ctx, a1, a2, child) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                  child: child,
                ));
}
