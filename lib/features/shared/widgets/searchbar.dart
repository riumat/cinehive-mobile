import 'package:flutter/material.dart';

class CustomSearchbar extends StatefulWidget {
  final String? defaultQuery;
  final Function(String)? onSearch;
  final String hintText;

  const CustomSearchbar({
    super.key,
    this.defaultQuery,
    this.onSearch,
    this.hintText = 'Search titles...',
  });

  @override
  State<CustomSearchbar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchbar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.defaultQuery ?? '');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: SizedBox(width: 5, height: 5, child: Icon(Icons.search)),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.purple[200]?.withAlpha(50),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 15),
      onSubmitted: (value) {
        if (widget.onSearch != null) {
          widget.onSearch!(value.trim());
        }
      },
    );
  }
}
