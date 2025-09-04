# Mini E-commerce App (Flutter) 
A simple e-commerce demo built with Flutter using the MVC pattern, GetX for state/navigation, Hive for local storage (cart), and a minimal CI/CD pipeline that builds a release APK and publishes it to GitHub Releases.

# Demo Video Link:
<https://drive.google.com/file/d/1p4ctWyZ_z5yNBCZcI1s31_wlF2Zno_l8/view?usp=drive_link>

# Demo APK Link:
<https://drive.google.com/file/d/1K9S0AfP-hRV0ncgK4YFbRreA_zAxYYwb/view?usp=drive_link>


# Architecture (MVC):
* Model:
  * Plain Dart data classes for products and cart items (id, title, price, image, quantity). Models hold data only; they don’t know about UI or storage.
* View:
  * Flutter widgets (screens and tiles) render the UI: Home grid, Product detail, Cart screen, and shared widgets like product tiles and cart tiles. Views are stateless about business rules and delegate user actions to Controllers.
* Controller:
  * GetX controllers mediate between Views and data:
    * ProductController: loads a product list via HTTP and exposes it as reactive state for the Home and Detail screens.
    * CartController: manages cart items, quantities, totals, and exposes itemCount and total; persists to Hive so cart survives restarts.
    * Navigation (GetX): routes/screens are triggered by controller or UI events (e.g., go to cart, go to details).

# How MVC flows in this app:
* Views (widgets) display observable state (e.g., Obx) from controllers.
* User actions (tap Add to Cart, +/– quantity, go to Cart) call controller methods.
* Controllers update in-memory state and persist changes (Hive for cart) or fetch data (http for products).
* When state changes, Obx rebuilds only the UI parts that depend on that state.

# Project structure:
* lib/
  * models/ … data classes like Product, CartItem.
  * controller/ … GetX controllers (ProductController, CartController).
  * services/ … simple HTTP client or repository wrappers (e.g., product service).
  * storage/ … Hive helpers/adapters/keys for cart persistence.
  * screens/
    * home_screen/ … grid of products, search/filter hooks.
    * detail_screen/ … product detail and Add to Cart.
    * cart_screen/ … CartBody and CartSummaryBar; tiles for items.
  * widgets/ … shared tiles, buttons, loaders.
  * main.dart … app entry (GetMaterialApp routes, DI bootstrap).

# Libraries Used:
* GetX
  * Simple reactive state (Rx + Obx), lightweight DI (Get.put), and straightforward navigation—keeps UI code small and readable.
* Hive + hive_flutter
  * Fast, local key–value storage for cart; no device database setup; works offline; easy to serialize lists of items.
* http
  * Fetch product data from a REST endpoint in a few lines.
* cached_network_image
  * Caches product images to reduce network requests and speed up scrolling.
* Dev tools
  * flutter_launcher_icons generates launcher icons from a single PNG.
  * flutter_test runs fast unit tests for business logic.

# Responsiveness:
* Layout uses MediaQuery and LayoutBuilder to adjust columns, spacing, and padding for phones and tablets.
* A minimum width guard avoids render overflows on ultra-narrow web windows.
* Grids switch columns by breakpoints (e.g., 2/3/4) and tile paddings scale to keep tap targets usable.

# Offline Support:
* Home Screen -
  * Hive is used for caching the items fetched from the api and shown to the home page.
  * Last successful product list is cached and shown when offline; a retry button is available on failure.
* Cart Screen -
  * Cart items will be shown in offline mode.
  * Any changes made to the cart  will reflect when the user will return online.
  * So any product quantity increased or decreased while offline will reflect on connecting with internet.
 
# Error Handling:
* Home Screen -
  * Proper error handling is done if the internet has problems and if there is no items in the cart.
* Cart Screen -
  * Proper error handling is done when there is no data in the cart.



# Unit tests (2):
* Price calculation test
  * Verifies grand total = sum of price × quantity across all cart lines. Includes empty-cart and floating precision checks.
  * Location: test/price_calc_test.dart; run with flutter test test/price_calc_test.dart.
* Cart persistence test (Hive)
  * Seeds a cart item with qty=1, calls increment(id), persists to Hive, then simulates a new controller session and confirms the reloaded qty=2.
  * Location: test/cart_hive_persistence_test.dart; uses a temporary folder (Directory.systemTemp) so it never touches real app data.

# CI/CD pipeline (GitHub Actions):
* Workflow file: .github/workflows/android-apk.yml.
* Triggers: on push to main and manual dispatch.
* Steps:
  1. Checkout repo.
  2. Setup Java 17 (required by modern Android Gradle Plugin).
  3. Setup Flutter (stable).
  4. flutter pub get.
  5. flutter build apk --release.
  6. Rename to Mini_ecommerce_app.apk.
  7. Create a GitHub Release and upload the APK as a release asset (visible under the Releases tab).
* Result: every push to main generates a fresh release with the APK, or use the run button to build on demand.
* Note: by default this APK is unsigned for store publishing. Add signing secrets later if store upload is planned.


# How to run:
* Prerequisites
  * Flutter SDK (stable channel), Android Studio or command-line Android SDK, and an emulator or physical device.
  * A working internet connection if product data loads from a live API.
* Steps
  1. Clone the repo
     * git clone <https://github.com/nikhilesh-7119/mini_ecommerce_app>
     * cd mini_ecommerce_app
  3. Get packages
     * flutter pub get
  4. (Optional) Generate launcher icons
     * Ensure pubspec.yaml has a flutter_launcher_icons section pointing to lib/assets/images/icon.png.
     * Run: flutter pub run flutter_launcher_icons
     * This writes Android/iOS launcher assets (only needed if icon assets were changed).
  5. Run the app (debug)
     * Android/emulator or device: flutter run
     * Web (Chrome): flutter run -d chrome
  6. Build a release APK (local)
     * flutter build apk --release
     * The APK is created at build/app/outputs/flutter-apk/app-release.apk.
  7. Run tests
     * All tests: flutter test
     * Single file: flutter test test/price_calc_test.dart
  8. CI-generated APK
     * Push to main or trigger the workflow from the Actions tab.
     * Open the latest run → Releases tab of the repo; download Mini_ecommerce_app.apk from the newest Release.
 


