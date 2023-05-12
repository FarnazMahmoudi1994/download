part of 'download_file_cubit.dart';

class DownloadFileState {


  DownloadFileStatus downloadFileStatus;

  DownloadFileState({required this.downloadFileStatus});
  DownloadFileState copyWith({
    DownloadFileStatus? newDownloadFileStatus,
  }){
    return DownloadFileState(
        downloadFileStatus: newDownloadFileStatus ?? downloadFileStatus
    );
  }
}

