import 'package:flutter_dotenv/flutter_dotenv.dart';

class MediaImageUrls {
  static final String _baseImageUrl = dotenv.env['IMAGES_URL']!;

  static String backdropSm(String? path, {String size = 'w300'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String backdropMd(String? path, {String size = 'w780'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String backdropLg(String? path, {String size = 'w1280'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String posterSm(String? path, {String size = 'w154'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String posterMd(String? path, {String size = 'w342'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String posterLg(String? path, {String size = 'w500'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String profileSm(String? path, {String size = 'w185'}) =>
      '$_baseImageUrl/$size${path ?? ''}';

  static String profileLg(String? path, {String size = 'h632'}) =>
      '$_baseImageUrl/$size${path ?? ''}';
}
