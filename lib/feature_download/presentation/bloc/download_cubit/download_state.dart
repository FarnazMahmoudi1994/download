part of 'download_cubit.dart';

class DownloadState {
  ConnectionStatus connectionStatus;

  DownloadState({required this.connectionStatus});

  DownloadState copyWith({
  ConnectionStatus? newConnectionStatus,
}){
    return DownloadState(
        connectionStatus: newConnectionStatus ?? connectionStatus
    );
  }
}

