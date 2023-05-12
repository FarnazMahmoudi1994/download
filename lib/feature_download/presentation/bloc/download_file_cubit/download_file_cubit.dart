import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:download/common/resources/data_state.dart';
import 'package:download/feature_download/repositories/download_api_repository.dart';
import 'package:meta/meta.dart';

part 'download_file_state.dart';
part 'download_file_status.dart';

class DownloadFileCubit extends Cubit<DownloadFileState> {
  DownloadApiRepository downloadFileRepository;
  DownloadFileCubit(this.downloadFileRepository) : super(DownloadFileState(downloadFileStatus: DownloadFileLoading()));

  Future<void> callDownloadEvent(String fileName) async {
    log("in the name of god");
    emit(state.copyWith(newDownloadFileStatus: DownloadFileLoading()));
    DataState dataState = await downloadFileRepository.fetchDownload(fileName);

    if(dataState is DataSuccess){
      emit(state.copyWith(newDownloadFileStatus: DownloadFileCompleted(dataState.data)));
    }

    if(dataState is DataFailed){
      emit(state.copyWith(newDownloadFileStatus: DownloadFileError(dataState.error!)));
    }
  }
}
