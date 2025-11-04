import 'package:hive/hive.dart';

part 'save_page.g.dart';

@HiveType(typeId: 0)
class SavedPage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String localPath;

  @HiveField(4)
  final DateTime savedDate;

  SavedPage({
    required this.id,
    required this.title,
    required this.url,
    required this.localPath,
    required this.savedDate,
  });
}