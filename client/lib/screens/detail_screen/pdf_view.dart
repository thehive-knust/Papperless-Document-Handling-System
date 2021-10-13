import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softdoc/cubit/android_nav_cubit/AndroidNav_cubit.dart';
import 'package:softdoc/cubit/desktop_nav_cubit/desktopnav_cubit.dart';
import 'package:softdoc/models/doc.dart';
import 'package:softdoc/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewer extends StatefulWidget {
  final Doc selectedDoc;
  final bool fromReceivedDetailScreen;
  const PdfViewer({Key key, this.selectedDoc, this.fromReceivedDetailScreen})
      : super(key: key);

  static void downloadPDF(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  AndroidNavCubit _androidNavCubit;
  DesktopNavCubit _desktopNavCubit;

  @override
  void initState() {
    super.initState();
    _androidNavCubit = BlocProvider.of<AndroidNavCubit>(context);
    _desktopNavCubit = BlocProvider.of<DesktopNavCubit>(context);
  }

  void goBack() {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    if (!widget.fromReceivedDetailScreen)
      isDesktop
          ? _desktopNavCubit.navToDetailScreen(widget.selectedDoc)
          : _androidNavCubit.navToDetailScreen(widget.selectedDoc);
    else
      isDesktop
          ? _desktopNavCubit.navToreceivedDetailScreen(widget.selectedDoc)
          : _androidNavCubit.navToreceivedDetailScreen(widget.selectedDoc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryLight,
        leading: IconButton(
          onPressed: () => goBack(),
          icon: Icon(Icons.arrow_back),
          color: primaryDark,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                PdfViewer.downloadPDF(widget.selectedDoc.fileUrl);
                goBack();
              },
              icon: Icon(
                Icons.download,
              ),
              color: primaryDark,
            ),
          ),
        ],
      ),
      body: Container(
        // width: double.infinity,
        child: SfPdfViewer.network(widget.selectedDoc.fileUrl),
      ),
    );
  }
}
