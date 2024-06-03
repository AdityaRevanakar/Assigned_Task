import 'package:assigned_task/colors.dart';
import 'package:assigned_task/details_page.dart';
import 'package:assigned_task/favourite_provider.dart';
import 'package:assigned_task/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 16, 10),
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 28,
                    ),
                    Image.asset(
                      'assets/menu.png',
                      width: 28,
                    ),
                    const Text('\tNews',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      width: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 140,
                        height: 50,
                        color: const Color(0xffEEF3FD),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: AppColors.favouritePrimary,
                                size: 28,
                              ),
                              Text('\tFavs',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<FavouriteProvider>(
              builder: (context, favouriteProvider, child) {
                if (favouriteProvider.favourites.isEmpty) {
                  return const Center(
                    child: Text(
                      'No favourites yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: favouriteProvider.favourites.length,
                  itemBuilder: (context, index) {
                    final news = favouriteProvider.favourites[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(news: news),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
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
                                  image: AssetImage(news['image']!),
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
                                    maxLines: 2,
                                    news['title']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.textColor),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    maxLines: 2,
                                    news['description']!,
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
