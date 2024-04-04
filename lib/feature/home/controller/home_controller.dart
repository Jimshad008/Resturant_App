import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/feature/home/repository/home_repository.dart';

import '../../../model/reustarant_model.dart';
final getRestaurantsProvider=FutureProvider.autoDispose((ref) => ref.read(homeControllerProvider).getRestaurants());
final homeControllerProvider=Provider((ref) => HomeController(homeRepository: ref.read(homeRepositoryProvider)));
class HomeController{
  final HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository}):_homeRepository=homeRepository;
  Future<Restaurants> getRestaurants()async {
    return _homeRepository.getRestaurants();
  }
}