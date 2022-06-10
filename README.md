# File View Pager
A plugin flutter display drive files (doc, xlsx, pdf) and images (png, jpg) in a pager, and can download each item. Just support Android and iOS. \
With images, this plugin use [PhotoView](https://pub.dev/packages/photo_view). \
With drive files, this plugin use [Flutter InAppWebView](https://pub.dev/packages/flutter_inappwebview) to show an google driver url, and embed files into them. \
For more information about downloading file, please visit [Flutter Download File](https://github.com/tungnddev/file_view_pager).

![](/images/view_pager.gif)

## iOS integration
Add description to save image to photos (add following codes to `Info.plist` file)
```
<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need access to photo library so that photos can be download</string>
```
## Usage
#### Import package:
```
import 'package:file_view_pager/file_view_pager.dart';
```
#### Open ViewPager:
```
openFileViewPager(
              context,
              FVPParam(urls: [
                "https://www.clickdimensions.com/links/TestPDFfile.pdf",
              ], initPosition: 0));
```

#### Custom notice message:
```
openFileViewPager(
              context,
              FVPParam(urls: [
                "https://www.clickdimensions.com/links/TestPDFfile.pdf",
              ], initPosition: 0),
              text: const FVPText(
                  successMessage: "Hura", errorMessage: "Failed"));
```

## Bugs/Requests
If you encounter any problems feel free to open an issue. If you feel the library is missing a feature, please raise a ticket on Github. Pull request are also welcome.



