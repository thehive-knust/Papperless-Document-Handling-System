import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:softdoc/screens/detail_screen/pdf_view.dart';
import 'package:softdoc/shared/docTypeIcon.dart';
import 'package:softdoc/style.dart';

class PdfCard extends StatelessWidget {
  final name, url;
  const PdfCard({Key key, this.name, this.url}) : super(key: key);

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
              child: Center(
                child: PdfThumbnail(url: url),
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
  final url;
  const PdfThumbnail({Key key, this.url}) : super(key: key);

  @override
  _PdfThumbnailState createState() => _PdfThumbnailState();
}

class _PdfThumbnailState extends State<PdfThumbnail> {
  Image thumbnail;

  void generateThumbnail() async {
    final pdf = await http.get(Uri.parse(widget.url));
    final document = await PdfDocument.openData(pdf.bodyBytes);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: 150);
    await page.close();
    thumbnail = Image(
      image: MemoryImage(pageImage.bytes, scale: 2),
      fit: BoxFit.fill,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    generateThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return thumbnail ??
        Image.asset(
          "assets/images/pdf_icon_activated.png",
          height: 100,
        );
  }
}
