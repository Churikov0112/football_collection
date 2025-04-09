import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum ScaleEffectLongPressFeedback {
  heavyImpact,
  lightImpact,
  mediumImpact,
  none,
  selectionClick,
  vibrate,
}

class TouchableScale extends StatefulWidget {
  final Duration animationDuration;
  final Widget child;
  final double effectValue;
  final bool isActive;
  final ScaleEffectLongPressFeedback? longPressFeedback;
  final Duration pressInDuration;
  final Duration pressOutDuration;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const TouchableScale({
    required this.child,
    this.effectValue = 0.98,
    this.onPressed,
    this.onLongPressed,
    this.animationDuration = const Duration(milliseconds: 200),
    this.longPressFeedback = ScaleEffectLongPressFeedback.lightImpact,
    this.pressInDuration = const Duration(milliseconds: 50),
    this.pressOutDuration = const Duration(milliseconds: 100),
    this.isActive = true,
    super.key,
  });

  @override
  _TouchableScaleState createState() => _TouchableScaleState();
}

class _TouchableScaleState extends State<TouchableScale> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation _animation;

  bool _buttonHeldDown = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      value: 0.0,
      vsync: this,
    );

    _animation = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animationController!,
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails _) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleOnTap() {
    widget.onPressed?.call();
  }

  void _handleOnLongPress() {
    if (widget.longPressFeedback != null && widget.onLongPressed != null) {
      switch (widget.longPressFeedback) {
        case ScaleEffectLongPressFeedback.heavyImpact:
          HapticFeedback.heavyImpact();
          break;
        case ScaleEffectLongPressFeedback.lightImpact:
          HapticFeedback.lightImpact();
          break;
        case ScaleEffectLongPressFeedback.mediumImpact:
          HapticFeedback.mediumImpact();
          break;
        case ScaleEffectLongPressFeedback.none:
          break;
        case ScaleEffectLongPressFeedback.selectionClick:
          HapticFeedback.selectionClick();
          break;
        case ScaleEffectLongPressFeedback.vibrate:
          HapticFeedback.vibrate();
          break;
        default:
          return;
      }
    }

    widget.onLongPressed?.call();
  }

  void _animate() {
    if (_animationController?.isAnimating == true) {
      return;
    }

    final wasHeldDown = _buttonHeldDown;
    final ticker = _buttonHeldDown
        ? _animationController?.animateTo(1.0, duration: widget.pressInDuration, curve: Curves.easeIn)
        : _animationController?.animateTo(0.0, duration: widget.pressOutDuration, curve: Curves.easeOut);

    ticker?.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.isActive ? _handleTapDown : null,
      onTapUp: widget.isActive ? _handleTapUp : null,
      onTapCancel: widget.isActive ? _handleTapCancel : null,
      onTap: widget.isActive ? _handleOnTap : null,
      onLongPress: widget.isActive ? _handleOnLongPress : null,
      child: ScaleTransition(
        scale: _animation.drive(Tween(begin: 1, end: widget.effectValue)),
        child: widget.child,
      ),
    );
  }
}
