import 'package:flutter/material.dart';

import 'models/models.dart';
import 'screens/file_view_pager.dart';

Future openFileViewPager(BuildContext context, FVPParam param,
    {FVPText text = const FVPText()}) async {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => FileViewPageScreen(
                params: param,
                fvpText: text,
              )));
}
