

import 'package:download/common/utils/prefs_operator.dart';
import 'package:download/feature_download/data/data_source/update_api_provider.dart';
import 'package:download/feature_download/repositories/download_api_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async{

  SharedPreferences sharedPreferences1 = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences1);
  locator.registerSingleton<PrefsOperator>(PrefsOperator());
  //apiProvider
  locator.registerSingleton<UpdateApiProvider>(UpdateApiProvider());
  //repository
  locator.registerSingleton<DownloadApiRepository>(DownloadApiRepository(locator()));

 /* //apiProvider
  locator.registerSingleton<UpdateFileProvider>(UpdateFileProvider());
  //repository
  locator.registerSingleton<DownloadFileRepository>(DownloadFileRepository(locator()));*/
}