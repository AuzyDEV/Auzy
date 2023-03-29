import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_mee/services/User_api.dart';
import 'package:new_mee/services/postMan.dart';
import 'package:new_mee/common_widgets/app_bar.dart';
import 'package:new_mee/common_widgets/drawer.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/User.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:new_mee/common_widgets/FFButtonWidget.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_editor_enhanced/utils/callbacks.dart';
import 'package:html_editor_enhanced/utils/file_upload_model.dart';
import 'package:html_editor_enhanced/utils/options.dart';
import 'package:html_editor_enhanced/utils/plugins.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_fake.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:html_editor_enhanced/utils/shims/flutter_inappwebview_fake.dart';
import 'package:html_editor_enhanced/utils/toolbar.dart';
import 'package:html_editor_enhanced/utils/utils.dart';

class SummernoteWidget extends StatefulWidget {
  final String title = "haifa";
  const SummernoteWidget({Key key}) : super(key: key);

  @override
  _SummernoteWidgetState createState() => _SummernoteWidgetState();
}

class _SummernoteWidgetState extends State<SummernoteWidget> {
  HtmlEditorController controller = HtmlEditorController();
  String result = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              /*  HtmlEditor(
                controller: controller, //required
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Your text here...",
                  initialText: "text content initial, if any",
                ),
                otherOptions: OtherOptions(
                  height: 600,
                ),
              )*/
            ],
          ),
        ));
  }
}
