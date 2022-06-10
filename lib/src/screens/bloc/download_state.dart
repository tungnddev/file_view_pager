class DownloadState {
  const DownloadState();
}

class DownloadStateCompleted extends DownloadState {
  const DownloadStateCompleted();
}

class DownloadStateSuccessfully extends DownloadState {
  const DownloadStateSuccessfully();
}

class DownloadStateLoading extends DownloadState {
  const DownloadStateLoading();
}

class DownloadStateFail extends DownloadState {
  final dynamic e;
  const DownloadStateFail(this.e);

}