//cannot be created in a class file as it will cause a circular dependency
// This file contains various enums used throughout the application.
enum AppRoutes {
  home,
  login,
  register,
  profile,
  settings,
  cart,
  productDetails,
  orderHistory,
  wishlist,
}
enum UserRoles {
  admin,
  vendor,
  customer,
}
enum ProductCategories {
  electronics,
  fashion,
  homeAppliances,
  books,
  beauty,
  sports,
}
enum SortOptions {
  priceLowToHigh,
  priceHighToLow,
  newestFirst,
  bestSellers,
}
enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}
enum NotificationTypes {
  orderUpdate,
  promotional,
  systemAlert,
  feedbackRequest,
}
enum UserActions {
  addToCart,
  removeFromCart,
  placeOrder,
  writeReview,
  addToWishlist,
}
enum UserPreferences {
  darkMode,
  lightMode,
  notificationsEnabled,
  language,
}
enum ShippingMethods {
  standard,
  express,
  overnight,
  pickup,
}
enum Currency {
  usd,
  eur,
  gbp,
  inr,
  jpy,
  ugx,
}
enum Languages {
  english,
}
enum ErrorCodes {
  networkError,
  serverError,
  validationError,
  authenticationError,
  notFound,
}
enum UserStatus {
  active,
  inactive,
  banned,
  pendingVerification,
}
enum ProductStatus {
  available,
  outOfStock,
  discontinued,
}
enum ReviewRatings {
  oneStar,
  twoStars,
  threeStars,
  fourStars,
  fiveStars,
}
enum ThemeModes {
  light,
  dark,
  systemDefault,
}
enum NotificationSettings {
  enabled,
  disabled,
  onlyImportant,
}
enum FileTypes {
  image,
  video,
  document,
  audio,
}
enum AccessLevels {
  read,
  write,
  admin,
  guest,
}
enum UserActionsHistory {
  login,
  logout,
  updateProfile,
  changePassword,
  deleteAccount,
}
enum UserPreferencesKeys {
  theme,
  language,
  notifications,
  privacySettings,
}
enum ProductAttributes {
  color,
  size,
  brand,
  material,
  warranty,
}
enum ShippingStatus {
  notShipped,
  shipped,
  inTransit,
  delivered,
  returned,
}
enum OrderActions {
  cancel,
  track,
  reorder,
  leaveReview,
}

enum TextSizes{
  small,
  medium,
  large,
  extraLarge,

}
enum OrderStatus{
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
  returned,

}
enum PaymentMethods{
  creditCard,
  debitCard,
  paypal,
  bankTransfer,
  cashOnDelivery,
  mobileMoney,
  visa,
  mastercard,
  googlepay,

}
