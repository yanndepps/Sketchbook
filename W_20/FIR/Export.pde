void export(Path p, int i) {
  exportSVG(p, i);
}

void exportPDF(Path p) {
  beginRecord(PDF, "output/output_" + cols + "_pdf/" + p.name() + ".pdf");
  translate(outerMargin, outerMargin);
  fill(0);
  noStroke();
  p.show();
  endRecord();
}

void exportSVG(Path p, int i) {
  beginRecord(SVG, "output/output_" + cols + "_svg/" + p.name() + "_" + i + ".svg");
  translate(outerMargin, outerMargin);
  p.show();
  endRecord();
}
