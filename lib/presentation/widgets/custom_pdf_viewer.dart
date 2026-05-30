// ignore_for_file: dead_code

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:image_picker/image_picker.dart';

class CustomNetworkPdfViewer extends StatefulWidget {
  final String pdfUrl;
  final XFile? xfile; // optional local XFile
  final Map<String, String>? headers;
  final String? appBarTitle;
  final bool showAppBar;
  final bool enableTextSelection;
  final bool enableDoubleTapZoom;
  final Color? progressIndicatorColor;

  const CustomNetworkPdfViewer({
    super.key,
    required this.pdfUrl,
    this.xfile,
    this.headers,
    this.appBarTitle = 'PDF Viewer',
    this.showAppBar = true,
    this.enableTextSelection = true,
    this.enableDoubleTapZoom = true,
    this.progressIndicatorColor,
  });

  @override
  State<CustomNetworkPdfViewer> createState() => _CustomNetworkPdfViewerState();
}

class _CustomNetworkPdfViewerState extends State<CustomNetworkPdfViewer> {
  late PdfViewerController _pdfViewerController;

  bool _isLoading = true;
  bool _isFullScreen = false;
  double _zoomLevel = 1.0;
  int _currentPage = 1;
  int _totalPages = 0;
  String? _errorMessage;

