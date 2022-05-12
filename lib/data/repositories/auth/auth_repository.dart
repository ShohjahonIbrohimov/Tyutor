import 'package:moreinfo/bloc/login/types.dart';
import 'package:moreinfo/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:moreinfo/data/models/user/user_model.dart';
import 'package:moreinfo/data/providers/private/settings/reset_password_provider.dart';
import 'package:moreinfo/data/providers/private/user/get_user_provider.dart';
import 'package:moreinfo/data/providers/public/get_code_provider.dart';
import 'package:moreinfo/data/providers/public/login_provider.dart';
import 'package:moreinfo/data/providers/public/send_code_provider.dart';
import 'package:moreinfo/data/providers/public/send_password_provider.dart';
import 'package:moreinfo/data/repositories/auth/token_repository.dart';

class AuthRepository {
  Future<String> loginRP(LoginCredentials data) async {
    var response = await loginPV(data);
    String token = response.data['data']['access_token'];

    return token;
  }

  Future<void> getUserRP() async {
    var response = await getUserPV();
    await TokenRepository().setUserData(response.data['data']);
  }

  Future<void> getCodeRP(ResetPassModel data) async {
    await getCodePV(data);
  }

  Future<void> sendCodeRP(ResetPassModel data) async {
    await sendCodePV(data);
  }

  Future<void> sendPasswordRP(ResetPassModel data) async {
    await sendPasswordPV(data);
  }

  Future<void> resetPasswordRP(ResetPasswordPrivateModel data) async {
    await resetPasswordPV(data);
  }
}
