import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:softdoc/screens/detail_screen/pdf_view.dart';
import 'package:softdoc/shared/docTypeIcon.dart';
import 'package:softdoc/style.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfCard extends StatelessWidget {
  final name, url, bytes, isDesktop;
  const PdfCard({Key key, this.name, this.url, this.bytes, this.isDesktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // elevation: 2.0,
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child:
                    PdfThumbnail(url: url, bytes: bytes, isDesktop: isDesktop),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              width: double.infinity,
              color: primaryLight,
              child: Row(
                children: [
                  DocTypeIcon(),
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => PdfViewer.downloadPDF(url),
                      icon: Icon(Icons.download),
                      color: primaryDark,
                      splashColor: primaryLight,
                      hoverColor: primaryLight,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PdfThumbnail extends StatefulWidget {
  final url, bytes;
  final bool isDesktop;
  const PdfThumbnail({Key key, this.url, this.bytes, this.isDesktop})
      : super(key: key);

  @override
  _PdfThumbnailState createState() => _PdfThumbnailState();
}

class _PdfThumbnailState extends State<PdfThumbnail> {
  Widget thumbnail;

  void generateThumbnail() async {
    Uint8List pdfBytes;
    if (widget.bytes == null) {
      try {
        final pdf = await http.get(Uri.parse(widget.url));
        pdfBytes = pdf.bodyBytes;
      } catch (e) {
        downloadErrorDialog();
      }
    } else
      pdfBytes = widget.bytes;
    final document = await PdfDocument.openData(pdfBytes);
    final page = await document.getPage(1);
    final pageImage = await page.render(
      width: page.width,
      height: page.height,
    );
    await page.close();
    thumbnail = FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: 0.3,
          child: Image.memory(
            pageImage.bytes,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
    setState(() {});
  }

  downloadErrorDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      
      builder: (context) => AlertDialog(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text("Couldn't download PDF"),
          content: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please check your internet connection.${widget.isDesktop ? "\nif you're using a third party download \nmanager such as IDM, make sure to exempt \nhttps://res.cloudinary.com/thehivecloudstorage/ \nfrom automatic downloads for the best possible experience" : ""} ",
                ),
                SizedBox(height: 5),
                if(widget.isDesktop) TextButton(
                  onPressed: () async {
                    String link =
                        "https://www.internetdownloadmanager.com/register/new_faq/functions6.html";
                    if (await canLaunch(link)) {
                      await launch(link);
                    } else {
                      throw "couldn't launch $link";
                    }
                  },
                  child: Text("How to exempt site from IDM"),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('OK'))
          ]),
    );
  }

  @override
  void initState() {
    super.initState();
    generateThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return thumbnail ??
        Center(
          child: Image.asset(
            "assets/images/pdf_icon_activated.png",
            height: 100,
          ),
        );
  }
}
