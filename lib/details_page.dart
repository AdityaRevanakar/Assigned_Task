import 'package:assigned_task/colors.dart';
import 'package:assigned_task/favourite_provider.dart';
import 'package:assigned_task/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, String> news;

  const DetailsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Back'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        news['image']!,
                        width: double.infinity,
                        height: 201,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Consumer<FavouriteProvider>(
                      builder: (context, favouriteProvider, child) {
                        final isFavourite = favouriteProvider.isFavourite(news);
                        return IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isFavourite
                                ? AppColors.favouritePrimary
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (isFavourite) {
                              favouriteProvider.removeFavourite(news);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${news['title']} Removed from Favourites'),
                                ),
                              );
                            } else {
                              favouriteProvider.addFavourite(news);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${news['title']} Added to Favourites'),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                news['title']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Date(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                news['description']!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
