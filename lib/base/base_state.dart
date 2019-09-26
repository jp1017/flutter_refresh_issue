import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_refresh_issue/base/base_theme.dart';
import 'package:flutter_refresh_issue/colors.dart';

// ignore: must_be_immutable
abstract class BaseState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  ThemeData themeData;
  BuildContext baseContext;
  bool isFullPage = false;
  Decoration appBarDecoration;
  String backImgPath;
  Color titleColor;
  bool hasToolBar = true;
  bool canBack = true;

  String actionText; //文本菜单
  VoidCallback actionCall; //文本菜单点击事件

  String errMsg = '';
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    this.baseContext = context;
    return Theme(
      data: themeData ?? whiteTheme,
      child: isFullPage
          ? getFullWidget(context)
          : getContentWidget(context, getTitle(), getWidget(context),
              hasBar: hasToolBar,
              titleColor: titleColor,
              imgPath: backImgPath,
              appBarWidget: getAppBarWidget(context),
              appBarDecoration: appBarDecoration,
              actions: getActions(),
              canBack: canBack),
    );
  }

  void init();

  @override
  bool get wantKeepAlive => keepAlive();

  bool keepAlive() {
    return false;
  }

  String getTitle() {
    return '';
  }

  void refreshUi() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Widget> getActions() {
    return [_getTextAction()];
  }

  //右侧有文本的菜单按钮
  Widget _getTextAction() {
    return (actionText != null && actionCall != null)
        ? InkWell(
            onTap: actionCall,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    actionText,
                    style: TextStyle(color: Colours.dark, fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget getWidget(BuildContext context) {
    return Container();
  }

  Widget getAppBarWidget(BuildContext context) {
    return null;
  }

  Widget getFullWidget(BuildContext context) {
    return Container();
  }
}

Widget getContentWidget(BuildContext context, String title, Widget body,
    {bool hasBar = true,
    Color titleColor,
    String imgPath,
    Widget appBarWidget,
    Decoration appBarDecoration,
    List<Widget> actions,
    bool canBack = true}) {
  return hasBar
      ? Scaffold(
          appBar: appBarDecoration != null
              ? Container(
                  decoration: appBarDecoration,
                  child: getAppBar(context, title,
                      imgPath: imgPath,
                      titleColor: titleColor,
                      appBarWidget: appBarWidget,
                      appBarDecoration: appBarDecoration,
                      actions: actions,
                      canBack: canBack),
                )
              : getAppBar(context, title,
                  imgPath: imgPath,
                  titleColor: titleColor,
                  appBarWidget: appBarWidget,
                  appBarDecoration: appBarDecoration,
                  actions: actions,
                  canBack: canBack),
          body: body,
        )
      : body;
}

Widget getAppBar(BuildContext context, String title,
    {String imgPath,
    Color titleColor,
    Widget appBarWidget,
    Decoration appBarDecoration,
    List<Widget> actions,
    bool canBack = true}) {
  return AppBar(
    backgroundColor:
        appBarDecoration != null ? Colors.transparent : Colours.white,
    titleSpacing: 0,
    title: appBarWidget ??
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              color: titleColor ?? Colours.dark1,
              fontWeight: FontWeight.w600),
        ),
    centerTitle: true,
    elevation: 0,
    actions: actions,
    automaticallyImplyLeading: !canBack,
    leading: canBack
        ? IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).dispose();
            },
          )
        : null,
  );
}
