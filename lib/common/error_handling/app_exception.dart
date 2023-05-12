import 'package:http/http.dart' as http;

class AppException implements Exception {
  final message;
  http.Response? response;
  http.StreamedResponse? streamedResponse;

  AppException({required this.message,this.response, this.streamedResponse});

  String getMessage() {
    return "$message";
  }
}

class ServerException extends AppException {
  ServerException({String? message}) : super(message: message ?? "There is a Problem,please try again");
}

class NotFoundException extends AppException {
  NotFoundException({String? message}) : super(message: message ?? "No information found");
}

class DataParsingException extends AppException {
  DataParsingException({String? message}) : super(message: message ?? "Data has Corrupted");
}

class BadRequestException extends AppException {
  BadRequestException({String? message,http.Response? response}) : super(message: message ?? "bad request exception.",response: response);
}

class BadRequestException2 extends AppException {
  BadRequestException2({String? message,http.StreamedResponse? streamedResponse}) : super(message: message ?? "bad request exception.",streamedResponse: streamedResponse);
}

class FetchDataException extends AppException {
  FetchDataException({String? message}) : super(message: message ?? "please check your connection...");
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message}) : super(message: message ?? "token has been expired.");
}

class TimeoutException extends AppException {
  TimeoutException({String? message}) : super(message: message ?? "A timely response was not received from the server");
}