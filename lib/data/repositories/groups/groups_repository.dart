import 'package:moreinfo/data/models/groups/groups_model.dart';
import 'package:moreinfo/data/providers/private/groups/get_groups_provider.dart';

class GroupsRepository {
  Future<List<GroupsModel>> getGroupsRP() async {
    var response = await getGroupsPV();
    List data = response.data['data'];
    List<GroupsModel> groups =
        data.map((e) => GroupsModel.fromJson(e)).toList();

    return groups;
  }
}
