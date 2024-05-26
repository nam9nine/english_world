import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/category-word.model.dart';
import '../model/main-category.model.dart';


class MainCarouselSlider extends StatefulWidget {
  final List<Category> categories;
  late int pageIndex;
  MainCarouselSlider({super.key, required this.categories, this.pageIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return _MainCarouselSlider();
  }

}

class _MainCarouselSlider extends State<MainCarouselSlider> {

  @override
  Widget build(BuildContext context) {
    List<Widget> categorySliders = widget.categories.map((category) =>
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(category.imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  bottom: 20,
                  child: Text(category.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        )
    ).toList();
    return CarouselSlider(
        items: categorySliders,
        options: CarouselOptions(
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged : (index, reason){
              setState(() {
                widget.pageIndex = index;
              });
            }
        ),
    );
  }
}

class LearnCarouselSlider extends StatefulWidget {
  final List<Word>? words;
  int pageIndex = 0;
  LearnCarouselSlider({super.key, required this.words, required this.pageIndex});

  @override
  State<StatefulWidget> createState() => _LearnCarouselSliderState();
}

class _LearnCarouselSliderState extends State<LearnCarouselSlider> {
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.words!.map((word) => Container(
            width: MediaQuery.of(context).size.width, // 화면의 가로 폭에 맞춤
            margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    word.english,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    word.meaning ?? 'No meaning provided',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700]
                    ),
                  ),
                ],
              ),
            ),
          )).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
              height: 400,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                widget.pageIndex = index;
              }
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _carouselController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, backgroundColor: Colors.white, // 아이콘 색상
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                elevation: 4, // 버튼의 그림자
                shadowColor: Colors.grey.withOpacity(0.5), // 그림자 색상
              ),
              child: const Icon(Icons.arrow_back_ios, size: 20),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => _carouselController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, backgroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.5),
              ),
              child: const Icon(Icons.arrow_forward_ios, size: 20),
            ),
          ],
        )

      ],
    );
  }
}
