import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gaushala/models/dashboard.dart';
import 'package:gaushala/services/home_services.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List get list => _summary?.animalsByTypeAndGender ?? [];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Dashboard? _summary;
  Dashboard? get summary => _summary;

  List<AnimalsByTypeAndGender> get animalList =>
      _summary?.animalsByTypeAndGender ?? [];

  final PageController sliderController = PageController();

  final List<String> sliderImages = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg',
  ];

  int _currentImageIndex = 0;
  int get currentImageIndex => _currentImageIndex;

  Timer? _sliderTimer;

  void startImageSlider() {
    _sliderTimer?.cancel(); // Cancel any existing timer
    _sliderTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      _currentImageIndex = (_currentImageIndex + 1) % sliderImages.length;
      notifyListeners();
    });
  }

  void disposeSlider() {
    _sliderTimer?.cancel();
  }

  void init() async {
    setBusy(true);
    await fetchData();
    setBusy(false);
  }

  Future<void> fetchData() async {
    // TODO: Replace with your API or local storage logic
    _summary = await HomeServices().dashboard(); // hypothetical service
    notifyListeners();
  }

  void onBottomNavTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
