import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../prisma/prisma/generated_dart_client/client.dart';
import '../prisma/prisma/generated_dart_client/user_repository.dart';

final _prisma = PrismaClient(
  datasourceUrl: Platform.environment['DATABASE_URL'],
);

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<PrismaClient>((_) => _prisma))
      .use(provider<UserRepository>((_) => UserRepository(_prisma)))
      .use(_provideUserRepo());
}

Middleware _provideUserRepo() {
  return provider((context) => UserRepository(_prisma));
}
