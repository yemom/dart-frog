import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:orm/orm.dart' as orm;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'client.dart';
import 'model.dart';
import 'prisma.dart';

class UserRepository {
  UserRepository(this._db);
  final PrismaClient _db;
// log in th existing user check whatever the user is exist or not
  Future<User?> authUser({
    required String username,
    required String password,
  }) async {
    final user = await _db.user.findUnique(
      where: UserWhereUniqueInput(username: username),
    );
    if (user == null) {
      return null;
    }
    final hashed = _hashedPassword(password);
    if (user.password != hashed) {
      return null;
    }
    return user;
  }
// create a new user 
  Future<User?> createUser({
    required String name,
    required String lastname,
    required String username,
    required String password,
  }) async {
    final user = await _db.user.create(
      data: orm.PrismaUnion<UserCreateInput, UserUncheckedCreateInput>.$1(
        UserCreateInput(
          name: name,
          lastname: lastname,
          username: username,
          password: _hashedPassword(password),
        ),
      ),
    );
    return user;
  }
//get all the user
  Future<List<User>> getAll() async {
    final list = await _db.user.findMany();
    return list.toList();
  }
//hash the password
  String _hashedPassword(String password) {
    final encodedPassword = utf8.encode(password);
    return sha256.convert(encodedPassword).toString();
  }
}
//fetch user token
int? fetchUserFromToken(String token) {
  try {
    final jwt = JWT.verify(token, SecretKey('1221'));
    return jwt.payload['userId'] as int;
  } on JWTException catch (_) {
    return null;
  }
}
