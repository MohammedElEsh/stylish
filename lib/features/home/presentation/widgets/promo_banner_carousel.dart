import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../onboarding/presentation/widgets/onboarding_dots.dart';
import 'promo_banner_card.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({
    super.key,
    this.itemCount = 3,
    this.aspectRatio = 16 / 10,
    this.onBannerTap,
  });

  final int itemCount;
  final double aspectRatio;
  final ValueChanged<int>? onBannerTap;

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    final next = _controller.page?.round() ?? 0;
    if (next != _currentPage) {
      setState(() => _currentPage = next);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              return PromoBannerCard(
                onTap: () => widget.onBannerTap?.call(index),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        OnboardingDots(
          count: widget.itemCount,
          currentIndex: _currentPage,
        ),
      ],
    );
  }
}
