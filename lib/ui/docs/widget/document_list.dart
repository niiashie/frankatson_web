import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';

class DocumentList extends StatelessWidget {
  final bool isLoading;
  final List<dynamic> docList;
  final bool isWide;
  final String Function(String fileName) getFileExtension;
  final void Function(Map<String, dynamic> doc) onDownload;

  const DocumentList({
    super.key,
    required this.isLoading,
    required this.docList,
    required this.isWide,
    required this.getFileExtension,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 60 : 44,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            effect: RevealEffect.slideRight,
            child: Text(
              "Document Library",
              style: TextStyle(
                color: AppColors.gradient2,
                fontFamily: AppFonts.poppinsBold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Reveal(
            effect: RevealEffect.zoomIn,
            scale: 0.1,
            delay: const Duration(milliseconds: 120),
            child: Container(
              width: 50,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.gradient1, AppColors.gradient2]),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          const SizedBox(height: 36),
          // Cross-fade between the spinner, the empty state and the results
          // so the list does not snap into place when a request lands.
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: isLoading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                              color: AppColors.gradient2, strokeWidth: 2),
                          SizedBox(height: 16),
                          Text("Loading documents...",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  )
                : docList.isEmpty
                    ? const SizedBox(
                        key: ValueKey('empty'),
                        height: 200,
                        child: Center(
                          child: Text("No documents yet.",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                      )
                    : Wrap(
                        key: const ValueKey('docs'),
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: docList.indexed.map((entry) {
                          final data = entry.$2 as Map<String, dynamic>;
                          return Reveal.staggered(
                            index: entry.$1,
                            effect: RevealEffect.zoomIn,
                            step: const Duration(milliseconds: 70),
                            child: _DocumentCard(
                              doc: data,
                              isWide: isWide,
                              getFileExtension: getFileExtension,
                              onDownload: () => onDownload(data),
                            ),
                          );
                        }).toList(),
                      ),
          ),
        ],
      ),
    );
  }
}

class _DocumentCard extends StatefulWidget {
  final Map<String, dynamic> doc;
  final bool isWide;
  final String Function(String fileName) getFileExtension;
  final VoidCallback onDownload;

  const _DocumentCard({
    required this.doc,
    required this.isWide,
    required this.getFileExtension,
    required this.onDownload,
  });

  @override
  State<_DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<_DocumentCard> {
  bool _hovered = false;

  Color _badgeColor(String ext) {
    switch (ext) {
      case "pptx":
        return Colors.orange;
      case "pdf":
        return Colors.red;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.isWide ? 320.0 : double.infinity;
    final ext = widget.getFileExtension("${widget.doc['file']}");

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.gradient2.withValues(alpha: 0.16)
                  : Colors.grey.withValues(alpha: 0.1),
              blurRadius: _hovered ? 24 : 12,
              spreadRadius: _hovered ? 2 : 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: _badgeColor(ext),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  ext,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.doc['title']}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: AppFonts.poppinsMedium,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "posted by ${widget.doc['user']?['name'] ?? 'Frankatson'}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: widget.onDownload,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.gradient2.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_downward,
                    color: AppColors.gradient2, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
