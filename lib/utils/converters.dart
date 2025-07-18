import 'package:cinehive_mobile/features/shared/models/content.dart';

class Converters {
  static List<Person> convertCastToPeople(List<Cast> cast) {
    return cast.take(3).map((cast) => Person(
      name: cast.name,
      profilePath: cast.profilePath,
    )).toList();
  }
}