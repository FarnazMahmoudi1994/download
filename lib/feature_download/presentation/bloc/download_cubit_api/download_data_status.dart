part of 'download_api_cubit.dart';

@immutable
abstract class DownloadDataStatus {}
class DownloadDataInitial extends DownloadDataStatus{}

class DownloadDataLoading extends DownloadDataStatus{}

class DownloadDataCompleted<T> extends DownloadDataStatus{
  final T? responseBody;

  DownloadDataCompleted(this.responseBody);
}

class DownloadDataError extends DownloadDataStatus{
  final String errorMessage;

  DownloadDataError(this.errorMessage);
}
