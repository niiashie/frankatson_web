import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';

class DocumentUploadForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final String filename;
  final bool isLoading;
  final VoidCallback onPickFile;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const DocumentUploadForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.filename,
    required this.isLoading,
    required this.onPickFile,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24, vertical: isWide ? 60 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Document",
            style: TextStyle(
              color: AppColors.gradient2,
              fontFamily: AppFonts.poppinsBold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2]),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Fill in the details required to add a document",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 32),
          Center(
            child: Container(
              width: isWide ? 480 : double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 3))
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 2,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(AppImages.logo,
                              width: 56, height: 56),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      hintText: "Enter document name",
                      label: " Title",
                      filled: true,
                      controller: titleController,
                      fillColor: const Color(0xFFF8F8F8),
                      prefixIcon: const Icon(Icons.title_outlined,
                          size: 15, color: Colors.grey),
                      validator: (String? value) {
                        if (value!.isEmpty) return "Title is required.";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        border:
                            Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                filename,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13),
                              ),
                            ),
                          ),
                          CustomButton(
                            width: 120,
                            height: 40,
                            color: AppColors.gradient1,
                            title: const Text("Choose File",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)),
                            ontap: onPickFile,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      width: double.infinity,
                      maxWidth: double.infinity,
                      height: 46,
                      isLoading: isLoading,
                      color: AppColors.gradient2,
                      title: const Text("Upload Document",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppFonts.poppinsMedium)),
                      elevation: 2,
                      ontap: onSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: InkWell(
              onTap: onBack,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back,
                      color: AppColors.gradient2.withValues(alpha: 0.7),
                      size: 14),
                  const SizedBox(width: 8),
                  Text(
                    "Back To Library",
                    style: TextStyle(
                      color: AppColors.gradient2.withValues(alpha: 0.7),
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
