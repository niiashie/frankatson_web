import 'package:flutter/material.dart';
import 'package:frankoweb/constants/api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/docs/docs_view_model.dart';
import 'package:frankoweb/ui/docs/widget/docs_app_bar.dart';
import 'package:frankoweb/ui/docs/widget/document_list.dart';
import 'package:frankoweb/ui/docs/widget/document_upload_form.dart';
import 'package:stacked/stacked.dart';

class DocumentScreenView extends StackedView<DocViewModel> {
  const DocumentScreenView({super.key});

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(DocViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, DocViewModel viewModel, Widget? child) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(isWide),
                Visibility(
                  visible: !viewModel.showAddDocument,
                  replacement: DocumentUploadForm(
                    formKey: viewModel.docKey,
                    titleController: viewModel.title,
                    filename: viewModel.filename,
                    isLoading: viewModel.uploadDocumentLoading,
                    onPickFile: viewModel.pickFile,
                    onSubmit: viewModel.uploadFile,
                    onBack: viewModel.backToDocuments,
                  ),
                  child: DocumentList(
                    isLoading: viewModel.getDocumentLoading,
                    docList: viewModel.docList,
                    isWide: isWide,
                    getFileExtension: viewModel.getFileExtension,
                    onDownload: (doc) => viewModel.viewFileInNewTab(
                        "${Api.dataUrl}${doc['file']}", "${doc['title']}"),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          DocsAppBar(
            isScrolled: viewModel.isScrolled,
            isWide: isWide,
            onHomeTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      floatingActionButton: MediaQuery.of(context).size.width >= 800 &&
              viewModel.isAdmin
          ? Visibility(
              visible: !viewModel.showAddDocument,
              child: FloatingActionButton.extended(
                backgroundColor: AppColors.gradient2,
                onPressed: viewModel.viewAddDocument,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Add Document",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.poppinsMedium)),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildHero(bool isWide) {
    return SizedBox(
      width: double.infinity,
      height: isWide ? 420 : 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFFFC8E4),
                  AppColors.gradient2,
                  AppColors.gradient1,
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          Positioned(
            right: isWide ? -20 : -50,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.folder_open_outlined,
                color: Colors.white,
                size: isWide ? 360 : 240,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 100 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.folder_open_outlined,
                          color: Colors.white, size: 38),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Library",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.poppinsBold,
                      fontSize: isWide ? 44 : 26,
                      letterSpacing: 0.5,
                      shadows: const [
                        Shadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 3)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Company documents, reports and resources from Frankatson Ghana",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: AppFonts.poppinsLight,
                      fontSize: isWide ? 18 : 13,
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

  @override
  DocViewModel viewModelBuilder(BuildContext context) => DocViewModel();
}
