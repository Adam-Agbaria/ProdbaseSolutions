<p align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/6295/6295417.png" width="100" />
</p>
<p align="center">
    <h1 align="center">PRODBASESOLUTIONS Unfinished</h1>
</p>
<p align="center">
    <em>ProdbaseSolutions is a comprehensive software solution designed to help small to medium-sized businesses efficiently manage their operations. This project is structured with a backend and a frontend component, providing a robust system to handle various business processes such as product management, client management, transaction handling, and more. The application includes features for analytics, reporting, user authentication, and secure data handling.
 </em>
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/Adam-Agbaria/ProdbaseSolutions?style=flat&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/Adam-Agbaria/ProdbaseSolutions?style=flat&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/Adam-Agbaria/ProdbaseSolutions?style=flat&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/Adam-Agbaria/ProdbaseSolutions?style=flat&color=0080ff" alt="repo-language-count">
<p>
<p align="center">
		<em>Developed with the software and tools below.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/badge/JavaScript-F7DF1E.svg?style=flat&logo=JavaScript&logoColor=black" alt="JavaScript">
	<img src="https://img.shields.io/badge/Redis-DC382D.svg?style=flat&logo=Redis&logoColor=white" alt="Redis">
	<img src="https://img.shields.io/badge/YAML-CB171E.svg?style=flat&logo=YAML&logoColor=white" alt="YAML">
	<br>
	<img src="https://img.shields.io/badge/Android-3DDC84.svg?style=flat&logo=Android&logoColor=white" alt="Android">
	<img src="https://img.shields.io/badge/Language-MongoDB-green" alt="MongoDB">
	<img src="https://img.shields.io/badge/Dart-0175C2.svg?style=flat&logo=Dart&logoColor=white" alt="Dart">
	<img src="https://img.shields.io/badge/JSON-000000.svg?style=flat&logo=JSON&logoColor=white" alt="JSON">
	<img src="https://img.shields.io/badge/Express-000000.svg?style=flat&logo=Express&logoColor=white" alt="Express">
	<img src="https://img.shields.io/badge/JetBrains-000000.svg?style=flat&logo=JetBrains&logoColor=white" alt="JetBrains">
</p>
<hr>





### Key Features:

## Product Management:

Full CRUD (Create, Read, Update, Delete) operations for products.
Organize and categorize products for streamlined management.
Integration with inventory systems to track stock levels.

## Client Management:

Manage client information including contact details, transaction history, and engagement metrics.
Efficient client handling with easy-to-use interfaces and forms.
Order and Transaction Management:

Manage and track orders from initial placement to completion.
Securely handle transactions and payment processing.
Detailed records of all transactions to ensure accountability.
Profit and Metrics Analysis:

Track profits and analyze financial metrics for better business decision-making.
Real-time analytics for performance tracking across various business operations.
User Authentication and Role Management:

Secure login and registration systems for administrators and users.
Role-based access control to ensure users can only access the features relevant to their responsibilities.
Backup and Recovery:

Automated backup systems to prevent data loss.
Recovery tools to restore lost or corrupted data efficiently.
Analytics and Reporting:

In-depth analytics tools to visualize business performance.
Generate reports to analyze key metrics such as sales, profits, and user engagement.
Settings and Configuration Management:

Configurable application settings to adapt to various business needs.
Easy-to-manage configuration for different environments (development, production).
Custom Middleware and Error Handling:

Middleware for token verification, rate limiting, logging, and error handling.
Custom error handling to improve system robustness and resilience.
Support for Multiple Platforms:

Cross-platform support including Android, iOS, web, and desktop applications.
Native mobile apps developed with Flutter for iOS and Android.
Secure Data Handling:

Encryption utilities to ensure data security.
Integration with Redis for caching and optimized data retrieval.
Log Management:

Detailed logging for tracking application errors and monitoring system activity.
Support for application-specific and combined logs for comprehensive system auditing.
Technology Stack:
Backend: Node.js, Express.js, Redis, MongoDB
Frontend: Flutter for mobile apps, Dart for shared logic, HTML/CSS for web, JavaScript
Database: MongoDB, Redis for caching
Security: JWT authentication, role-based access control, encryption utilities
Deployment: Docker, CI/CD pipelines for streamlined deployments

##  Repository Structure

