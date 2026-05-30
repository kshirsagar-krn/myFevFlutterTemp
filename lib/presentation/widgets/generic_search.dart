// lib/screens/generic_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class GenericSearchScreen<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final Function(T) onItemSelected;

  /// Required: primary text shown in the list tile title
  final String Function(T) itemTitle;

  /// Optional: secondary text shown below title
  final String? Function(T)? itemSubtitle;

  /// Optional: widget shown as leading (e.g. flag emoji, avatar, icon)
  final Widget? Function(T)? itemLeading;

  /// Optional: used to compare which item is "selected"
  /// Defaults to equality (==)
  final bool Function(T a, T b)? equalityCheck;

  /// Optional: which fields to search against.
  /// Defaults to [itemTitle] only.
  final List<String> Function(T)? searchFields;

  /// UI customisation
  final String screenTitle;
  final String searchHint;
  final String sectionLabel;
  final Color? selectedColor;

  const GenericSearchScreen({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.itemTitle,
    this.selectedItem,
    this.itemSubtitle,
    this.itemLeading,
    this.equalityCheck,
    this.searchFields,
    this.screenTitle = 'Select',
    this.searchHint = 'Search...',
    this.sectionLabel = 'SEARCH RESULTS',
    this.selectedColor,
  });

  @override
  State<GenericSearchScreen<T>> createState() => _GenericSearchScreenState<T>();
}

class _GenericSearchScreenState<T> extends State<GenericSearchScreen<T>> {
  late List<T> _filtered;
  final TextEditingController _searchController = TextEditingController();
  T? _selectedItem;

  Color get _accentColor => widget.selectedColor ?? Colors.blue.shade600;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
    _filtered = List<T>.from(widget.items);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _isSelected(T item) {
    if (_selectedItem == null) return false;
    if (widget.equalityCheck != null) {
      return widget.equalityCheck!(_selectedItem as T, item);
    }
    return _selectedItem == item;
  }

  void _filter(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filtered = List<T>.from(widget.items);
        return;
      }
      final q = query.toLowerCase();
      _filtered = widget.items.where((item) {
        // Use custom searchFields if provided
        final fields = widget.searchFields != null
            ? widget.searchFields!(item)
            : [widget.itemTitle(item)];
        return fields.any((field) => field.toLowerCase().contains(q));
      }).toList();
    });
  }

  void _onTap(T item) {
    setState(() => _selectedItem = item);
    widget.onItemSelected(item);
    Navigator.pop(context);
  }

  // ─────────────────────────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 8),
          _buildSectionLabel(),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        widget.screenTitle,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _filter,
          autofocus: false,
          decoration: InputDecoration(
            hintText: widget.searchHint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: Icon(
              LucideIcons.search,
              color: Colors.grey.shade500,
              size: 20,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey.shade500,
                      size: 18,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _filter('');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
      child: Text(
        widget.sectionLabel,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade500,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_filtered.isEmpty) return _buildEmptyState();
    return ListView.separated(
      itemCount: _filtered.length,
      separatorBuilder: (_, _) =>
          Divider(color: Colors.grey.shade100, height: 1),
      itemBuilder: (context, index) {
        final item = _filtered[index];
        return _buildTile(item, _isSelected(item));
      },
    );
  }

  Widget _buildTile(T item, bool isSelected) {
    final leading = widget.itemLeading?.call(item);
    final subtitle = widget.itemSubtitle?.call(item);

    return Container(
      color: isSelected ? _accentColor.withOpacity(0.08) : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        // ── Leading ──────────────────────────────────────────────────
        leading: leading,
        // ── Title + optional subtitle ─────────────────────────────────
        title: Text(
          widget.itemTitle(item),
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? _accentColor : Colors.black87,
          ),
        ),
        subtitle: subtitle != null && subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ? _accentColor.withOpacity(0.8)
                      : Colors.grey.shade600,
                ),
              )
            : null,
        // ── Trailing "Selected" badge ─────────────────────────────────
        trailing: isSelected ? _selectedBadge() : null,
        onTap: () => _onTap(item),
      ),
    );
  }

  Widget _selectedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Text('Selected', style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
