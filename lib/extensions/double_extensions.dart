import 'package:flutter/cupertino.dart';

extension PaddingExtension on double {
  EdgeInsets get allPadding => EdgeInsets.all(this);

  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: this);

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: this);

  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: this);

  EdgeInsets get topPadding => EdgeInsets.only(top: this);

  EdgeInsets get lrtPadding => EdgeInsets.fromLTRB(this, this, this, 0);
}

extension SizeBoxSpace on double {
  Widget get verticalSpace => SizedBox(height: this);

  Widget get horizontalSpace => SizedBox(width: this);
}
