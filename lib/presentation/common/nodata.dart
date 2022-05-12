import 'package:flutter/material.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/widgets/pages/home/index.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            size: 30,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 7),
          Text(
            AppLocalization.of(context)!.translate('no_data'),
            style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
