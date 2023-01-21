import 'dart:convert';
import 'dart:io';


import 'package:equatable/equatable.dart';
import 'package:firstapp/model/error_body.dart';
import 'package:firstapp/resources/string_manager.dart';
import 'package:firstapp/ui/dialogs/dilog_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network_services.dart';

import 'package:http/http.dart' as http;

class NetworkCubit extends Cubit<NetworkState> {
  final NetworkService? networkService;
  final BuildContext context;
  bool isNetworkAvailable = true;
  String customerId = "";

  NetworkCubit({this.networkService, required this.context})
      : super(NetworkInitial()) {}
  bool isDialogShowing = false;
  bool isErrorDialogShowing = false;
  var error = ErrorBody();

  setToken(String token) {
    networkService!.setToken(token);
  }

  Future<http.Response?> networkPutRequest(
      {String? endpoint,
      Map<String, dynamic>? body,
      bool? isformdata,
      isLoader = false}) async {
    try {
      http.Response? response;
      response = await networkService!.put(endpoint!, body);
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
    }
    return null;
  }

  Future<http.Response?> networkPostRequest(
      {String? endpoint,
      Map<String, dynamic>? body,
      bool? isformdata,
      bool isLoader = false}) async {
    try {
      http.Response? response;
      response = await networkService!.post(
        endpoint!,
        body,
        isformdata!,
      );
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    }
    return null;
  }

  Future<http.Response?> networkPostWithFormRequest(
      {String? endpoint,
      Map<String, String>? body,
      bool? isformdata,
      bool isLoader = false}) async {
    try {
      http.Response? response;
      response = await networkService!.postWithForm(
        endpoint!,
        body,
        isformdata!,
      );
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    }
    return null;
  }

  Future<http.Response?> networkPatchRequest(
      {String? endpoint,
      Map<String, dynamic>? body,
      bool? isformdata,
      bool isLoader = false}) async {
    try {
      http.Response? response;
      response = await networkService!.patch(
        endpoint!,
        body,
        isformdata!,
      );
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    }
    return null;
  }

  Future<http.Response?> networkGetRequest(
    String endpoint,
    Map<String, String>? body,
  ) async {
    try {
      http.Response? response;
      response = await networkService!.get(
        endpoint,
        body,
      );
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    }
    return null;
  }

  Future<http.Response?> networkDeleteRequest(
      String endpoint, Map<String, String>? body, bool isformdata) async {
    try {
      http.Response? response;
      response = await networkService!.delete(
        endpoint,
        body!,
      );
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    }
    return null;
  }

  Future<http.Response?> networkDeleteRequestWithBody(
      String endpoint, Map<String, dynamic>? body, bool isformdata) async {
    try {
      http.Response? response;
      response = await networkService!.deleteWithBody(
        endpoint,
        body!,
      );
      return response;
    } on SocketException {
      error = ErrorBody(message: StringManager.internetConnectionError);
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    } catch (e) {
      var error = ErrorBody(message: e.toString());
      emit(ErrorState(errorBody: error));
      emit(NetworkInitial());
    }
    return null;
  }

  showLoader(BuildContext context) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return const CircularProgressIndicator();
          }).then((value) {
        isDialogShowing = false;
      });
    }
  }

  hideLoader(BuildContext context) {
    if (isDialogShowing) {
      Navigator.pop(context);
    }
  }

  void showApiErrorDialog(BuildContext context, String message, String heading,
      Function callback) async {
    if (!isErrorDialogShowing) {
      isErrorDialogShowing = true;
      if (!message.contains("Incorrect password")) {
        await showDialog(
            context: context,
            barrierLabel: "Error",
            builder: (BuildContext context) {
              return AlertErrorMessage(
                descriptions: message,
                title: heading,
              );
            });
        callback();
        isErrorDialogShowing = false;
      }
    }
  }

  emitState(ErrorBody error) {
    emit(ErrorState(errorBody: error));
  }

  dispose() {}
}

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {}

class AuthTokenIssue extends NetworkState {
  final ErrorBody errorBody;

  AuthTokenIssue({required this.errorBody});
}

class ApiCalling extends NetworkState {}

class ApiCallDone extends NetworkState {}

class ErrorState extends NetworkState {
  final ErrorBody errorBody;

  ErrorState({required this.errorBody});
}

class SyncErrorState extends NetworkState {
  final ErrorBody errorBody;

  SyncErrorState({required this.errorBody});
}
