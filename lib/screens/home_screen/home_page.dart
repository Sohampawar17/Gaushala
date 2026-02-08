import 'package:flutter/material.dart';
import 'package:gaushala/constants.dart';
import 'package:stacked/stacked.dart';

import '../../models/dashboard.dart';
import '../../widgets/full_screen_loader.dart';
import '../company/company_screen.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (model) {
          model.init();
        },
        builder: (context, model, child) {
          return fullScreenLoader(
              loader: model.isBusy,
              context: context,
              child: Scaffold(
                body: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: model.fetchData,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFFF99)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: model.selectedIndex == 0
                          ? _buildBodyContent(model, context)
                          : const CompanyInfoView(), // placeholder
                    ),
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: model.selectedIndex,
                  onTap: model.onBottomNavTap,
                  selectedItemColor: Colors.deepPurple,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline_rounded),
                      label: 'About Us',
                    ),
                  ],
                ),
              ));
        });
  }

  Widget _buildBodyContent(HomeViewModel model, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildGreetingSection(model, context),
          const SizedBox(height: 10),
          _buildImageSlider(model),
          const SizedBox(height: 10),
          _buildSummaryCard(model, context),
          const SizedBox(height: 15),
          _buildNavigationGrid(context),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildGreetingSection(HomeViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.account_circle, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${model.summary?.username.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.blueGrey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Welcome to संवेदना गौशाळा',
                        style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () => logout(context), icon: const Icon(Icons.logout))
        ],
      ),
    );
  }

  Widget _buildImageSlider(HomeViewModel model) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue[900]!, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 6))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (child, animation) => SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Image.asset(
            model.sliderImages[model.currentImageIndex],
            key: ValueKey<String>(model.sliderImages[model.currentImageIndex]),
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => const Center(
                child: Text('Image not found',
                    style: TextStyle(color: Colors.red))),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(HomeViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.blueAccent.shade100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryBox(
                    title: "Total Milk",
                    value: "${model.summary?.totalStockQty ?? 0} Ltr",
                    icon: Icons.local_drink,
                    color: Colors.orange,
                  ),
                  _summaryBox(
                    title: "Animals",
                    value: "${model.summary?.totalAnimals ?? 0}",
                    icon: Icons.pets,
                    color: Colors.green,
                  ),
                  _summaryBox(
                    title: "Male",
                    value: "${model.summary?.maleAnimals ?? 0}",
                    icon: Icons.male,
                    color: Colors.blue,
                  ),
                  _summaryBox(
                    title: "Female",
                    value: "${model.summary?.femaleAnimals ?? 0}",
                    icon: Icons.female,
                    color: Colors.pink,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(thickness: 1.2),
              // Animal List
              GridView.builder(
                itemCount: model.list.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final item = model.list[index];
                  return _AnimalTile(item: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryBox({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    final List<_NavItem> navItems = [
      const _NavItem(
          icon: Icons.store, label: 'Cow', route: '/list-animal-screen'),
      const _NavItem(
          icon: Icons.money, label: 'Collections', route: '/collections-items'),
      // const _NavItem(
      //     icon: Icons.money,
      //     label: 'Collections',
      //     route: '/list-collection-screen'),
      const _NavItem(
          icon: Icons.money,
          label: 'Purchase',
          route: '/select-supplier-screen'),
      const _NavItem(
          icon: Icons.money, label: 'Sale', route: '/select-customer-screen'),
      // const _NavItem(
      //     icon: Icons.description, label: 'Report', route: '/report'),
      const _NavItem(
          icon: Icons.swap_horiz,
          label: 'Material',
          route: '/select-material-screen'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: navItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 5,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) => _buildIcon(context, navItems[index]),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, _NavItem item) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, item.route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.transparent,
              child: Icon(item.icon, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem(
      {required this.icon, required this.label, required this.route});
}

class _AnimalTile extends StatelessWidget {
  final AnimalsByTypeAndGender item;

  const _AnimalTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withOpacity(0.3),
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      constraints: const BoxConstraints(minHeight: 72), // fits 3 lines
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Line 1: Animal Type = Total
          Text(
            '${item.animalType} = ${item.total}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade900,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Line 2: Male / Female counts
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.male, size: 14, color: Colors.blue.shade700),
              const SizedBox(width: 2),
              Text('M: ${item.male}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade700,
                    fontSize: 13,
                  )),
              const SizedBox(width: 10),
              Icon(Icons.female, size: 14, color: Colors.pink.shade600),
              const SizedBox(width: 2),
              Text('F: ${item.female}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.pink.shade600,
                    fontSize: 13,
                  )),
            ],
          ),

          const SizedBox(height: 4),

          // Line 3: Milk
          Text(
            'Milk: ${item.actualQty} Ltr',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey.shade700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
