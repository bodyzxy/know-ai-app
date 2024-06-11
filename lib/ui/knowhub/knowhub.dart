import 'package:dio/src/form_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/api/file.dart';
import 'package:know_ai_app/component/button_widget.dart';
import 'package:know_ai_app/config/request.dart';
import 'package:know_ai_app/model/dto/query_file_dto.dart';
import 'package:know_ai_app/storage/token_storage.dart';

class KnowHubPage extends StatefulWidget {
  const KnowHubPage({super.key});

  @override
  State<StatefulWidget> createState() => _KnowHubPageState();
}

class _KnowHubPageState extends State<KnowHubPage> {
  final List<dynamic> _list = [];
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();
  var tokenStorage = TokenStorage();
  QueryFileDto queryFileDto =
      QueryFileDto(userId: 1, page: 0, pageSize: 4, fileName: "");

  @override
  void initState() {
    super.initState();

    _getData();

    //监听滚动事件
    _scrollController.addListener(() {
      print(_scrollController.position.pixels); //获取滚动条下拉的距离

      print(_scrollController.position.maxScrollExtent); //获取整个页面的高度

      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 40) {
        _getData();
      }
    });
  }

  void _getData() async {
    String accessToken = await tokenStorage.getAccessToken();
    var dio = CustomizeDio.instance.getDio(token: accessToken);

    try {
      var rsp = await dio.get('/api/v1/know/contents',
          data: queryFileDto.toFormData());
      print("================${rsp.data['data']['content']}");
      if (rsp.data['code'] == 0 && rsp.data['data']['content'] != null) {
        setState(() {
          _list.addAll(rsp.data['data']['content']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  //下拉刷新
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      print('请求数据完成');
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 70),
              uploadFile(),
              const SizedBox(height: 24),
            ],
          ),
        ),
        Expanded(
          child: _list.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      String fileName = _list[index]['fileName'];
                      if (index == _list.length - 1) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(fileName, maxLines: 1),
                            ),
                            const Divider(),
                            _getMoreWidget()
                          ],
                        );
                      } else {
                        return const Column(
                          children: <Widget>[
                            ListTile(
                              title: Text("无数据", maxLines: 1),
                            ),
                            Divider()
                          ],
                        );
                      }
                    },
                  ),
                )
              : _getMoreWidget(),
        ),
      ],
    ));
  }

  Widget uploadFile() => ButtonWidget(
        text: 'uploadFile'.tr,
        onClicked: () async {
          Map<String, dynamic> data = await FileApi().uploadFile();
          if (data['code'] == 0) {
            Get.defaultDialog(
                title: 'uploadFile'.tr, content: Text('success'.tr));
          }
        },
      );

  //加载中的圈圈
  Widget _getMoreWidget() {
    if (hasMore) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '加载中...',
                style: TextStyle(fontSize: 16.0),
              ),
              CircularProgressIndicator(
                strokeWidth: 1.0,
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text("--我是有底线的--"),
      );
    }
  }
}
