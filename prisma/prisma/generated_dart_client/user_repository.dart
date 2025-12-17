import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:orm/orm.dart' as orm;

import 'client.dart';
import 'model.dart';
import 'prisma.dart';

class UserRepository {
  UserRepository(this._db);
  final PrismaClient _db;

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

  Future<List<User>> getAll() async {
    final list = await _db.user.findMany();
    return list.toList();
  }

  String _hashedPassword(String password) {
    final encodedPassword = utf8.encode(password);
    return sha256.convert(encodedPassword).toString();
  }
}
