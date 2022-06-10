import 'package:file_view_pager/src/models/fvp_param.dart';
import 'package:file_view_pager/src/models/fvp_text.dart';
import 'package:file_view_pager/src/screens/widgets/page_view_widget.dart';
import 'package:flutter/material.dart';

import 'bloc/download_bloc.dart';
import 'bloc/download_state.dart';

class FileViewPageScreen extends StatefulWidget {
  final FVPParam params;
  final FVPText fvpText;

  const FileViewPageScreen(
      {Key? key, required this.params, required this.fvpText})
      : super(key: key);

  @override
  _FileViewPageScreenState createState() => _FileViewPageScreenState();
}

class _FileViewPageScreenState extends State<FileViewPageScreen> {
  late DownloadBloc bloc = DownloadBloc(initDataViewAttachments: widget.params);

  @override
  void initState() {
    super.initState();
    bloc.downloadStream.listen((event) {
      if (event is DownloadStateSuccessfully) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            widget.fvpText.successMessage,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF4A90E2),
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFECF3FC),
          duration: const Duration(seconds: 3),
        ));
      } else if (event is DownloadStateFail) {
        debugPrint(event.e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            widget.fvpText.errorMessage,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFFCECEC),
          duration: const Duration(seconds: 3),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: StreamBuilder<DownloadState>(
                stream: bloc.downloadStream,
                builder: (context, AsyncSnapshot<DownloadState> snapshot) {
                  return snapshot.data is DownloadStateLoading
                      ? Container(
                          width: 34,
                          height: 34,
                          alignment: Alignment.center,
                          child: const SizedBox(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            width: 19,
                            height: 19,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            bloc.startDownload();
                          },
                          child: Container(
                              width: 34,
                              height: 34,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.download_sharp,
                                color: Colors.white,
                                size: 22,
                              )),
                        );
                }),
          ),
        ],
        title: StreamBuilder<int>(
            stream: bloc.changePageStream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              return Text(
                bloc.currentFileName ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                    fontSize: 14),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              );
            }), // or use
        // Brightness.dark
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageViewWidget(
                listAttachment: widget.params.urls,
                initPosition: widget.params.initPosition,
                onPageChanged: (position) {
                  bloc.changePage(position);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder<int>(
                stream: bloc.changePageStream,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Text(
                    bloc.currentPositionDisplay,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                        fontSize: 14),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  );
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        )),
      ),
    );
  }
}
