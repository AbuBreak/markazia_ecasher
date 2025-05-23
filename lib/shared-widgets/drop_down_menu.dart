import 'package:flutter/material.dart';
import 'package:markazia_ecasher/providers/branch_provider.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const CustomDropDown({super.key, this.initialValue, required this.onChanged});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  void _showDropdown() {
    if (_isDropdownOpen) return;
    _isDropdownOpen = true;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeDropdown() {
    if (!_isDropdownOpen) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4,
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 250),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Consumer<BranchProvider>(
                  builder: (context, provider, _) {
                    final filtered = provider.filteredOptions;
                    return ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children:
                          filtered.isEmpty
                              ? const [
                                ListTile(
                                  title: Text(
                                    'No results found',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ]
                              : filtered.map((option) {
                                return ListTile(
                                  title: Text(
                                    option,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    _controller.text = option;
                                    widget.onChanged(option);
                                    Provider.of<BranchProvider>(
                                      context,
                                      listen: false,
                                    ).setSelectedBranch(option);
                                    _removeDropdown();
                                    _focusNode.unfocus();
                                  },
                                );
                              }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _removeDropdown();
    super.dispose();
  }

  void _onChanged(String value) {
    final provider = Provider.of<BranchProvider>(context, listen: false);
    provider.filterOptions(value);
    widget.onChanged(value);

    if (!_isDropdownOpen && _focusNode.hasFocus) {
      _showDropdown();
    }

    if (_isDropdownOpen) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Choose Branch',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                onChanged: _onChanged,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_isDropdownOpen) {
                  _removeDropdown();
                  _focusNode.unfocus();
                } else {
                  _focusNode.requestFocus();
                  _showDropdown();
                }
              },
              child: const Icon(Icons.arrow_drop_down, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
