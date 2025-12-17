import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import '../../prisma/prisma/generated_dart_client/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getUser(context),
    HttpMethod.post => _createUser(context),
    _ => Future.value(Response(body: 'This is default')),
  };
}

Future<Response> _getUser(RequestContext context) async {
  final repo = context.read<UserRepository>();
  final users = await repo.getAll();

  return Future.value(Response.json(body: users));
}

Future<Response> _createUser(RequestContext context) async {
  final json = (await context.request.json()) as Map<String, dynamic>;
  final name = json['name'] as String?;
  final lastname = json['lastname'] as String?;
  final username = json['username'] as String?;
  final password = json['password'] as String?;

  if (name == null ||
      lastname == null ||
      username == null ||
      password == null) {
    return Response.json(
      body: {'error': 'Missing name or lastname'},
      statusCode: HttpStatus.badRequest,
    );
  }
  final repo = context.read<UserRepository>();
  final user = await repo.createUser(
    name: name,
    lastname: lastname,
    username: username,
    password: password,
  );
  return Response.json(body: {'message': 'User created', 'user': user});
}
