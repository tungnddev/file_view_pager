extension CheckSuffixUrl on String {
  get isImage {
    String urlLowerCase = toLowerCase();
    return urlLowerCase.contains(".jpg") || urlLowerCase.contains(".png") || urlLowerCase.contains(".jpeg");
  }

  get isFileDriver {
    String urlLowerCase = toLowerCase();
    return urlLowerCase.contains(".doc") || urlLowerCase.contains(".xlxs") || urlLowerCase.contains(".pdf");
  }

  get fileName {
    return RegExp("([^\\\/]+)\$").stringMatch(this) ?? "";
  }
}