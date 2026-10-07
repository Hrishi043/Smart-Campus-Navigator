import 'package:flutter/material.dart';
import '../models/place.dart';

class SearchModal extends StatefulWidget {
  final List<CampusPlace> places;
  final Function(CampusPlace place) onPlaceSelected;

  const SearchModal({
    super.key,
    required this.places,
    required this.onPlaceSelected,
  });

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  final TextEditingController _searchCtrl = TextEditingController();
  PlaceCategory? _selectedCategory;
  List<CampusPlace> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = widget.places;
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchCtrl.text;
    setState(() {
      _filteredPlaces = widget.places.where((p) {
        final matchesCat =
            _selectedCategory == null || p.category == _selectedCategory;
        final matchesQuery = p.matchesQuery(query);
        return matchesCat && matchesQuery;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 44,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Search Bar Field
              TextField(
                controller: _searchCtrl,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Search departments, labs, canteen, statue...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () => _searchCtrl.clear(),
                        )
                      : null,
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Category Filter Pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: _selectedCategory == null,
                      onSelected: (_) {
                        setState(() => _selectedCategory = null);
                        _onSearchChanged();
                      },
                    ),
                    const SizedBox(width: 6),
                    ...PlaceCategory.values.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: FilterChip(
                          avatar: Icon(cat.icon, size: 14),
                          label: Text(cat.label),
                          selected: _selectedCategory == cat,
                          onSelected: (sel) {
                            setState(() => _selectedCategory = sel ? cat : null);
                            _onSearchChanged();
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Results Count
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_filteredPlaces.length} places found',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // Search Results List
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
                child: _filteredPlaces.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_off_rounded,
                              size: 48,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'No matching campus places found',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Try searching for "EC", "Mech", "Canteen", "Library", or "Statue"',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: _filteredPlaces.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final place = _filteredPlaces[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  place.category.color.withValues(alpha: 0.15),
                              child: Icon(
                                place.category.icon,
                                color: place.category.color,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              place.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '${place.category.label} • Code: ${place.shortCode}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              widget.onPlaceSelected(place);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
