part of 'download_api_cubit.dart';


class DownloadApiState {
  DownloadDataStatus downloadDataStatus;

  DownloadApiState({required this.downloadDataStatus});
  DownloadApiState copyWith({
  DownloadDataStatus? newDownloadDataStatus,
}){
    return DownloadApiState(
        downloadDataStatus: newDownloadDataStatus ?? downloadDataStatus
    );
  }
}

