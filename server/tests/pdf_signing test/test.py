from pdfminer.layout import LAParams, LTTextBox
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfinterp import PDFResourceManager
from pdfminer.pdfinterp import PDFPageInterpreter
from pdfminer.converter import PDFPageAggregator
import re
import fitz

fp = open('test.pdf', 'rb')
rsrcmgr = PDFResourceManager()
laparams = LAParams()
device = PDFPageAggregator(rsrcmgr, laparams=laparams)
interpreter = PDFPageInterpreter(rsrcmgr, device)
pages = PDFPage.get_pages(fp)


def insert_sinature(margin, y1, width, y2):
    input_file = "test.pdf"
    output_file = "test-with-image.pdf"
    img = open("signature.jpg", 'rb').read()

    # x (x-margin/padding), y1, width (x-margin + img-width), y2
    image_rectangle = fitz.Rect(margin, y1, width, y2) 

    # retrieve the first page of the PDF
    file_handle = fitz.open(input_file)
    first_page = file_handle[0]

    # add the image
    first_page.insertImage(image_rectangle, stream=img)

    file_handle.save(output_file)
    return None


for page in pages:
    print('Processing next page...')
    interpreter.process_page(page)
    layout = device.get_result()
    for lobj in layout:
        if isinstance(lobj, LTTextBox):
            regex = re.compile('_+')
            match = regex.finditer(lobj.get_text())     # returns a list of match objs
            if match:
                for elem in match:
                    x1, x2 = elem.span()
                    p = (lobj.bbox[0] + x1) * 2
                    y1 = (lobj.bbox[3] * 3) - 20
                    w = p + (x2 - x1) * 3
                    y2 = y1 + 20
                    print(p, y1, w, y2)
                    insert_sinature(p, y1, w, y2)

            # x, y, text = lobj.bbox[0], lobj.bbox[3], lobj.get_text()
            # print('At %r is text: %s' % ((x, y), text))
 
