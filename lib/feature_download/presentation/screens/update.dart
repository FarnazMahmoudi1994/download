import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:archive/archive.dart';
import 'package:download/components/theme_model.dart';
import 'package:download/constants.dart';
import 'package:download/feature_download/presentation/bloc/download_cubit/download_cubit.dart';
import 'package:download/feature_download/presentation/bloc/download_cubit_api/download_api_cubit.dart';
import 'package:download/feature_download/presentation/bloc/download_file_cubit/download_file_cubit.dart';
import 'package:download/locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class Update extends StatefulWidget {


  Update();

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late var sizePdfs;
  late String sizePdfs2;
  late List<DownloadController> _downloadControllers;
  late ScrollController scrollController;

  @override
  void initState() {
    sizePdfs = "";
    sizePdfs2 = "";
    scrollController = ScrollController();
    () async {
      await BlocProvider.of<DownloadCubit>(context).checkConnectionEvent();
      await BlocProvider.of<DownloadApiCubit>(context)
          .callDownloadDataTitleEvent();

      if (!mounted) return;
      setState(() {});
    }();

    if (!mounted) return;
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription!.cancel();
      subscription = null;
    }
    partCount = 0;
    super.dispose();
  }

  Future<List<String>> getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("downloadedCheck") ??
        List.generate(partCount, (index) => "0");
  }

  Future<void> downloadCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    partDownloadCheck = await getSharedPreferences();
    for (var k = 0; k < partCount; k++) {
      dirChecker(await initDestinationPathDownload(), "");
      Directory directory = Directory(
          '${await initDestinationPathDownload()}/${partDownload[k]}');
      if (!directory.existsSync()) {
        partDownloadCheck[k] = "0";
        prefs.setStringList("downloadedCheck", partDownloadCheck);

        print("forrrr${k}=${partDownloadCheck[k]}");
      }
    }
    partDownloadCheck = await getSharedPreferences();
  }

  void dirChecker(String destination, String dir) async {
    if (!Directory(destination).existsSync()) {
      new Directory(destination)
          .create(recursive: true)
          // The created directory is returned as a Future.
          .then((Directory directory) {});
    }
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 Bytes';

    const k = 1024;
    var dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    var i = (log(bytes) / log(k)).floor();

    return ((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (subscription != null) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Do you want to cancel downloading?")),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 5.0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        subscription?.cancel();
                        subscription = null;
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 5.0,
                      ),
                    )
                  ],
                );
              }).then((value) {});
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: green20,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text(
              "Download",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  if (subscription != null) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: FittedBox(
                                fit: BoxFit.contain,
                                child:
                                    Text("Do you want to cancel downloading?")),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.white,
                                  elevation: 5.0,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  subscription?.cancel();
                                  subscription = null;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.white,
                                  elevation: 5.0,
                                ),
                              )
                            ],
                          );
                        }).then((value) {});
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
          body: Container(
              color: themeNotifier.isDark ? Grey3dark : Colors.white,
              width: width,
              height: height,
              child: BlocBuilder<DownloadCubit, DownloadState>(
                  bloc: BlocProvider.of<DownloadCubit>(context),
                  builder: (context, state) {
                    if (state.connectionStatus is ConnectionInitial) {
                      return Center(
                          child: SpinKitFadingCircle(
                        color: green20,
                        size: width * 0.1,
                      ));
                    }
                    if (state.connectionStatus is ConnectionOn) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.8,
                            height: height * 0.3,
                            child: Center(
                              child: Text(
                                "Sections have been prepared for download, which will be added to the relevant sections on the main page after downloading each section and will only be available in the application.",
                                style: TextStyle(
                                    color: themeNotifier.isDark
                                        ? Colors.white
                                        : Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    height: 1.6),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          BlocBuilder<DownloadApiCubit, DownloadApiState>(
                            bloc: BlocProvider.of<DownloadApiCubit>(context),
                            buildWhen: (previous, current) {
                              if (previous.downloadDataStatus ==
                                  current.downloadDataStatus) {
                                return false;
                              }

                              return true;
                            },
                            builder: (context, state) {
                              if (state.downloadDataStatus
                                  is DownloadDataLoading) {
                                return LoadingAnimationWidget.prograssiveDots(
                                    color: themeNotifier.isDark
                                        ? orange9
                                        : green40,
                                    size: MediaQuery.of(context).size.height *
                                        0.06);
                              }
                              if (state.downloadDataStatus
                                  is DownloadDataCompleted) {
                                DownloadDataCompleted downloadDataCompleted =
                                    state.downloadDataStatus
                                        as DownloadDataCompleted;
                                var responseBody =
                                    downloadDataCompleted.responseBody;
                                var list = responseBody.toString().substring(
                                    1, responseBody.toString().length - 1);

                                var list2 = list.replaceAll("\"", "");
                                var list3 =
                                    list2.toLowerCase().replaceAll(".zip", "");
                                List<String> part = list3.split(",");
                                partCount = part.length;

                                _downloadControllers =
                                    List<DownloadController>.generate(
                                  partCount,
                                  (index) => SimulatedDownloadController(
                                      context: context,
                                      index: index,
                                      sizePdfList: sizePdfList),
                                );

                                () async {
                                  await downloadCheck();
                                }();

                                print("pppppppart${partCount}");

                                return RawScrollbar(
                                  thumbColor: themeNotifier.isDark
                                      ? white1
                                      : Colors.black12,
                                  thickness: 1,
                                  controller: scrollController,
                                  radius: Radius.circular(20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: scrollController,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.03,
                                          vertical: height * 0.03),
                                      child: Wrap(
                                        spacing: width * 0.05,
                                        children: [
                                          for (var index = 0;
                                              index < partDownload.length;
                                              index++)
                                            _buildListItem(context, index,
                                                themeNotifier)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (state.downloadDataStatus
                                  is DownloadDataError) {
                                DownloadDataError downloadDataError = state
                                    .downloadDataStatus as DownloadDataError;
                                var errorMessage =
                                    downloadDataError.errorMessage;

                                return Text(errorMessage);
                              }
                              return Text("");
                            },
                          ),
                          Image.asset(
                            "assets/images/downloading.png",
                            width: width,
                            height: height * 0.25,
                          ),
                        ],
                      );
                    }
                    if (state.connectionStatus is ConnectionOff) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Image.asset(
                              'assets/images/nointenet.png',
                              width: MediaQuery.of(context).size.width,
                            )),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<DownloadCubit>(context)
                                    .checkConnectionEvent();
                              },
                              child: FittedBox(
                                  child: Text(
                                "Try again",
                                style: TextStyle(
                                    color: blue20, fontWeight: FontWeight.bold),
                              )),
                              style: ElevatedButton.styleFrom(
                                primary: orange5,
                                onPrimary: orange5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                    color: orange5,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  })),
        );
      }),
    );
  }

  Widget _buildListItem(
      BuildContext context, int index, ThemeModel themeNotifier) {
    final downloadController = _downloadControllers[index];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.3,
      height: width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: index % 2 == 0
              ? themeNotifier.isDark
                  ? green39
                  : green39
              : themeNotifier.isDark
                  ? orange8
                  : orange8,
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3))
          ]),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocProvider(
            create: (context) =>
                DownloadApiCubit(locator())..callDownloadDataTitleEvent(),
            child: Builder(builder: (context) {
              return BlocBuilder<DownloadApiCubit, DownloadApiState>(
                buildWhen: (previous, current) {
                  if (previous.downloadDataStatus ==
                      current.downloadDataStatus) {
                    return false;
                  }

                  return true;
                },
                builder: (context, state) {
                  if (state.downloadDataStatus is DownloadDataLoading) {
                    return SpinKitThreeBounce(
                      color: index % 2 == 0
                          ? themeNotifier.isDark
                              ? green40
                              : orange9
                          : themeNotifier.isDark
                              ? orange9
                              : green40,
                      size: MediaQuery.of(context).size.height * 0.02,
                    );
                  }
                  if (state.downloadDataStatus is DownloadDataCompleted) {
                    DownloadDataCompleted downloadDataCompleted =
                        state.downloadDataStatus as DownloadDataCompleted;
                    var responseBody = downloadDataCompleted.responseBody;
                    var list = responseBody
                        .toString()
                        .substring(1, responseBody.toString().length - 1);

                    var list2 = list.replaceAll("\"", "");
                    var list3 = list2.toLowerCase().replaceAll(".zip", "");
                    partDownload = list3.split(",");

                    return Text(
                      partDownload[index] ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 720 ? 22 : 14,
                        fontWeight: FontWeight.bold,
                        color: themeNotifier.isDark
                            ? Colors.black87
                            : Colors.black,
                      ),
                    );
                  }

                  if (state.downloadDataStatus is DownloadDataError) {
                    return Text("try again!!!!!!");
                  }
                  return Text("");
                },
              );
            }),
          ),
          BlocProvider(
            create: (context) =>
                DownloadApiCubit(locator())..callDownloadDataSizeEvent(),
            child: Builder(builder: (context) {
              return BlocBuilder<DownloadApiCubit, DownloadApiState>(
                buildWhen: (previous, current) {
                  if (previous.downloadDataStatus ==
                      current.downloadDataStatus) {
                    return false;
                  }

                  return true;
                },
                builder: (context, state) {
                  if (state.downloadDataStatus is DownloadDataLoading) {
                    return SpinKitThreeBounce(
                      color: index % 2 == 0
                          ? themeNotifier.isDark
                              ? green40
                              : orange9
                          : themeNotifier.isDark
                              ? orange9
                              : green40,
                      size: MediaQuery.of(context).size.height * 0.02,
                    );
                  }
                  if (state.downloadDataStatus is DownloadDataCompleted) {
                    DownloadDataCompleted downloadDataCompleted =
                        state.downloadDataStatus as DownloadDataCompleted;
                    var responseBody = downloadDataCompleted.responseBody;
                    var list = responseBody
                        .toString()
                        .substring(1, responseBody.toString().length - 1);
                    sizePdfList = list.split(",");

                    return Text(
                        formatBytes(int.parse(sizePdfList[index]), 2) ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 720 ? 18 : 10,
                          color: themeNotifier.isDark
                              ? Colors.black87
                              : Colors.black,
                        ));
                  }

                  if (state.downloadDataStatus is DownloadDataError) {
                    return Text("try again!!!!!!");
                  }
                  return Text("");
                },
              );
            }),
          ),
          AnimatedBuilder(
            animation: downloadController,
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  downloadController.downloadStatus ==
                          DownloadStatus.notDownloaded
                      ? downloadController.startDownload()
                      : downloadController.downloadStatus ==
                              DownloadStatus.downloading
                          ? downloadController.stopDownload()
                          : downloadController.downloadStatus ==
                                  DownloadStatus.stopDownload
                              ? downloadController.playDownload()
                              : null;
                },
                child: Stack(
                  children: [
                    downloadController.downloadStatus ==
                                DownloadStatus.downloaded ||
                            partDownloadCheck[index] == "1"
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.download_done_outlined,
                              color: index % 2 == 0
                                  ? themeNotifier.isDark
                                      ? orange5
                                      : green40
                                  : themeNotifier.isDark
                                      ? green40
                                      : orange5,
                            ),
                          )
                        : AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                            decoration: downloadController.downloadStatus ==
                                        DownloadStatus.downloading ||
                                    downloadController.downloadStatus ==
                                        DownloadStatus.fetchingDownload ||
                                    downloadController.downloadStatus ==
                                        DownloadStatus.stopDownload
                                ? ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: Colors.white.withOpacity(0),
                                  )
                                : ShapeDecoration(
                                    shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05))) /*StadiumBorder()*/,
                                    color: index % 2 == 0
                                        ? themeNotifier.isDark
                                            ? orange9
                                            : green40
                                        : themeNotifier.isDark
                                            ? green40
                                            : orange9),
                            width: MediaQuery.of(context).size.width > 720
                                ? MediaQuery.of(context).size.width * 0.22
                                : MediaQuery.of(context).size.width * 0.26,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.02,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.04),
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: downloadController.downloadStatus ==
                                            DownloadStatus.downloading ||
                                        downloadController.downloadStatus ==
                                            DownloadStatus.fetchingDownload ||
                                        downloadController.downloadStatus ==
                                            DownloadStatus.stopDownload
                                    ? 0.0
                                    : 1.0,
                                curve: Curves.ease,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Download',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(
                                            //fontWeight: FontWeight.bold,
                                            color: index % 2 == 0
                                                ? themeNotifier.isDark
                                                    ? Colors.black
                                                    : Colors.white
                                                : themeNotifier.isDark
                                                    ? white1
                                                    : Colors.black,
                                            fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Positioned.fill(
                      child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: downloadController.downloadStatus ==
                                      DownloadStatus.downloading ||
                                  downloadController.downloadStatus ==
                                      DownloadStatus.fetchingDownload ||
                                  downloadController.downloadStatus ==
                                      DownloadStatus.stopDownload
                              ? 1.0
                              : 0.0,
                          curve: Curves.ease,
                          child: BlocConsumer<DownloadFileCubit,
                              DownloadFileState>(
                            buildWhen: (previous, current) {
                              if (previous.downloadFileStatus ==
                                  current.downloadFileStatus) {
                                return false;
                              }

                              return true;
                            },
                            listener: (context, state) {
                              if (state.downloadFileStatus
                                  is DownloadFileError) {
                                DownloadFileError downloadFileError = state
                                    .downloadFileStatus as DownloadFileError;
                                var errorMessage =
                                    downloadFileError.errorMessage;
                                //showToast(errorMessage);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state.downloadFileStatus
                                  is DownloadFileLoading) {
                                return SpinKitCircle(
                                  color: index % 2 == 0
                                      ? themeNotifier.isDark
                                          ? green40
                                          : orange9
                                      : themeNotifier.isDark
                                          ? orange9
                                          : green40,
                                  size:
                                      MediaQuery.of(context).size.height * 0.02,
                                );
                              } else if (state.downloadFileStatus
                                  is DownloadFileCompleted) {
                                DownloadFileCompleted downloadFileCompleted =
                                    state.downloadFileStatus
                                        as DownloadFileCompleted;
                                responseBody = Future.value(
                                    downloadFileCompleted.responseBody);

                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    FittedBox(
                                      child: CircularPercentIndicator(
                                        radius: 15.0,
                                        lineWidth: 3.0,
                                        percent: dlProgress / 100,
                                        //center: Text("$dlProgress%",style: TextStyle(fontSize: 12, color: Colors.blue),),
                                        progressColor: index % 2 == 0
                                            ? themeNotifier.isDark
                                                ? orange5
                                                : green40
                                            : themeNotifier.isDark
                                                ? green40
                                                : orange5,
                                      ),
                                    ),
                                    if (downloadController.downloadStatus ==
                                        DownloadStatus.downloading)
                                      Icon(
                                        Icons.stop,
                                        size: 14,
                                        color: index % 2 == 0
                                            ? themeNotifier.isDark
                                                ? orange5
                                                : green40
                                            : themeNotifier.isDark
                                                ? green40
                                                : orange5,
                                      ),
                                    if (downloadController.downloadStatus ==
                                        DownloadStatus.stopDownload)
                                      Icon(
                                        Icons.play_arrow,
                                        size: 14,
                                        color: index % 2 == 0
                                            ? themeNotifier.isDark
                                                ? orange5
                                                : green40
                                            : themeNotifier.isDark
                                                ? green40
                                                : orange5,
                                      ),
                                  ],
                                );
                              } else if (state.downloadFileStatus
                                  is DownloadFileError) {
                                DownloadFileError downloadFileError = state
                                    .downloadFileStatus as DownloadFileError;
                                var errorMessage =
                                    downloadFileError.errorMessage;
                                return Text(errorMessage);
                              } else {
                                return Text("");
                              }
                            },
                          )
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }

  Future showToast(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      fontSize: 12,
      backgroundColor: grey15,
      textColor: Colors.white,
    );
  }
}

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  stopDownload,
  downloaded,
}

abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get downloadStatus;

  //double get progress;

  void startDownload();

  void stopDownload();

  void playDownload();
}

class SimulatedDownloadController extends DownloadController
    with ChangeNotifier {
  SimulatedDownloadController({
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    required BuildContext context,
    required int index,
    required List<String> sizePdfList,
  })  : _downloadStatus = downloadStatus,
        _context = context,
        _index = index,
        _sizePdfList = sizePdfList;

  DownloadStatus _downloadStatus;
  bool downloading = false;

  int contentLength = 0;
  int downloadedBytes = 0;
  int sumDownloadedBytes = 0;
  Uint8List? uint8list;
  late String namePdfs = "";
  late String namePdfs2 = "";
  late String namePdfs3 = "";
  late List<String> namePdfList = [];
  late List<String> pdfList = [];
  late List<String> sectionList = [];
  String section = "";

  @override
  DownloadStatus get downloadStatus => _downloadStatus;


  final BuildContext _context;
  final int _index;
  late List<String> _sizePdfList;

  bool _isDownloading = false;

  @override
  void startDownload() async {
    if (downloadStatus == DownloadStatus.notDownloaded) {
      // await _context.read<DownloadFileCubit>().callDownloadEvent(partDownload[_index]);

      await BlocProvider.of<DownloadFileCubit>(_context)
          .callDownloadEvent(partDownload[_index]);
      await _doSimulatedDownload();
    }
  }

  @override
  void stopDownload() {
    if (downloadStatus == DownloadStatus.downloading) {
      _isDownloading = false;
      _downloadStatus = DownloadStatus.stopDownload;
      subscription?.pause();
      notifyListeners();
    }
  }

  @override
  void playDownload() {
    if (downloadStatus == DownloadStatus.stopDownload) {
      _isDownloading = true;
      _downloadStatus = DownloadStatus.downloading;
      subscription?.resume();
      notifyListeners();
    }
  }


  Future showToast(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      fontSize: 12,
      backgroundColor: grey15,
      textColor: Colors.white,
    );
  }



  Future<String> getAllPdfsFromMinio() async {
    var responseBody = "";
    try {
      String url = 'http://185.7.212.163:8080/get-all-filenames';
      var response = await http.get(Uri.parse(url), headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        responseBody = response.body;
        print("responseBody+$responseBody");
        return responseBody;
      } else {
        print("statusallminio${response.statusCode}");

        return responseBody;
      }
    } on SocketException {
      showToast("Connection Error!");
    } on HttpException {
      print("Could not find the post");
    } on FormatException {
      print("bad response format verify");
    }
    return responseBody;
  }

  Future<String> getSizeFromMinio(String name) async {
    var responseBody = "";
    try {
      String url = 'http://185.7.212.163:8080/get-file-size/$name';
      var response = await http.get(Uri.parse(url), headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        responseBody = response.body;
        print("responseBody+eeeeeeeeyyyyyyyyyyyyyyyy$responseBody");
        return responseBody;
      } else {
        print("size:${response.statusCode}");

        return responseBody;
      }
    } on SocketException {
      showToast("Connection Error!");
    } on HttpException {
      print("Could not find the post");
    } on FormatException {
      print("bad response format verify");
    }
    return responseBody;
  }

  void dirChecker(String destination, String dir) async {
    if (!Directory(destination).existsSync()) {
      new Directory(destination)
          .create(recursive: true)
          // The created directory is returned as a Future.
          .then((Directory directory) {});
    }
  }

  Future<List<String>> getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("downloadedCheck") ??
        List.generate(partCount, (index) => "0");
  }

  Future<void> _doSimulatedDownload() async {
    print("dowbbbbbbb$downloadedBytes");

    dirChecker(await initDestinationPathDownload(), "");
    Directory directory = Directory(
        '${await initDestinationPathDownload()}/${partDownload[_index]}');

    if (!directory.existsSync()) {
      try {
        _isDownloading = true;
        print("isdown$_isDownloading");
        _downloadStatus = DownloadStatus.fetchingDownload;
        notifyListeners();

        if (!_isDownloading) {
          return;
        }

        // Shift to the downloading phase.
        _downloadStatus = DownloadStatus.downloading;
        notifyListeners();

        print("fffres$responseBody");

        if (responseBody != null) {
          final bytes = await HttpDownloader.download(
            _index,
            (length, downloaded, progress) {
              contentLength = length;
              downloadedBytes = downloaded;
              dlProgress = progress;
              notifyListeners();
            },
          );
          sumDownloadedBytes += downloadedBytes;
          uint8list = bytes;

          print("dlprogress$dlProgress");
          if (sizePdfList[_index] == sumDownloadedBytes.toString()) {
            _downloadStatus = DownloadStatus.downloaded;
            _isDownloading = false;
            notifyListeners();
            print("saaaaaaalaaaaaad$_downloadStatus");
            File file = await File(
                    '${await initDestinationPathDownload()}/${partDownload[_index]}.zip')
                .create(recursive: true);
            var zippedFile = await file.writeAsBytes(bytes);

            if (file.existsSync()) {
              print("zip1");

              await unarchiveAndSave(zippedFile);
              print("zip3");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              partDownloadCheck = await getSharedPreferences();
              partDownloadCheck[_index] = "1";
              notifyListeners();
              prefs.setStringList("downloadedCheck", partDownloadCheck);

              print("_partdownloadd$partDownloadCheck");

              zippedFile.deleteSync(recursive: true);
              Directory directory = Directory(
                  '${await initDestinationPathDownload()}/${partDownload[_index]}');
              if (!directory.existsSync()) {
                directory.create(recursive: true);
              }
            }
          }
        }
      } on SocketException {
        showToast("Connection Error!");
      } on HttpException {
        print("Could not find the post");
      } /*on FormatException {
          print("bad response format");
        }*/

    } else {
      showToast("file before downloaded");
    }
  }

  Future<void> unarchiveAndSave(var zippedFile) async {
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = '${await initDestinationPathDownload()}/${file.name}';
      print("fileName ${fileName}");
      if (file.isFile && !fileName.contains("__MACOSX")) {
        var outFile = File(fileName);
        outFile = await outFile.create(recursive: true);
        var zippedFile2 = await outFile.writeAsBytes(file.content);

        if (file.name.toLowerCase().endsWith(".zip")) {
          section = file.name.toLowerCase().replaceAll(".zip", "");
          if (zippedFile2.existsSync()) {
            await unarchiveAndSave(zippedFile2);
            zippedFile2.deleteSync(recursive: true);
          }
        }

        if (file.name.toLowerCase().endsWith(".pdf")) {
          var size2 = formatBytes(file.size, 2);

        }
      }
    }
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 Bytes';

    const k = 1024;
    var dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    var i = (log(bytes) / log(k)).floor();

    return ((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i];
  }
}

