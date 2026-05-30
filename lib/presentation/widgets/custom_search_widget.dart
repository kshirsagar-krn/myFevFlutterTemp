import 'package:flutter/material.dart';

class CustomSearchWidget<T> extends StatelessWidget {
  final List<T> items;
  final String hintText;
  final bool enableSearch;
  final Widget Function(T item) searchItemBuilder;
  final Function(T)? onSelectedItem;
  final Function(List<T>)? onSelectedMultipleItems;
  final bool enableMultiSelect;
  final Widget child;

  const CustomSearchWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.enableSearch = true,
    required this.searchItemBuilder,
    this.onSelectedItem,
    this.onSelectedMultipleItems,
    this.enableMultiSelect = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSearchScreen(context),
      child: child,
    );
  }

  void _openSearchScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomSearchScreen<T>(
          items: items,
          hintText: hintText,
          enableSearch: enableSearch,
          searchItemBuilder: searchItemBuilder,
          onSelectedItem: onSelectedItem,
          onSelectedMultipleItems: onSelectedMultipleItems,
          enableMultiSelect: enableMultiSelect,
        ),
      ),
    );
  }
}

class CustomSearchScreen<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final bool enableSearch;
  final Widget Function(T item) searchItemBuilder;
  final Function(T)? onSelectedItem;
  final Function(List<T>)? onSelectedMultipleItems;
  final bool enableMultiSelect;

  const CustomSearchScreen({
    super.key,
    required this.items,
    required this.hintText,
    this.enableSearch = true,
    required this.searchItemBuilder,
    this.onSelectedItem,
    this.onSelectedMultipleItems,
    this.enableMultiSelect = false,
  });

  @override
  State<CustomSearchScreen<T>> createState() => _CustomSearchScreenState<T>();
}

class _CustomSearchScreenState<T> extends State<CustomSearchScreen<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];
  final List<T> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
    _searchController.addListener(_handleSearchChange);
  }

  void _handleSearchChange() {
    if (_searchController.text.isNotEmpty) {
      final searchText = _searchController.text.toLowerCase();
      setState(() {
        _filteredItems = widget.items.where((item) {
          final itemText = item.toString().toLowerCase();
          return itemText.contains(searchText);
        }).toList();
      });
    } else {
      setState(() {
        _filteredItems = List.from(widget.items);
      });
    }
  }

  void _selectItem(T item) {
    if (widget.enableMultiSelect) {
      setState(() {
        if (_selectedItems.contains(item)) {
          _selectedItems.remove(item);
        } else {
          _selectedItems.add(item);
        }
      });
    } else {
      widget.onSelectedItem?.call(item);
      Navigator.of(context).pop(item);
    }
  }

  void _confirmMultipleSelection() {
    widget.onSelectedMultipleItems?.call(_selectedItems);
    Navigator.of(context).pop(_selectedItems);
  }

  void _clearSelection() {
    setState(() {
      _selectedItems.clear();
    });
  }

  bool _isItemSelected(T item) {
    return _selectedItems.contains(item);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Search ${widget.hintText}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (widget.enableMultiSelect && _selectedItems.isNotEmpty) ...[
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearSelection,
              tooltip: 'Clear selection',
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _confirmMultipleSelection,
              tooltip: 'Confirm selection',
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search Field
          if (widget.enableSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                  ),
                ),
              ),
            ),
          // Selection Info (for multi-select)
          if (widget.enableMultiSelect && _selectedItems.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.blue.shade50,
              child: Text(
                '${_selectedItems.length} item${_selectedItems.length > 1 ? 's' : ''} selected',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          // Results List
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'No items found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: Colors.grey.shade300),
                      );
                    },
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        leading: widget.enableMultiSelect
                            ? Checkbox(
                                value: _isItemSelected(item),
                                onChanged: (value) => _selectItem(item),
                              )
                            : null,
                        title: widget.searchItemBuilder(item),
                        trailing: !widget.enableMultiSelect
                            ? null
                            : _isItemSelected(item)
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () => _selectItem(item),
                      );
                    },
                  ),
          ),
          // Confirm Button (for multi-select)
          if (widget.enableMultiSelect)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _selectedItems.isNotEmpty
                    ? _confirmMultipleSelection
                    : null,
                child: Text(
                  'Select ${_selectedItems.length} item${_selectedItems.length > 1 ? 's' : ''}',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
