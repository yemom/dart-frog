import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import '../../prisma/prisma/generated_dart_client/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _authUser(context),
    _ => Future.value(Response(body: 'This is default')),
  };
}

Future<Response> _authUser(RequestContext context) async {
  final json = (await context.request.json()) as Map<String, dynamic>;
  final username = json['username'] as String?;
  final password = json['password'] as String?;

  if (username == null || password == null) {
    return Response.json(
      body: {'error': 'Missing username or password'},
      statusCode: HttpStatus.badRequest,
    );
  }

  final repo = context.read<UserRepository>();
  final user = await repo.authUser(username: username, password: password);
  if (user == null) {
    return Response.json(
      body: {'error': 'User not found or password is incorrect'},
      statusCode: HttpStatus.unauthorized,
    );
  }
  return Response.json(body: {'message': 'User authenticated', 'user': user});
}
