part of 'download_file_cubit.dart';

@immutable
abstract class DownloadFileStatus {}
//class DownloadFileInitial extends DownloadFileStatus{}

class DownloadFileLoading extends DownloadFileStatus{}

class DownloadFileCompleted<T> extends DownloadFileStatus{
  final T? responseBody;

  DownloadFileCompleted(this.responseBody);

}

class DownloadFileError extends DownloadFileStatus{
  final String errorMessage;

  DownloadFileError(this.errorMessage);
}