```sh
└── ProdbaseSolutions/
    ├── backend
    │   ├── .gitignore
    │   ├── config
    │   │   ├── dbconfig.js
    │   │   ├── envConfig.js
    │   │   └── sentryConfig.js
    │   ├── controllers
    │   │   ├── analyticsController.js
    │   │   ├── authController.js
    │   │   ├── backupController.js
    │   │   ├── clientController.js
    │   │   ├── logContoller.js
    │   │   ├── metricsController.js
    │   │   ├── orderController.js
    │   │   ├── productController.js
    │   │   ├── profitController.js
    │   │   ├── recoveryController.js
    │   │   ├── settingsController.js
    │   │   ├── storageController.js
    │   │   ├── tokenController.js
    │   │   ├── transactionController.js
    │   │   └── userController.js
    │   ├── middleware
    │   │   ├── CheckAccessToken.js
    │   │   ├── customErrors.js
    │   │   ├── errorHandler.js
    │   │   ├── fileUploadMiddleware.js
    │   │   ├── loggingMiddleware.js
    │   │   ├── rateLimiter.js
    │   │   └── verifyToken.js
    │   ├── models
    │   │   ├── ClientModels.js
    │   │   ├── OrderModels.js
    │   │   ├── ProductModels.js
    │   │   ├── ProfitModels.js
    │   │   ├── TransactionModels.js
    │   │   ├── UserModels.js
    │   │   ├── backupModels.js
    │   │   ├── blackListedTokenModels.js
    │   │   ├── logModels.js
    │   │   ├── metricsModels.js
    │   │   ├── refreshTokenModels.js
    │   │   └── settingsModels.js
    │   ├── package-lock.json
    │   ├── package.json
    │   ├── redis
    │   │   ├── 00-RELEASENOTES
    │   │   ├── EventLog.dll
    │   │   ├── README.txt
    │   │   ├── RELEASENOTES.txt
    │   │   ├── dump.rdb
    │   │   ├── redis-benchmark.exe
    │   │   ├── redis-benchmark.pdb
    │   │   ├── redis-check-aof.exe
    │   │   ├── redis-check-aof.pdb
    │   │   ├── redis-check-rdb.exe
    │   │   ├── redis-check-rdb.pdb
    │   │   ├── redis-cli.exe
    │   │   ├── redis-cli.pdb
    │   │   ├── redis-server.exe
    │   │   ├── redis-server.pdb
    │   │   ├── redis.windows-service.conf
    │   │   └── redis.windows.conf
    │   ├── routes
    │   │   ├── analyticsRoutes.js
    │   │   ├── authRoutes.js
    │   │   ├── backupRoutes.js
    │   │   ├── clientRoutes.js
    │   │   ├── logRoutes.js
    │   │   ├── metricsRoutes.js
    │   │   ├── orderRoutes.js
    │   │   ├── productRoutes.js
    │   │   ├── profitRoutes.js
    │   │   ├── recoveryRoutes.js
    │   │   ├── settingsRoutes.js
    │   │   ├── storageRoutes.js
    │   │   ├── tokenRoutes.js
    │   │   ├── transactionRoutes.js
    │   │   └── userRoutes.js
    │   ├── server.js
    │   ├── services
    │   │   ├── analyticsService.js
    │   │   ├── authService.js
    │   │   ├── backupService.js
    │   │   ├── clientService.js
    │   │   ├── databaseService.js
    │   │   ├── emailService.js
    │   │   ├── logService.js
    │   │   ├── metricsService.js
    │   │   ├── orderService.js
    │   │   ├── productService.js
    │   │   ├── profitService.js
    │   │   ├── recoveryService.js
    │   │   ├── settingsService.js
    │   │   ├── storageService.js
    │   │   ├── tokenService.js
    │   │   ├── transactionService.js
    │   │   └── userService.js
    │   └── utils
    │       ├── constants.js
    │       ├── encryptionUtility.js
    │       ├── helpers.js
    │       ├── logger.js
    │       ├── networkUtility.js
    │       └── validators.js
    ├── frontend
    │   ├── .gitignore
    │   ├── .metadata
    │   ├── README.md
    │   ├── analysis_options.yaml
    │   ├── android
    │   │   ├── .gitignore
    │   │   ├── android.zip
    │   │   ├── app
    │   │   │   ├── build.gradle
    │   │   │   └── src
    │   │   │       ├── debug
    │   │   │       ├── main
    │   │   │       └── profile
    │   │   ├── build.gradle
    │   │   ├── gradle
    │   │   │   └── wrapper
    │   │   │       └── gradle-wrapper.properties
    │   │   ├── gradle.properties
    │   │   └── settings.gradle
    │   ├── assets
    │   │   ├── fonts
    │   │   │   ├── Cairo-VariableFont_slnt,wght.ttf
    │   │   │   ├── CroissantOne-Regular.ttf
    │   │   │   ├── Lobster-Regular.ttf
    │   │   │   ├── ProdBase-Solutions-Black.ttf
    │   │   │   ├── ProdBase-Solutions-BlackItalic.ttf
    │   │   │   ├── ProdBase-Solutions-Bold.ttf
    │   │   │   └── Rubik-Bold.ttf
    │   │   ├── icons
    │   │   │   ├── analytics.svg
    │   │   │   ├── app_icon.png
    │   │   │   ├── cart.png
    │   │   │   ├── client.svg
    │   │   │   ├── error.svg
    │   │   │   ├── home.svg
    │   │   │   ├── loading.svg
    │   │   │   ├── notification.png
    │   │   │   ├── order.svg
    │   │   │   ├── product.svg
    │   │   │   ├── profile.svg
    │   │   │   ├── refresh.svg
    │   │   │   ├── settings.png
    │   │   │   ├── settings.svg
    │   │   │   ├── transaction.png
    │   │   │   ├── transaction.svg
    │   │   │   └── user.png
    │   │   └── images
    │   │       ├── background_pattern.png
    │   │       ├── banner.png
    │   │       ├── logo.png
    │   │       ├── product_default.png
    │   │       └── profile_placeholder.png
    │   ├── environments
    │   │   ├── dev_config.dart
    │   │   └── prod_config.dart
    │   ├── ios
    │   │   ├── .gitignore
    │   │   ├── Flutter
    │   │   │   ├── AppFrameworkInfo.plist
    │   │   │   ├── Debug.xcconfig
    │   │   │   └── Release.xcconfig
    │   │   ├── Runner
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── Assets.xcassets
    │   │   │   │   ├── AppIcon.appiconset
    │   │   │   │   └── LaunchImage.imageset
    │   │   │   ├── Base.lproj
    │   │   │   │   ├── LaunchScreen.storyboard
    │   │   │   │   └── Main.storyboard
    │   │   │   ├── Info.plist
    │   │   │   └── Runner-Bridging-Header.h
    │   │   ├── Runner.xcodeproj
    │   │   │   ├── project.pbxproj
    │   │   │   ├── project.xcworkspace
    │   │   │   │   ├── contents.xcworkspacedata
    │   │   │   │   └── xcshareddata
    │   │   │   └── xcshareddata
    │   │   │       └── xcschemes
    │   │   └── Runner.xcworkspace
    │   │       ├── contents.xcworkspacedata
    │   │       └── xcshareddata
    │   │           ├── IDEWorkspaceChecks.plist
    │   │           └── WorkspaceSettings.xcsettings
    │   ├── lib
    │   │   ├── config
    │   │   │   ├── app_colors.dart
    │   │   │   └── app_settings.dart
    │   │   ├── main.dart
    │   │   ├── middleware
    │   │   │   ├── api_middleware.dart
    │   │   │   ├── auth_middleware.dart
    │   │   │   ├── client_middleware.dart
    │   │   │   ├── error_middleware.dart
    │   │   │   ├── logging_middleware.dart
    │   │   │   ├── navigation_middleware.dart
    │   │   │   ├── notification_middleware.dart
    │   │   │   ├── persistence_middleware.dart
    │   │   │   ├── rateLimit_middleware.dart
    │   │   │   └── subscription_middleware.dart
    │   │   ├── models
    │   │   │   ├── backup.dart
    │   │   │   ├── client.dart
    │   │   │   ├── log.dart
    │   │   │   ├── metrics.dart
    │   │   │   ├── order.dart
    │   │   │   ├── product.dart
    │   │   │   ├── profit.dart
    │   │   │   ├── refreshToken.dart
    │   │   │   ├── settings.dart
    │   │   │   ├── transaction.dart
    │   │   │   └── user.dart
    │   │   ├── providers
    │   │   │   ├── analytics_provider.dart
    │   │   │   ├── auth_provider.dart
    │   │   │   ├── barcode_provider.dart
    │   │   │   ├── client_provider.dart
    │   │   │   ├── filter_sort_provider.dart
    │   │   │   ├── order_provider.dart
    │   │   │   ├── product_provider.dart
    │   │   │   ├── profit_provider.dart
    │   │   │   ├── search_provider.dart
    │   │   │   ├── settings_provider.dart
    │   │   │   ├── theme_provider.dart
    │   │   │   ├── transaction_provider.dart
    │   │   │   └── user_provider.dart
    │   │   ├── screens
    │   │   │   ├── analytics
    │   │   │   │   └── analytics_list.dart
    │   │   │   ├── auth
    │   │   │   │   ├── login_screen.dart
    │   │   │   │   └── register_screen.dart
    │   │   │   ├── clients
    │   │   │   │   ├── client_add_screen.dart
    │   │   │   │   ├── client_details_screen.dart
    │   │   │   │   ├── client_edit_screen.dart
    │   │   │   │   └── clients_list_screen.dart
    │   │   │   ├── error_screen.dart
    │   │   │   ├── home_screen.dart
    │   │   │   ├── onboard_screen.dart
    │   │   │   ├── orders
    │   │   │   │   ├── order_details_screen.dart
    │   │   │   │   ├── order_edit_screen.dart
    │   │   │   │   └── orders_list_screen.dart
    │   │   │   ├── products
    │   │   │   │   ├── product_add_screen.dart
    │   │   │   │   ├── product_details_screen.dart
    │   │   │   │   ├── product_edit_screen.dart
    │   │   │   │   └── products_list_screen.dart
    │   │   │   ├── profile_screen.dart
    │   │   │   ├── profits
    │   │   │   │   ├── profit_dashboard.dart
    │   │   │   │   └── profit_picker_screen.dart
    │   │   │   ├── settings_screen.dart
    │   │   │   ├── subscription_payment_screen.dart
    │   │   │   ├── transactions
    │   │   │   │   ├── transaction_add_screen.dart
    │   │   │   │   ├── transaction_details_screen.dart
    │   │   │   │   ├── transaction_edit_screen.dart
    │   │   │   │   └── transactions_list_screen.dart
    │   │   │   └── unsubscribed_screen.dart
    │   │   ├── services
    │   │   │   ├── analytics_service.dart
    │   │   │   ├── api_service.dart
    │   │   │   ├── auth_service.dart
    │   │   │   ├── background_task_service.dart
    │   │   │   ├── client_service.dart
    │   │   │   ├── database_service.dart
    │   │   │   ├── encryption_service.dart
    │   │   │   ├── logging_service.dart
    │   │   │   ├── network_service.dart
    │   │   │   ├── order_service.dart
    │   │   │   ├── product_service.dart
    │   │   │   ├── profit_service.dart
    │   │   │   ├── rate_limit_service.dart
    │   │   │   ├── request_service.dart
    │   │   │   ├── settings_service.dart
    │   │   │   ├── storage_service.dart
    │   │   │   ├── tamper_detection_service.dart
    │   │   │   ├── transaction_service.dart
    │   │   │   ├── usb_scanner.dart
    │   │   │   └── user_service.dart
    │   │   ├── themes
    │   │   │   ├── dark_theme.dart
    │   │   │   └── light_theme.dart
    │   │   ├── utils
    │   │   │   ├── constants.dart
    │   │   │   ├── dart_helper.dart
    │   │   │   ├── helpers.dart
    │   │   │   ├── localization.dart
    │   │   │   ├── logging.dart
    │   │   │   ├── metrics.dart
    │   │   │   ├── routes.dart
    │   │   │   ├── size.dart
    │   │   │   ├── text_field.dart
    │   │   │   ├── theme.dart
    │   │   │   ├── theme_colors.dart
    │   │   │   └── validators.dart
    │   │   └── widgets
    │   │       ├── AnimatedCompanyName.dart
    │   │       ├── AppAdvancedDrawer.dart
    │   │       ├── AppNewDrawer.dart
    │   │       ├── client_add_widget.dart
    │   │       ├── client_detail_widget.dart
    │   │       ├── client_update_widget.dart
    │   │       ├── clients_list_widget.dart
    │   │       ├── custom_drawer.dart
    │   │       ├── custom_text_field.dart
    │   │       ├── date_range.dart
    │   │       ├── error_widget.dart
    │   │       ├── home_widget.dart
    │   │       ├── loading_indicator.dart
    │   │       ├── locked_feature.dart
    │   │       ├── login_widget.dart
    │   │       ├── order_detail_widget.dart
    │   │       ├── order_list_widget.dart
    │   │       ├── order_update_widget.dart
    │   │       ├── product_add_widget.dart
    │   │       ├── product_detail_widget.dart
    │   │       ├── product_list_widget.dart
    │   │       ├── product_update_widget.dart
    │   │       ├── profit_detail_widget.dart
    │   │       ├── profit_list_widget.dart
    │   │       ├── pull_to_refresh.dart
    │   │       ├── register_widget.dart
    │   │       ├── styled_widgets
    │   │       │   ├── hoverButton.dart
    │   │       │   └── styled_widgets.dart
    │   │       ├── toast_notification.dart
    │   │       ├── transaction_add_widget.dart
    │   │       ├── transaction_detail_widget.dart
    │   │       ├── transaction_update_widget.dart
    │   │       ├── transactions_list_widget.dart
    │   │       ├── unsubscribed_widget.dart
    │   │       └── update_client_widget.dart
    │   ├── linux
    │   │   ├── .gitignore
    │   │   ├── CMakeLists.txt
    │   │   ├── flutter
    │   │   │   ├── CMakeLists.txt
    │   │   │   ├── generated_plugin_registrant.cc
    │   │   │   ├── generated_plugin_registrant.h
    │   │   │   └── generated_plugins.cmake
    │   │   ├── main.cc
    │   │   ├── my_application.cc
    │   │   └── my_application.h
    │   ├── macos
    │   │   ├── .gitignore
    │   │   ├── Flutter
    │   │   │   ├── Flutter-Debug.xcconfig
    │   │   │   ├── Flutter-Release.xcconfig
    │   │   │   └── GeneratedPluginRegistrant.swift
    │   │   ├── Runner
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── Assets.xcassets
    │   │   │   │   └── AppIcon.appiconset
    │   │   │   ├── Base.lproj
    │   │   │   │   └── MainMenu.xib
    │   │   │   ├── Configs
    │   │   │   │   ├── AppInfo.xcconfig
    │   │   │   │   ├── Debug.xcconfig
    │   │   │   │   ├── Release.xcconfig
    │   │   │   │   └── Warnings.xcconfig
    │   │   │   ├── DebugProfile.entitlements
    │   │   │   ├── Info.plist
    │   │   │   ├── MainFlutterWindow.swift
    │   │   │   └── Release.entitlements
    │   │   ├── Runner.xcodeproj
    │   │   │   ├── project.pbxproj
    │   │   │   ├── project.xcworkspace
    │   │   │   │   └── xcshareddata
    │   │   │   └── xcshareddata
    │   │   │       └── xcschemes
    │   │   └── Runner.xcworkspace
    │   │       ├── contents.xcworkspacedata
    │   │       └── xcshareddata
    │   │           └── IDEWorkspaceChecks.plist
    │   ├── nuget.exe
    │   ├── pubspec.lock
    │   ├── pubspec.yaml
    │   ├── test
    │   │   └── widget_test.dart
    │   ├── web
    │   │   ├── favicon.png
    │   │   ├── icons
    │   │   │   ├── Icon-192.png
    │   │   │   ├── Icon-512.png
    │   │   │   ├── Icon-maskable-192.png
    │   │   │   └── Icon-maskable-512.png
    │   │   ├── index.html
    │   │   └── manifest.json
    │   └── windows
    │       ├── .gitignore
    │       ├── CMakeLists.txt
    │       ├── flutter
    │       │   ├── CMakeLists.txt
    │       │   ├── generated_plugin_registrant.cc
    │       │   ├── generated_plugin_registrant.h
    │       │   └── generated_plugins.cmake
    │       └── runner
    │           ├── CMakeLists.txt
    │           ├── Runner.rc
    │           ├── flutter_window.cpp
    │           ├── flutter_window.h
    │           ├── main.cpp
    │           ├── resource.h
    │           ├── resources
    │           │   └── app_icon.ico
    │           ├── runner.exe.manifest
    │           ├── utils.cpp
    │           ├── utils.h
    │           ├── win32_window.cpp
    │           └── win32_window.h
    └── logs
        ├── .72dd8cd95033c7643b0f7df125be54594ef8c3f1-audit.json
        ├── application-2023-08-29.log
        ├── application-2023-08-30.log
        ├── application-2023-09-11.log
        ├── combined.log
        ├── error.log
        └── exceptions.log
```

---



###  Installation

1. Clone the ProdbaseSolutions repository:

```sh
git clone https://github.com/Adam-Agbaria/ProdbaseSolutions
```

2. Change to the project directory:

```sh
cd ProdbaseSolutions
```

3. Install the dependencies:

```sh
pub get
```

###  Running ProdbaseSolutions

Use the following command to run ProdbaseSolutions:

```sh
dart main.dart
```

