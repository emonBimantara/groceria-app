class OnboardContent {
  final String image;
  final String title;
  final String description;

  OnboardContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnboardContent> contents = [
  OnboardContent(
    image: 'assets/onboard-2.png',
    title: 'Fresh Groceries, Delivered Every Day',
    description:
        'Handpicked local produce delivered fresh from nearby farms to you.',
  ),
  OnboardContent(
    image: 'assets/onboard-1.png',
    title: 'Shop Smarter, Save Time and Money',
    description:
        'Compare prices, find deals, and check out faster every single time.',
  ),
  OnboardContent(
    image: 'assets/onboard-3.png',
    title: 'Fast Delivery, Right When You Need',
    description:
        'Track your order live and receive groceries exactly when expected.',
  ),
];
