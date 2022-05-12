import 'package:moreinfo/bloc/reset_pass/types.dart';
import 'package:moreinfo/data/providers/private/resetpass/resetpass_provider.dart';

class ResetPassRepository {
  Future<void> resetPassRP(ResetPassModel data) async {
    await resetPassPV(data);
  }
}
