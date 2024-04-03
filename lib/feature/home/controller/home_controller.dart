import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/feature/home/repository/home_repository.dart';
final homeControllerProvider=Provider((ref) => HomeController(homeRepository: ref.read(homeRepositoryProvider)));
class HomeController{
  final HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository}):_homeRepository=homeRepository;

}