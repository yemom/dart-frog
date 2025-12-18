import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

import '../../prisma/prisma/generated_dart_client/model.dart';
import '../../prisma/prisma/generated_dart_client/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(_provideAuthentication());
}

Middleware _provideAuthentication() {
  return bearerAuthentication<int>(
    authenticator: (context, token) async {
      return fetchUserFromToken(token);
    },
  );
}
