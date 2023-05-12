import 'dart:developer';


import 'package:download/common/error_handling/check_exceptions.dart';
import 'package:download/constant.dart';
import 'package:http/http.dart' as http;

class UpdateApiProvider{

  dynamic callUpdateDataSize() async{

    final response =  await http.get(Uri.parse("${Constant.baseUrl}/get-all-file-sizes"))/*.timeout(
        const Duration(seconds: 2),onTimeout: (){
      return http.Response('Error', 408);
    })*/;


    if(response.statusCode == 200){

      return response;
    }else{
      await CheckExceptions.response(response);
    }

   /* var response1 = CheckExceptions.response(response);
    return response1;*/

  }

  dynamic callUpdateDataTitle() async{

    final response =  await http.get(Uri.parse("${Constant.baseUrl}/get-all-filenames"))/*.timeout(
        const Duration(seconds: 2),onTimeout: (){
      return http.Response('Error', 408);
    })*/;

    if(response.statusCode == 200){

      return response;
    }else{
      await CheckExceptions.response(response);
    }

    /*var response1 = CheckExceptions.response(response);
    return response1;*/
  }


  dynamic callDownload(String fileName) async{


    final client = http.Client();
    final request = http.Request('GET', Uri.parse("${Constant.baseUrl}/download?file=$fileName.zipp"));

    //final response = client.send(request).timeout( const Duration(seconds: 8),).then((value) => client.close());
   // Stream<List<int>>? s;
    final response = client.send(request)/*.timeout(
        const Duration(seconds: 4),onTimeout: (){
      return http.StreamedResponse(s!,408);
    })*/;
    var res = await Future.value(response);
    if(res.statusCode== 200){

      return response;
    }else{
      await CheckExceptions.response2(await response);
    }
   /* var response1 = CheckExceptions.response2(await response);

    return response1;*/
  }

}