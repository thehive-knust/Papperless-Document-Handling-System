import 'package:flutter/material.dart';
import 'package:softdoc/screens/detail_screen/pdf_view.dart';
import 'package:softdoc/shared/docTypeIcon.dart';
import 'package:softdoc/style.dart';

Widget pdfCard(name, url) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // elevation: 2.0,
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/pdf_icon_activated.png",
                  height: 100,
                ),
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
