import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class CustomImageViewer extends StatefulWidget {
  final List<XFile>? imageFiles;
  final XFile? singleImageFile;
  final String? networkImgUrl;

  final int initialIndex;
  final bool enableZoom;
  final Color backgroundColor;
  final Widget? closeButton;
  final Function(int)? onPageChanged;

  const CustomImageViewer({
    super.key,
    this.imageFiles,
    this.singleImageFile,
    this.networkImgUrl,
    this.initialIndex = 0,
    this.enableZoom = true,
    this.backgroundColor = Colors.black,
    this.closeButton,
    this.onPageChanged,
  }) : assert(
         imageFiles != null || singleImageFile != null || networkImgUrl != null,
         'Either imageFiles or singleImageFile or networkImgUrl must be provided',
       );

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  late int _currentIndex;
  late PageController _pageController;

  String? downloadedPdfPath;
  bool _isDownloadingPdf = false;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    if (widget.networkImgUrl != null && _isPdf(widget.networkImgUrl!)) {
      _downloadPdf(widget.networkImgUrl!);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<XFile> get _images {
    if (widget.imageFiles != null) {
      return widget.imageFiles!;
    } else if (widget.singleImageFile != null) {
      return [widget.singleImageFile!];
    }
    return [];
  }

  bool _isPdf(String path) {
    return path.toLowerCase().contains('.pdf');
  }

  bool _isImage(String path) {
    return path.toLowerCase().contains('.jpg') ||
        path.toLowerCase().contains('.jpeg') ||
        path.toLowerCase().contains('.png');
  }

  Future<void> _downloadPdf(String url) async {
    try {
      setState(() => _isDownloadingPdf = true);

      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF');
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/network_view.pdf');

      await file.writeAsBytes(response.bodyBytes, flush: true);

      setState(() {
        downloadedPdfPath = file.path;
        _isDownloadingPdf = false;
      });
    } catch (e) {
      debugPrint('PDF download failed: $e');
      setState(() => _isDownloadingPdf = false);
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    widget.onPageChanged?.call(index);
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      right: 16,
      child:
          widget.closeButton ??
          Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
    );
  }

  Widget _buildIndexIndicator() {
    if (_images.length <= 1) return const SizedBox();

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${_currentIndex + 1} / ${_images.length}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleImageView(XFile file) {
    return widget.enableZoom
        ? PhotoView(
            imageProvider: FileImage(File(file.path)),
            backgroundDecoration: BoxDecoration(color: widget.backgroundColor),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: file.path),
          )
        : Center(child: Image.file(File(file.path), fit: BoxFit.contain));
  }

  Widget _buildLocalPdfView(XFile file) {
    return PDFView(
      filePath: file.path,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: true,
      pageFling: true,
      onError: (error) {
        debugPrint('Local PDF error: $error');
      },
      onPageError: (page, error) {
        debugPrint('Local PDF page error: $page → $error');
      },
    );
  }

  Widget _buildGalleryView() {
    return PhotoViewGallery.builder(
      itemCount: _images.length,
      pageController: _pageController,
      onPageChanged: _onPageChanged,
      backgroundDecoration: BoxDecoration(color: widget.backgroundColor),
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: FileImage(File(_images[index].path)),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: _images[index].path),
        );
      },
    );
  }

  Widget _buildNetworkImage(String url) {
    return PhotoView(
      imageProvider: NetworkImage(url),
      backgroundDecoration: BoxDecoration(color: widget.backgroundColor),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
    );
  }

  Widget _buildNetworkPdfView() {
    if (_isDownloadingPdf) {
      return const Center(child: CircularProgressIndicator());
    }

    if (downloadedPdfPath == null) {
      return const Center(
        child: Text(
          'Failed to load PDF',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return PDFView(
      filePath: downloadedPdfPath!,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: true,
      pageFling: true,
      onError: (error) {
        debugPrint('Network PDF error: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: _images.isNotEmpty
                ? (_images.length == 1
                      ? (_isPdf(_images.first.path)
                            ? _buildLocalPdfView(_images.first)
                            : _buildSingleImageView(_images.first))
                      : _buildGalleryView())
                : widget.networkImgUrl != null
                ? (_isPdf(widget.networkImgUrl!)
                      ? _buildNetworkPdfView()
                      : _isImage(widget.networkImgUrl!)
                      ? _buildNetworkImage(widget.networkImgUrl!)
                      : const Center(
                          child: Text(
                            'Unsupported file type',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                : const SizedBox(),
          ),
          _buildCloseButton(),
          if (_images.length > 1) _buildIndexIndicator(),
        ],
      ),
    );
  }
}
