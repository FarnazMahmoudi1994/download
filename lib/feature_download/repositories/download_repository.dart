import 'dart:io';


class DownloadRepository{

  Future<bool> checkConnectivity() async{

    try{
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_){
      return false;
    }
  }



}