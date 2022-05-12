import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moreinfo/bloc/students/students_bloc.dart';
import 'package:moreinfo/data/models/groups/groups_model.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/common/app_dropdown.dart';
import 'package:moreinfo/presentation/common/button.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class StudentFilter extends StatefulWidget {
  List<GroupsModel> groups;
  Function(String?) handleSetGroup;
  StudentFilter({
    Key? key,
    required this.groups,
    required this.handleSetGroup,
  }) : super(key: key);

  @override
  State<StudentFilter> createState() => _StudentFilterState();
}

class _StudentFilterState extends State<StudentFilter> {
  final GlobalKey _menuKey = GlobalKey();
  String groupName = '';
  final _filterFormKey = GlobalKey<FormBuilderState>();
  String type = '1';

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          groupName.isNotEmpty
              ? Text(
                  groupName,
                  style: const TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Container(),
          PopupMenuButton(
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
            itemBuilder: (ctx) => [
              PopupMenuItem(
                enabled: false,
                child: FormBuilder(
                  key: _filterFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      AppDropdown(
                        onChanged: (val) {
                          widget.handleSetGroup(val);
                        },
                        label: 'Gruruhlar',
                        name: 'group',
                        items: widget.groups
                            .map((e) => {'id': e.id, 'key': e.name.toString()})
                            .toList(),
                      ),
                      const SizedBox(height: 15),
                      AppButton(
                        press: () {
                          _filterFormKey.currentState!.save();
                          if (_filterFormKey.currentState!.validate()) {
                            String group =
                                _filterFormKey.currentState!.value['group'];

                            setState(() {
                              groupName = widget.groups
                                  .where((g) => g.id.toString() == group)
                                  .toList()[0]
                                  .name
                                  .toString();
                            });
                            context
                                .read<StudentsBloc>()
                                .add(StartFetchStudents(group));
                          }
                          Navigator.pop(context);
                          // dynamic state = _menuKey.currentState;
                          //             state.showButtonMenu();
                        },
                        text: AppLocalization.of(context)!.translate('apply'),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                value: '0',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
