import 'package:dio/dio.dart';

class QueryFileDto {
  int? userId;
  int? page;
  int? pageSize;
  String? fileName;

  QueryFileDto({this.userId, this.page, this.pageSize, this.fileName});

  FormData toFormData() {
    FormData formData = FormData();

    if (userId != null)
      formData.fields.add(MapEntry('userId', userId.toString()));
    if (page != null) formData.fields.add(MapEntry('page', page.toString()));
    if (pageSize != null)
      formData.fields.add(MapEntry('pageSize', pageSize.toString()));
    if (fileName == null) formData.fields.add(const MapEntry('fileName', ""));
    return formData;
  }
}
