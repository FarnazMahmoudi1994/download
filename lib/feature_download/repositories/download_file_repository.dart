import 'dart:async';

import 'package:download/common/resources/data_state.dart';
import 'package:download/feature_download/data/data_source/update_file_provider.dart';
import 'package:http/http.dart' as http;


class DownloadFileRepository{
  UpdateFileProvider fileProvider;

  DownloadFileRepository(this.fileProvider);


  Future<DataState<http.StreamedResponse>> fetchDownload(String fileName) async {



    try{
      http.StreamedResponse response = await fileProvider.callDownload(fileName) ;
      if(response.statusCode == 200){
        //final HomeModel homeModel = HomeModel.fromJson(response.data);
        var responseBody = response;
        print("repository");
        return DataSuccess(responseBody);
      }else{
        return const DataFailed("error");
      }
    }catch(e){
      return const DataFailed("server error");
    }

  }


}

