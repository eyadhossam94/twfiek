import 'package:flutter/material.dart';
import 'package:twfiek/app%20%20widgets/auth_widgets.dart';
import 'package:twfiek/screen/profile.dart';
import 'package:twfiek/screen/category_page.dart';
import 'package:twfiek/screen/utility_pages.dart';
import 'package:twfiek/shared/big_card.dart';
import 'package:twfiek/shared/small_card.dart';
import 'package:twfiek/shared/textfield_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _bg = Color(0xFFF7F6FB);
  static const _ink = Color(0xFF25212B);
  static const _brand = Color(0xff47287E);

  final TextEditingController searchController = TextEditingController();

  // Shows the little dot on the notification button.
  final bool _hasUnread = true;
  String _searchQuery = '';

  // -1 = nothing selected. Tap the same company again to deselect it.
  int _selectedCompany = -1;

  static const List<({String image, String title})> _companies = [
    (image: "assets/product/Chipsy Egypt.png", title: "Chipsy"),
    (image: "assets/product/pepsi.png", title: "Pepsi"),
    (image: "assets/product/edita.png", title: "edita"),
    (image: "assets/product/taiger.png", title: "Tiger"),
    (image: "assets/product/apor.png", title: "Oporland"),
    (image: "assets/product/Coca Cola.png", title: "Coca Cola"),
  ];

  static const List<({String image, String title})> _categories = [
    (
      image:
          "assets/father product/Gemini_Generated_Image_faafngfaafngfaaf.png",
      title: "Cold Drinks",
    ),
    (
      image:
          "assets/father product/Gemini_Generated_Image_kpozv9kpozv9kpoz.png",
      title: "Cold Drinks",
    ),
    (
      image:
          "assets/father product/Gemini_Generated_Image_7f2fx37f2fx37f2f.png",
      title: "cake & cookies",
    ),
    (
      image:
          "assets/father product/Gemini_Generated_Image_cu81c7cu81c7cu81.png",
      title: "foodstuffs",
    ),
    
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 76,
        titleSpacing: 20,
        title: _Reveal(
          child: GestureDetector(
            onTap: () {
                Navigator.of(context).push(fadeRoute(const Profile()));
            },
            child: Row(
              children: [
                const Hero(
                  tag: ProfileAvatar.heroTag,
                  child: ProfileAvatar(size: 40),
                ),
            
                const SizedBox(width: 12),
            
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back",
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    Text(
                      "Eyad Hossam",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          _Reveal(
            delay: const Duration(milliseconds: 120),
            child: _IconBox(
              asset: "assets/icon/notification.png",
              showDot: _hasUnread,
              onTap: () => Navigator.of(context).push(fadeRoute(const NotificationsPage())),
            ),
          ),
          const SizedBox(width: 10),
          _Reveal(
            delay: const Duration(milliseconds: 200),
            child: _IconBox(
              asset: "assets/icon/shopping-cart.png",
              tint: _brand,
              onTap: () => Navigator.of(context).push(fadeRoute(const CartPage())),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),

      body: Container(
         width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/unknown_2026.11.07-00.32_1.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Search
            SliverToBoxAdapter(
              child: _Reveal(
                delay: const Duration(milliseconds: 100),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                  child: SearchField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() => _searchQuery = value.trim().toLowerCase());
                    },
                  ),
                ),
              ),
            ),
        
            // Companies
            const SliverToBoxAdapter(
              child: _Reveal(
                delay: Duration(milliseconds: 200),
                child: _SectionHeader(
                  title: "Most famous companies",
                  action: "See all",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: _companies.where((c) => c.title.toLowerCase().contains(_searchQuery)).length,
                  itemBuilder: (context, i) {
                    final company = _companies.where((c) => c.title.toLowerCase().contains(_searchQuery)).toList()[i];
                    return Center(
                      child: SmallCard(
                        index: i,
                        activeColor: _brand,
                        image: company.image,
                        title: company.title,
                        selected: _selectedCompany == i,
                        onTap: () => setState(
                          () => _selectedCompany = _selectedCompany == i ? -1 : i,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        
            // Categories
            const SliverToBoxAdapter(
              child: _Reveal(
                delay: Duration(milliseconds: 300),
                child: _SectionHeader(title: "Categories"),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 30),
              sliver: SliverGrid.builder(
                itemCount: _categories.where((c) => c.title.toLowerCase().contains(_searchQuery)).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
        
                  // زيادة ارتفاع الكارت
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, i) {
                  final category = _categories.where((c) => c.title.toLowerCase().contains(_searchQuery)).toList()[i];
                  return BigCard(
                    index: i % 2, // 2 columns -> stagger per row
                    margin: EdgeInsets.zero,
                    image: category.image,
                    title: category.title,
                    onTap: () => Navigator.of(context).push(fadeRoute(CategoryPage(
                      title: category.title,
                      image: category.image,
                      company: _selectedCompany >= 0 ? _companies[_selectedCompany].title : null,
                    ))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section title with an optional "See all" action on the right.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25212B),
              ),
            ),
          ),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: Text(
                action!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff47287E),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// White rounded button for the app bar icons, with a press effect.
class _IconBox extends StatefulWidget {
  const _IconBox({
    required this.asset,
    this.tint,
    this.showDot = false,
    this.onTap,
  });

  final String asset;
  final Color? tint;
  final bool showDot;
  final VoidCallback? onTap;

  @override
  State<_IconBox> createState() => _IconBoxState();
}

class _IconBoxState extends State<_IconBox> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.06),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(widget.asset, width: 22, color: widget.tint),
              if (widget.showDot)
                Positioned(
                  top: 10,
                  right: 11,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4D6D),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fades in and slides up after [delay]. Used to stagger the page sections.
class _Reveal extends StatefulWidget {
  const _Reveal({required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  State<_Reveal> createState() => _RevealState();
}

class _RevealState extends State<_Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.12),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}