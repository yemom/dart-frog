import 'package:orm/orm.dart' as orm;

import 'client.dart';
import 'model.dart';
import 'prisma.dart';

class UserRepository {
  UserRepository(this._db);
  final PrismaClient _db;

  Future<User?> createUser({
    required String name,
    required String lastname,
  }) async {
    final user = await _db.user.create(
      data: orm.PrismaUnion.$1(UserCreateInput(name: name, lastname: lastname)),
    );
    return user;
  }

  Future<List<User>> getAll() async {
    final list = await _db.user.findMany();
    return list.toList();
  }
}
