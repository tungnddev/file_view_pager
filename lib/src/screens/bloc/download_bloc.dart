import 'dart:async';

import 'package:flutter_download_file/flutter_download_file.dart';

import '../../models/fvp_param.dart';
import 'download_state.dart';
import '../../extensions.dart';

class DownloadBloc {
  FVPParam initDataViewAttachments;

  DownloadBloc({required this.initDataViewAttachments}) {
    currentPosition = initDataViewAttachments.initPosition;
  }


  int currentPosition = 0;

  final _changePageStreamController = StreamController<int>.broadcast();
  final _downloadStreamController = StreamController<DownloadState>.broadcast();

  void dispose() {
    _changePageStreamController.close();
    _downloadStreamController.close();
  }

  get changePageStream =>
      _changePageStreamController.stream.asBroadcastStream();

  Stream<DownloadState> get downloadStream => _downloadStreamController.stream.asBroadcastStream();

  void changePage(int position) {
    currentPosition = position;
    _changePageStreamController.sink.add(position);
  }

  void startDownload() async {

    _downloadStreamController.sink.add(const DownloadStateLoading());
    try {
      await FlutterDownloadFile().startDownload(initDataViewAttachments.urls[currentPosition]);
      _downloadStreamController.sink.add(const DownloadStateSuccessfully());
    } catch (e) {
      _downloadStreamController.sink.add(DownloadStateFail(e));
    } finally {
      // _downloadStreamController.sink.add(const DownloadStateCompleted());
    }
  }

  get currentPositionDisplay => "${currentPosition + 1}/${initDataViewAttachments.urls.length}";

  get currentFileName => initDataViewAttachments.urls[currentPosition].fileName;

}
