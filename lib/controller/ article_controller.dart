import 'dart:convert';

import 'package:firstapp/bloc/api_constants.dart';
import 'package:firstapp/bloc/network_cubit.dart';
import 'package:firstapp/model/model_aritical.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ArticleContoller {
  NetworkCubit? networkCubit;

  Future<ArticleModel?> getArticle() async {
    Response? response;

    response = await http.get(Uri.parse(APIConstants.ariticalUrl));
    if (response.statusCode == 200) {
      ArticleModel articalModel =
          ArticleModel.fromJson({"data": jsonDecode(response.body)});
      return articalModel;
    } else {}
    return null;
  }
}
