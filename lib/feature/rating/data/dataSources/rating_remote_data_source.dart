import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/error/exceptions.dart';
import '../../../../core/utils/strings/strings.dart';
import '../../../../core/utils/utils.dart';


abstract class RatingRemoteDataSource {


  Future<Unit> ratingPost(String serviceId, int rating);

}

const String ratingUrl = "api/v1/ratings" ;
class RatingRemoteDataSourceImpl extends RatingRemoteDataSource {
  final http.Client client;

  RatingRemoteDataSourceImpl({required this.client});


  @override
  Future<Unit> ratingPost(String serviceId, int rating) async {
    const token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzb2Z0eWxpbmVzLmNvbSIsImF1ZCI6InNvZnR5bGluZXMuY29tIiwic3ViIjoiNjRhMjg0NDhmZjg0MDc3YzVlZjQzZTE3IiwiaWF0IjoxNjg5MDcyNjA0LCJleHAiOjE2OTE2NjQ2MDQsInBybSI6IjU3Y2IxOTE3YWJmYTE1NzNhMzA0ODQ1YmI2YjdlNWY0Y2VhYjYwODg3YmVjYmMxZjE0OTE1Mjk0MTE4OWRmM2M3ZTQzMzg1YjJhMzc5MDU3YjBlMmI0M2FjMGM4NmNlYzMxMThlNmViN2JmYmFjZmNjNTZjNWQzNDJmMDY1Mjg5IiwidHlwZSI6IlRFQUNIRVIifQ.O78JA-A1ULK3PS1wkXlMQWT3-abP3kcXj9zQGK1dX1uf63NzFlhdBq1GeA5c-yxQk_yIg6zD_ZhYbwHJf9e1Sv97XWj3JIUrRkZb_6dw5xQvaX1-STsFRGmZsO7mxZTnw-Wu-yQZGUzbmtIMvu5SV2U97-E4OoMv_Wos7HIZyYePtcmatBXgAl4iXvkd8kmdRpxRhnK7c0yb-4qy5cQB6DIdiyU8vjuNw7cwneAWWxnPT99pE-swI3uypxn2FYtphU-Wc5s_pT_A6WxG6nEqO_pdIVijP2RzvEuNw5iragkBcct9zBYti90wvhEsi-t2_VGVhFqHJC8elcEZmZYCiA";
    final body = {
      "rating": rating,
    };
    final response = await client.put(
      headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
      Uri.parse("${Strings.baseUrl}/$ratingUrl/$serviceId"),
      body: jsonEncode(body),
    );
    print("RatingPostResponse: ${response.body}");
    if (response.statusCode == 200) {
      return Future.value(unit);
    }

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }

}
