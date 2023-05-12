import 'package:bloc/bloc.dart';
import 'package:download/common/resources/data_state.dart';
import 'package:download/feature_download/repositories/download_api_repository.dart';
import 'package:meta/meta.dart';

part 'download_api_state.dart';
part 'download_data_status.dart';

class DownloadApiCubit extends Cubit<DownloadApiState> {
  DownloadApiRepository downloadApiRepository;
  DownloadApiCubit(this.downloadApiRepository) : super(DownloadApiState(downloadDataStatus: DownloadDataLoading()));


  Future<void> callDownloadDataSizeEvent() async {
    emit(state.copyWith(newDownloadDataStatus: DownloadDataLoading()));
    DataState dataState = await downloadApiRepository.fetchUpdateDataSize();

    if(dataState is DataSuccess){
      emit(state.copyWith(newDownloadDataStatus: DownloadDataCompleted(dataState.data)));
    }

    if(dataState is DataFailed){
      emit(state.copyWith(newDownloadDataStatus: DownloadDataError(dataState.error!)));
    }
  }

  Future<void> callDownloadDataTitleEvent() async {
    emit(state.copyWith(newDownloadDataStatus: DownloadDataLoading()));
    DataState dataState = await downloadApiRepository.fetchUpdateDataTitle();

    if(dataState is DataSuccess){
      emit(state.copyWith(newDownloadDataStatus: DownloadDataCompleted(dataState.data)));
    }

    if(dataState is DataFailed){
      emit(state.copyWith(newDownloadDataStatus: DownloadDataError(dataState.error!)));
    }
  }



}
