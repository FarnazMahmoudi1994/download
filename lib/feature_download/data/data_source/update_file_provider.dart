import 'dart:developer';

import 'package:download/constant.dart';
import 'package:http/http.dart' as http;

class UpdateFileProvider{


  dynamic callDownload(String fileName) async{
    final client = http.Client();
    final request = http.Request('GET', Uri.parse("${Constant.baseUrl}/download?file=$fileName.zip"));

      final response = client.send(request);
   // final response =  await http.get(Uri.parse("${Constant.baseUrl}/download?file=$fileName.zip"));

    log(response.toString());
      return response;
  }

}