typedef DownloadProgress = void Function(
    int total, int downloaded, double progress);

//final client = http.Client();
double dlProgress = 0;
late List<String> sizePdfList = List.generate(partCount, (index) => "");
late List<String> partDownload = List.generate(partCount, (index) => "");
late List<String> partDownloadCheck = List.generate(partCount, (index) => "0");
late int partCount = 0;

//DownloadStatus _downloadStatus = DownloadStatus.notDownloaded;
StreamSubscription? subscription;

Future<http.StreamedResponse>? responseBody;

class HttpDownloader {
  static Future showToast(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      fontSize: 12,
      backgroundColor: grey15,
      textColor: Colors.white,
    );
  }

  static Future<Uint8List> download(
      int index, DownloadProgress downloadProgress) async {
    final completer = Completer<Uint8List>();
    try {
      print("sala");
      int downloadedBytes = 0;
      List<List<int>> chunkList = [];

      //_downloadStatus = DownloadStatus.downloading;
      //notifyListeners();

      responseBody!
          .asStream()
          .listen((http.StreamedResponse streamedResponse1) {
        if (streamedResponse1.statusCode >= 200 &&
            streamedResponse1.statusCode < 300) {
          subscription =
              streamedResponse1.stream.asBroadcastStream().listen((chunk) {
            var contentLength = int.parse(sizePdfList[index]);
            print("content::::$contentLength");
            final progress = (downloadedBytes / contentLength) * 100;
            downloadProgress(contentLength, downloadedBytes, progress);
            chunkList.add(chunk);
            downloadedBytes += chunk.length;
            print("dlprogressssssss::::$dlProgress");
          }, onDone: () {
            print("doneeeeeeee");
            final contentLength = int.parse(sizePdfList[index]);
            final progress = (downloadedBytes / contentLength) * 100;

            downloadProgress(contentLength, downloadedBytes, progress);
            int start = 0;
            final bytes = Uint8List(contentLength);
            for (var chunk in chunkList) {
              bytes.setRange(start, start + chunk.length, chunk);
              start += chunk.length;
            }
            print("dlprogressssssss????$dlProgress");
            completer.complete(bytes);
          }, onError: (error) => showToast("message"));
        } else {
          showToast("Try Again!");
        }
      });
    } on SocketException {
      showToast("Connection Error!");
    } on HttpException {
      print("Could not find the post");
    } on FormatException {
      print("bad response format verify");
    }

    return completer.future;
  }
}
