import 'dart:async';

import 'package:download/common/error_handling/app_exception.dart';
import 'package:download/common/error_handling/check_exceptions.dart';
import 'package:download/common/resources/data_state.dart';
import 'package:download/feature_download/data/data_source/update_api_provider.dart';
import 'package:http/http.dart' as http;

class DownloadApiRepository{
  UpdateApiProvider apiProvider;

  DownloadApiRepository(this.apiProvider);

  Future<DataState<dynamic>> fetchUpdateDataSize() async {
    try{
      http.Response response = await apiProvider.callUpdateDataSize();
      var responseBody = response.body;
      print("farnaaaazi");
      return DataSuccess(responseBody);
    } on AppException catch(e){
      print("mahnaaaazi");
      return await CheckExceptions.getError(e);
    }
  }


  Future<DataState<dynamic>> fetchUpdateDataTitle() async {

    try{
      http.Response response = await apiProvider.callUpdateDataTitle();
      var responseBody = response.body;
      return DataSuccess(responseBody);
    } on AppException catch(e){
      return await CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> fetchDownload(String fileName) async {



    try{
      http.StreamedResponse response = await apiProvider.callDownload(fileName) ;
      var responseBody = response;
      print("repository");
      return DataSuccess(responseBody);
    } on AppException catch(e){
      return await CheckExceptions.getError(e);
    }

  }

}

