// lib/screens/country_search_screen.dart
import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'dart:convert';
import '../../../data/models/country_flag_model.dart';

class CountrySearchScreen extends StatefulWidget {
  final CountryFlagModel? selectedCountry;
  final Function(CountryFlagModel) onCountrySelected;

  const CountrySearchScreen({
    super.key,
    this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountrySearchScreen> createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen> {
  List<CountryFlagModel> allCountries = [];
  List<CountryFlagModel> filteredCountries = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  String selectedCountryCode = '';

  @override
  void initState() {
    super.initState();
    selectedCountryCode = widget.selectedCountry?.countryCode ?? '';
    _loadCountries();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    try {
      Map<String, dynamic> jsonMap = json.decode(CountriesData.jsonString);
      List<dynamic> countriesList = jsonMap['countries'];
      allCountries = countriesList
          .map((country) => CountryFlagModel.fromJson(country))
          .toList();
      filteredCountries = List.from(allCountries);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading countries: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCountries = List.from(allCountries);
      } else {
        filteredCountries = allCountries.where((country) {
          return country.countryName.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              country.countryCode.contains(query) ||
              country.flag.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Select Country',
          style: TextStyle(
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
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                _buildSearchBar(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
                  child: Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      "Search Results".toUpperCase(),
                      style: context.label.copyWith(
                        color: context.textSecondaryColor,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                // Country List
                Expanded(
                  child: filteredCountries.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.grey.shade100, height: 1),
                          itemCount: filteredCountries.length,
                          itemBuilder: (context, index) {
                            CountryFlagModel country = filteredCountries[index];
                            bool isSelected =
                                selectedCountryCode == country.countryCode;
                            return _buildCountryTile(country, isSelected);
                          },
                        ),
                ),
              ],
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
          controller: searchController,
          onChanged: _filterCountries,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Search country name, code or flag...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: Icon(
              LucideIcons.search,
              color: Colors.grey.shade500,
              size: 20,
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey.shade500,
                      size: 18,
                    ),
                    onPressed: () {
                      searchController.clear();
                      _filterCountries('');
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

  Widget _buildCountryTile(CountryFlagModel country, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        leading: Text(country.flag, style: const TextStyle(fontSize: 20)),
        title: Text(
          "(${country.countryCode}) ${country.countryName}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.blue.shade700 : Colors.black87,
          ),
        ),
        trailing: isSelected
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Selected',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              )
            : null,
        onTap: () {
          setState(() {
            selectedCountryCode = country.countryCode;
          });
          widget.onCountrySelected(country);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No country found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with a different name',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