  bool isPdf = true; // determines whether to show PDF or image
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _detectFileTypeAndPrepare();
  }

  // Detect file type and prepare image provider if needed
  void _detectFileTypeAndPrepare() {
    // If XFile provided, prefer that (could be local image or pdf)
    if (widget.xfile != null) {
      final pathLower = widget.xfile!.path.toLowerCase();
      if (pathLower.endsWith('.pdf')) {
        isPdf = true;
        _isLoading = true;
      } else if (pathLower.endsWith('.jpg') ||
          pathLower.endsWith('.jpeg') ||
          pathLower.endsWith('.png') ||
          pathLower.endsWith('.webp') ||
          pathLower.endsWith('.gif') ||
          pathLower.endsWith('.bmp')) {
        isPdf = false;
        _imageProvider = FileImage(File(widget.xfile!.path));
        _resolveImageProvider();
      } else {
        // unknown extension on XFile — try treating as image
        isPdf = false;
        _imageProvider = FileImage(File(widget.xfile!.path));
        _resolveImageProvider();
      }
      return;
    }

    // No XFile — use widget.pdfUrl (may be an image URL)
    final url = widget.pdfUrl.trim().toLowerCase();

    if (url.endsWith('.pdf')) {
      isPdf = true;
      _isLoading = true;
    } else if (url.endsWith('.jpg') ||
        url.endsWith('.jpeg') ||
        url.endsWith('.png') ||
        url.endsWith('.webp') ||
        url.endsWith('.gif') ||
        url.endsWith('.bmp')) {
      isPdf = false;
      _imageProvider = NetworkImage(widget.pdfUrl);
      _resolveImageProvider();
    } else {
      // If extension unknown, try to be forgiving: assume PDF first (to keep original behavior).
      // But still try to prepare as image if network image loads — we will catch errors and show message.
      isPdf = true;
      _isLoading = true;
    }
  }

  // Resolves image provider to know when image is loaded / failed
  void _resolveImageProvider() {
    if (_imageProvider == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unsupported or missing image provider';
      });
      return;
    }

    _isLoading = true;
    final ImageStream stream = _imageProvider!.resolve(
      const ImageConfiguration(),
    );
    late ImageStreamListener listener;
    listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        // success
        stream.removeListener(listener);
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = null;
          });
        }
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        stream.removeListener(listener);
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Failed to load image';
          });
        }
      },
    );
    stream.addListener(listener);
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 0.25).clamp(0.5, 3.0);
      if (isPdf) _pdfViewerController.zoomLevel = _zoomLevel;
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 0.25).clamp(0.5, 3.0);
      if (isPdf) _pdfViewerController.zoomLevel = _zoomLevel;
    });
  }

  void _resetZoom() {
    setState(() {
      _zoomLevel = 1.0;
      if (isPdf) _pdfViewerController.zoomLevel = _zoomLevel;
    });
  }

  void _goToPage(int pageNumber) {
    if (!isPdf) return;
    if (pageNumber >= 1 && pageNumber <= _totalPages) {
      _pdfViewerController.jumpToPage(pageNumber);
    }
  }

  void _showPageDialog() {
    if (!isPdf) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Go to Page', style: TextStyle(color: Colors.white)),
        content: TextField(
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter page number (1-$_totalPages)',
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onSubmitted: (value) {
            final pageNumber = int.tryParse(value);
            if (pageNumber != null) {
              _goToPage(pageNumber);
            }
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    if (!widget.showAppBar || _isFullScreen) {
      return null;
    }

    return AppBar(
      title: Text(
        widget.appBarTitle!,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.black87,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
            color: Colors.white,
          ),
          onPressed: _toggleFullScreen,
          tooltip: _isFullScreen ? 'Exit Fullscreen' : 'Enter Fullscreen',
        ),
        if (isPdf)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _showPageDialog,
            tooltip: 'Go to Page',
          ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          color: Colors.grey[900],
          onSelected: (value) {
            switch (value) {
              case 'first_page':
                if (isPdf) _pdfViewerController.firstPage();
                break;
              case 'last_page':
                if (isPdf) _pdfViewerController.lastPage();
                break;
              case 'zoom_reset':
                _resetZoom();
                break;
            }
          },
          itemBuilder: (context) => [
            if (isPdf)
              const PopupMenuItem(
                value: 'first_page',
                child: Row(
                  children: [
                    Icon(Icons.first_page, color: Colors.white),
                    SizedBox(width: 8),
                    Text('First Page', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            if (isPdf)
              const PopupMenuItem(
                value: 'last_page',
                child: Row(
                  children: [
                    Icon(Icons.last_page, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Last Page', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 'zoom_reset',
              child: Row(
                children: [
                  Icon(Icons.zoom_out_map, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Reset Zoom', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    if (_isFullScreen || _errorMessage != null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.zoom_out, color: Colors.white),
            onPressed: _zoomOut,
            tooltip: 'Zoom Out',
          ),
          Text(
            '${_zoomLevel.toStringAsFixed(1)}x',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, color: Colors.white),
            onPressed: _zoomIn,
            tooltip: 'Zoom In',
          ),
          if (isPdf)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_currentPage / $_totalPages',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bookmark feature coming soon!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            tooltip: 'Add Bookmark',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.progressIndicatorColor ?? Colors.blue,
              ),
              strokeWidth: 3,
            ),
            const SizedBox(height: 20),
            Text(
              _isLoading ? 'Loading...' : 'Preparing...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 20),
              const Text(
                'Failed to load file',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _errorMessage ?? 'Unknown error occurred',
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                    // retry: re-run detection & preload
                    _detectFileTypeAndPrepare();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
              const SizedBox(height: 10),
              Text(
                'URL: ${widget.pdfUrl}',
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.black, // This changes the PDF viewer background
      ),
      child: SfPdfViewer.network(
        widget.pdfUrl,
        controller: _pdfViewerController,
        headers: widget.headers,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _totalPages = details.document.pages.count;
              _errorMessage = null;
            });
          }
        },
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _errorMessage = details.error.toString();
            });
          }
        },
        onPageChanged: (PdfPageChangedDetails details) {
          if (mounted) {
            setState(() {
              _currentPage = details.newPageNumber;
            });
          }
        },
        enableDoubleTapZooming: widget.enableDoubleTapZoom,
        enableTextSelection: widget.enableTextSelection,
        pageLayoutMode: PdfPageLayoutMode.single,
        scrollDirection: PdfScrollDirection.vertical,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        interactionMode: PdfInteractionMode.pan,
      ),
    );
  }

  Widget _buildImageViewer() {
    if (_imageProvider == null) {
      // if imageProvider missing, show an error
      return Center(
        child: Text(
          _errorMessage ?? 'Image not available',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return PhotoView(
      imageProvider: _imageProvider!,
      backgroundDecoration: const BoxDecoration(color: Colors.black),
      loadingBuilder: (context, event) => _buildLoadingIndicator(),
      errorBuilder: (context, error, stack) {
        return Center(
          child: Text(
            _errorMessage ?? "Failed to load image",
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Show appropriate viewer
          if (isPdf) _buildPdfViewer() else _buildImageViewer(),

          if (_isLoading) _buildLoadingIndicator(),

          if (_errorMessage != null) _buildErrorWidget(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _isFullScreen && _errorMessage == null
          ? FloatingActionButton(
              onPressed: _toggleFullScreen,
              backgroundColor: Colors.blue,
              tooltip: 'Exit Fullscreen',
              child: const Icon(Icons.fullscreen_exit, color: Colors.white),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }
}
