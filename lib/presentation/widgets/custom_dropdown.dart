import 'package:flutter/material.dart';
import '../../data/constant/app_color.dart';
import 'custom_decoration.dart';

class CustomDropdown<T> extends FormField<T> {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?)? onChanged;
  final T? value;
  final String hintText;
  final IconData? prefixIcon;

  CustomDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.value,
    required this.hintText,
    this.prefixIcon,
    super.onSaved,
    super.validator,
  }) : super(
          initialValue: value,
          builder: (FormFieldState<T> state) {
            final context = state.context;
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final surfaceColor = isDark ? AppColor.darkSurface : AppColor.lightSurface;
            final textColor = isDark ? AppColor.textPrimaryDark : AppColor.textPrimaryLight;
            final hintColor = Theme.of(context).hintColor.withOpacity(0.4);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDecorator(
                  decoration: CustomDecoration.input(
                    context: context,
                    hintText: hintText,
                    prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
                  ).copyWith(
                    errorText: state.errorText,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      value: state.value,
                      isExpanded: true,
                      hint: Text(
                        hintText,
                        style: TextStyle(
                          color: hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                      ),
                      dropdownColor: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      items: items.map((T item) {
                        return DropdownMenuItem<T>(
                          value: item,
                          child: Text(
                            itemLabel(item),
                            style: TextStyle(color: textColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (T? newValue) {
                        state.didChange(newValue);
                        if (onChanged != null) {
                          onChanged(newValue);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
}
