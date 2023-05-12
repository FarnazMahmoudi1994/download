

import 'dart:developer';

import 'package:download/common/error_handling/app_exception.dart';
import 'package:download/common/resources/data_state.dart';
import 'package:http/http.dart';


class CheckExceptions {

  static dynamic response(Response response){
    log("ssssssss${response.statusCode}");
    switch (response.statusCode) {
     /* case 200:
        log("200");
        return response;*/
      case 400:
        throw BadRequestException(response: response);
      case 401:
        throw UnauthorisedException();
      case 404:
        throw NotFoundException();
      case 408:
        log("408");
        throw TimeoutException();
      case 500:
        log("500");
        throw ServerException();
      default:
        log("ggggg");
        throw FetchDataException(message: "${response.statusCode}fetch exception");
    }
  }


  static dynamic response2(StreamedResponse streamedResponse){
    log("ssssssss2${streamedResponse.statusCode}");
    switch (streamedResponse.statusCode) {
     /* case 200:
        return streamedResponse;*/
      case 400:
        throw BadRequestException2(streamedResponse: streamedResponse);
      case 401:
        throw UnauthorisedException();
      case 404:
        throw NotFoundException();
      case 408:
        throw TimeoutException();
      case 500:
        throw ServerException();
      default:
        throw FetchDataException(message: "${streamedResponse.statusCode}fetch exception");
    }
  }

  static dynamic getError(AppException appException) async {
    switch (appException.runtimeType) {
    /// return error came from server
      case BadRequestException:
        return DataFailed(appException.message);

      case BadRequestException2:
        return DataFailed(appException.message);

      case NotFoundException:
        return DataFailed(appException.message);
    /// get refresh token and call api again
      case UnauthorisedException:
        return DataFailed(appException.message);
    ///timeout error
      case TimeoutException:
        return DataFailed(appException.message);

    /// server error
      case ServerException:
        return DataFailed(appException.message);

    /// dio or timeout and etc error
      case FetchDataException:
        return DataFailed(appException.message);
    }
  }
}