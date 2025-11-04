import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.delete => _deleteUser(id),
    HttpMethod.put => _updateUser(id, context),
    _ => Future.value(Response(body: 'This is default'))
  };
}

Future<Response> _deleteUser(String id) async {
  return Response.json(
    body: {
      'message': 'User with id: $id deleted successfully',
    },
  );
}

Future<Response> _updateUser(String id, RequestContext context) async {
  return Response.json(
    body: {
      'message': 'User updated successfully',
    },
  );
}
