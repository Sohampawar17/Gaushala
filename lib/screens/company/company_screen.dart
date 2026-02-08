import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaushala/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../services/call_services.dart';
import 'company_viewmodel.dart';

class CompanyInfoView extends StatelessWidget {
  const CompanyInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<CompanyInfoViewModel>.reactive(
      viewModelBuilder: () => CompanyInfoViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        final company = model.company;

        return Scaffold(
          body: fullScreenLoader(
            context: context,
            loader: model.isBusy,
            child: RefreshIndicator(
              onRefresh: model.init,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(company.companyName ?? ""),
                    const SizedBox(height: 16),
                    if ((company.companyDescription ?? "").isNotEmpty)
                      _buildCard(
                        child: _buildDescription(company.companyDescription),
                      ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Stay Connected"),
                    const SizedBox(height: 12),
                    _buildSocialRow(model),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildWebsiteCard(company.website)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCallUsCard()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildAddressCard(
                      company.address?.companyAddress?.companyAddressDisplay ??
                          "",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Header with softer styling
  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow[700]!, Colors.yellow[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Common card wrapper
  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }

  Widget _buildDescription(String? description) {
    return Html(
      data: description,
      style: {
        "body": Style(
          fontSize: FontSize(15),
          lineHeight: LineHeight(1.5),
          color: Colors.black87,
        ),
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.yellow[800],
      ),
    );
  }

  /// Social row (smaller, neat icons)
  Widget _buildSocialRow(CompanyInfoViewModel model) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildSocialMediaIcon(
          icon: FontAwesomeIcons.facebookF,
          onPressed: () => _launchUrl(model.company.facebook),
        ),
        _buildSocialMediaIcon(
          icon: FontAwesomeIcons.instagram,
          onPressed: () => _launchUrl(model.company.instagram),
        ),
        _buildSocialMediaIcon(
          icon: FontAwesomeIcons.youtube,
          onPressed: () => _launchUrl(model.company.youtube),
        ),
        _buildSocialMediaIcon(
          icon: Icons.phone,
          onPressed: () =>
              CallsAndMessagesService().call(model.company.phoneNo ?? ""),
        ),
        _buildSocialMediaIcon(
          icon: Icons.email,
          onPressed: () =>
              CallsAndMessagesService().sendEmail(model.company.email ?? ""),
        ),
      ],
    );
  }

  Widget _buildSocialMediaIcon({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.yellow[100],
        child: Icon(icon, color: Colors.yellow[800], size: 20),
      ),
    );
  }

  Widget _buildCallUsCard() {
    return _buildCard(
      child: Column(
        children: const [
          Text(
            'Call Us',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '10:00 AM - 6:00 PM (Mon–Sat)',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWebsiteCard(String? website) {
    return _buildCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.yellow[100],
          child: Icon(Icons.web, color: Colors.yellow[800], size: 20),
        ),
        title: const Text(
          'Visit Website',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        trailing: Icon(Icons.open_in_new, color: Colors.yellow[800], size: 18),
        onTap: () => _launchUrl(website),
      ),
    );
  }

  Widget _buildAddressCard(String? address) {
    return _buildCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.yellow[100],
            child: Icon(Icons.location_on, color: Colors.yellow[800], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Html(
              data: address ?? "No address available.",
              style: {
                "body": Style(fontSize: FontSize(14), color: Colors.black87),
              },
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String? url) {
    if (url != null && url.isNotEmpty) {
      CallsAndMessagesService().launchInWebView(Uri.parse(url));
    }
  }
}
