class ParsedData {
  final String text; // text without $$...$$
  final List<String> latex; // list of LaTeX segments

  ParsedData({required this.text, required this.latex});
}
