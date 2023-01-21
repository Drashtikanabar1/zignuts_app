
import 'dart:convert';

import 'package:firstapp/bloc/api_constants.dart';
import 'package:firstapp/bloc/network_cubit.dart';
import 'package:firstapp/response/customer_randomuser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class RandomProvider with ChangeNotifier {
  NetworkCubit? networkCubit;

  getRandomuser() async {
    http.Response? response;
    response =  await networkCubit!.networkGetRequest(APIConstants.randomURL ,Map());
       
    
  
    if(response != null && response.statusCode==200){
        ModelCustomrResponse randomuser=ModelCustomrResponse.fromJson(jsonDecode(response.body));

      print(" ans = ${randomuser.results?.first.name?.first ?? ''}");
      return randomuser;
    }else{
    print("error = ${response!.reasonPhrase}");
    return response;
    }
    
  }
}
