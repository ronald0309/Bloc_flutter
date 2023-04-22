import '../my_gif_service.dart';

void main()async {
  final gifService = MyGifService();
  final urls = await gifService.fetchGifs();
  for (final url in urls){
    print(url);
  }
}