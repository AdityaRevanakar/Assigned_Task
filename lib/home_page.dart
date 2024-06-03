import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'colors.dart';
import 'details_page.dart';
import 'favourite_page.dart';
import 'favourite_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsContainer = [
      {
        'title': 'The standard Lorem Ipsum passage',
        'description':
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        'image': 'assets/image5.png',
      },
      {
        'title': 'Section 1.10.32 of "de Finibus"',
        'description':
            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
        'image': 'assets/image2.png',
      },
      {
        'title': 'Section 1.10.33 of "de Finibus"',
        'description':
            "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.",
        'image': 'assets/image3.png',
      },
      {
        'title': 'Neque porro quisquam est qui',
        'description':
            "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio.",
        'image': 'assets/image4.png',
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 16, 10),
            child: SafeArea(
              child: Row(
                children: [
                  const SizedBox(width: 28),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 130,
                      height: 50,
                      color: const Color(0xffEEF3FD),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/menu.png',
                              width: 28,
                            ),
                            const Text(
                              '\tNews',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouritePage(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: AppColors.favouritePrimary,
                          size: 28,
                        ),
                        Text(
                          '\tFavs',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: newsContainer.length,
              itemBuilder: (context, index) {
                final news = newsContainer[index];
                return NewsTile(news: news);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsTile extends StatefulWidget {
  final Map<String, String> news;
  const NewsTile({required this.news, super.key});

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool isSlidOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(news: widget.news),
          ),
        );
      },
      child: Slidable(
        key: ValueKey(widget.news['title']),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Container(
              height: 112,
              width: 190,
              child: CustomSlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                onPressed: (context) {
                  final favouriteProvider =
                      Provider.of<FavouriteProvider>(context, listen: false);
                  favouriteProvider.addFavourite(widget.news);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${widget.news['title']} Added to Favourites'),
                    ),
                  );
                },
                backgroundColor: AppColors.favouriteSecondary,
                foregroundColor: AppColors.favouritePrimary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: AppColors.favouritePrimary),
                    SizedBox(height: 4),
                    Text(
                      'Add to\nFavourite',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.horizontal(
              left: const Radius.circular(10),
              right: isSlidOpen ? Radius.zero : const Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(widget.news['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.news['description']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                    ),
                    const Date(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Date extends StatelessWidget {
  const Date({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/calendar.png',
          width: 17.42,
        ),
        const Text(
          '\tMon, 21 Dec 2020 14:57 GMT',
          style: TextStyle(
            color: AppColors.greyColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
