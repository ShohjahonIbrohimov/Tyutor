import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moreinfo/presentation/common/app_dropdown.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/config/constants.dart';

class HomeworkFilter extends StatefulWidget {
  const HomeworkFilter({Key? key}) : super(key: key);

  @override
  State<HomeworkFilter> createState() => _HomeworkFilterState();
}

class _HomeworkFilterState extends State<HomeworkFilter> {
  final GlobalKey _menuKey = GlobalKey();
  final _filterFormKey = GlobalKey<FormBuilderState>();
  String type = '1';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      key: _menuKey,
      onSelected: (value) {},
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: TextButton.icon(
        onPressed: () {
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        },
        icon: const Icon(
          Icons.filter_list_rounded,
          color: primaryColorLight,
        ),
        label: const Text(
          'Filter',
          style: TextStyle(color: primaryColor),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: FormBuilder(
            key: _filterFormKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                AppDropdown(
                  label: 'Semestr',
                  name: 'semestr',
                  items: const [
                    {'id': 1, 'key': '2021/22: 1-semester'},
                    {'id': 2, 'key': '2021/22: 2-semester'},
                    {'id': 3, 'key': '2021/22: 3-semester'},
                    {'id': 4, 'key': '2021/22: 4-semester'},
                  ],
                ),
                const SizedBox(height: 15),
                AppDropdown(
                  label: 'Turi',
                  name: 'type',
                  items: const [
                    {'id': 1, 'key': 'Barcha xisobotlar'},
                    {'id': 2, 'key': 'Qabul qilingan'},
                    {'id': 3, 'key': "Dedlayn o'tgan"},
                  ],
                ),
                const SizedBox(height: 15),
                AppButton(
                  press: () {
                    _filterFormKey.currentState!.save();
                    if (_filterFormKey.currentState!.validate()) {
                      setState(() {
                        type = _filterFormKey.currentState!.value['type'];
                      });
                    }
                  },
                  text: 'Apply',
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          value: '0',
        ),
      ],
    );
  }
}
