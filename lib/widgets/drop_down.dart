import 'package:flutter/material.dart';

class SearchableDropdownField<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? selectedItem;
  final void Function(T?) onChanged;
  final String Function(T) itemAsString;
  final bool isRequired;
  final double fontSize;

  const SearchableDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemAsString,
    this.isRequired = false,
    this.fontSize = 14,
  });

  @override
  State<SearchableDropdownField<T>> createState() =>
      _SearchableDropdownFieldState<T>();
}

class _SearchableDropdownFieldState<T>
    extends State<SearchableDropdownField<T>> {
  late T? _selected;
  late TextEditingController _searchController;
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedItem;
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant SearchableDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem) {
      setState(() {
        _selected = widget.selectedItem;
      });
    }
    if (oldWidget.items != widget.items) {
      _filteredItems = widget.items;
    }
  }

  void _openSearchDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.8,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (_, scrollController) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 🔍 Search bar with modern look
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[700]),
                          border: InputBorder.none,
                          // contentPadding:
                          //     const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (query) {
                          setState(() {
                            _filteredItems = widget.items
                                .where((item) => widget
                                    .itemAsString(item)
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _filteredItems.isEmpty
                          ? const Center(child: Text("No results found"))
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: _filteredItems.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final item = _filteredItems[index];
                                final isSelected = _selected == item;
                                return ListTile(
                                  leading: isSelected
                                      ? const Icon(Icons.check_circle,
                                          color: Colors.green)
                                      : const Icon(Icons.circle_outlined,
                                          color: Colors.grey),
                                  title: Text(
                                    widget.itemAsString(item),
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selected = item;
                                      widget.onChanged(item);
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: _openSearchDialog,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      controller: TextEditingController(
        text: _selected != null ? widget.itemAsString(_selected!) : '',
      ),
      style: TextStyle(fontSize: widget.fontSize),
    );
  }
}
