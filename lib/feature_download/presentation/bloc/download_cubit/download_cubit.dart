import 'package:bloc/bloc.dart';
import 'package:download/feature_download/repositories/download_repository.dart';
import 'package:meta/meta.dart';

part 'download_state.dart';

part 'connection_status.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadRepository downloadRepository = DownloadRepository();
  DownloadCubit() : super(
      DownloadState(
          connectionStatus: ConnectionInitial())
  );

  Future<void> checkConnectionEvent() async{
    emit(state.copyWith(newConnectionStatus: ConnectionInitial()));
    bool isConnect = await downloadRepository.checkConnectivity();
    if(isConnect){
      emit(state.copyWith(newConnectionStatus: ConnectionOn()));
    }else{
      emit(state.copyWith(newConnectionStatus: ConnectionOff()));
    }
  }
}
