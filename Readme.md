<div align="center">

<img src="https://img.shields.io/badge/version-1.0.0--alpha-forestgreen?style=for-the-badge" />
<img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Node.js-20_LTS-339933?style=for-the-badge&logo=node.js&logoColor=white" />
<img src="https://img.shields.io/badge/PostgreSQL-15-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" />
<img src="https://img.shields.io/badge/React-Admin_Panel-61DAFB?style=for-the-badge&logo=react&logoColor=black" />
<img src="https://img.shields.io/badge/status-MVP_In_Development-orange?style=for-the-badge" />

---

# ♻ CRRF Digital Ecosystem

### **Cam Recycle Roads & Farms**

*A full-stack circular economy platform for Cameroon — turning household waste into road tar, organic manure, and digital value.*

[Features](#-features) · [Architecture](#-system-architecture) · [Project Structure](#-project-structure) · [Getting Started](#-getting-started) · [Screens](#-screen-inventory) · [Demo Flow](#-demo-flow) · [Contributing](#-contributing)

</div>

---

## 📌 Overview

**CRRF (Cam Recycle Roads & Farms)** is an integrated digital platform designed for the Cameroonian circular economy. It connects three actors in a single, closed-loop value chain:

- **Urban Households** sort and schedule waste for collection, earning digital vouchers (CRF Credits) for every verified kilogram deposited.
- **Smallholder Farmers** purchase processed organic manure from a digital marketplace using those vouchers or cash on delivery.
- **Collection Drivers** manage daily routes, confirm pickups via a mobile interface, and trigger automated credit issuance to households.

The platform is underpinned by a **digital voucher economy**: waste deposits are converted into traceable, expirable CRF Credits that flow from households to farmers, funding both the collection operation and sustainable agriculture.

> **Business Pillars:** Organic waste → Manure · Plastic waste → Road tar · Credits → Agricultural input financing

---

## ✨ Features

### Household Users
- Phone-based registration with OTP verification
- Waste collection scheduling (date, time window, waste type, weight estimate)
- Real-time pickup status tracking (Pending → Assigned → Confirmed → Completed)
- Digital CRF Credit wallet with full transaction ledger and expiry tracking
- Illustrated waste separation guide (Plastic / Organic / Rejected categories)
- Credit earning rates reference with worked calculation examples
- Personal impact dashboard (kg recycled, CO₂ avoided, neighbourhood ranking)
- In-app support with FAQ and missed pickup reporting

### Farmers
- Marketplace catalog with product grid, search, and category filters
- Product detail with NPK profile, benefits, and payment method toggle (Credits / Cash)
- Cart management with real-time credit balance validation
- Delivery scheduling with district, address, and time window selection
- Order tracking with a live status timeline (Ordered → Out for Delivery → Delivered)
- Micro-loan informational hub with offtake agreement explainer and expression of interest

### Collection Drivers
- Persistent bottom navigation shell (Home · Route · History · Profile)
- Shift status toggle (On Duty / Off Duty)
- Daily route list with summary bar, filter chips, and sequence-numbered task cards
- Per-task detail view with one-tap Maps navigation deep-link
- Pickup confirmation form with live credit calculation as weight is entered
- Skip / Report Issue flow with reason selection and free-text notes
- Date-grouped pickup history with per-day weight and credit totals

### Platform (Admin — React Web App, Phase 2)
- User management and role administration
- Driver route assignment and oversight
- Marketplace product catalog management
- Full CRF Credits ledger and rate configuration
- Operations analytics and reporting dashboard

---

## 🏗 System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      CLIENT TIER                                │
│                                                                 │
│   ┌──────────────────────────┐   ┌────────────────────────┐    │
│   │   Flutter Mobile App     │   │   React Admin Panel    │    │
│   │   (Android & iOS)        │   │   (Web — Phase 2)      │    │
│   │                          │   │                        │    │
│   │  • Household screens     │   │  • User management     │    │
│   │  • Farmer screens        │   │  • Analytics           │    │
│   │  • Driver screens        │   │  • Credit ledger       │    │
│   └──────────┬───────────────┘   └────────────┬───────────┘    │
└──────────────┼────────────────────────────────┼────────────────┘
               │  HTTPS / REST (JWT)            │
┌──────────────┼────────────────────────────────┼────────────────┐
│              │      APPLICATION TIER           │                │
│   ┌──────────▼────────────────────────────────▼───────────┐    │
│   │              Node.js / Express API                    │    │
│   │                                                       │    │
│   │  Auth · Collections · Wallet · Marketplace · Driver  │    │
│   │  Zod validation · JWT (15m access / 7d refresh)       │    │
│   │  Prisma ORM · Africa's Talking SMS                    │    │
│   └──────────────────────────┬────────────────────────────┘    │
└─────────────────────────────┼──────────────────────────────────┘
                              │
┌─────────────────────────────┼──────────────────────────────────┐
│                      DATA TIER           │                      │
│   ┌──────────────────────────▼────────────────────────────┐    │
│   │                PostgreSQL 15                          │    │
│   │                                                       │    │
│   │  users · pickup_requests · pickup_confirmations       │    │
│   │  wallet_transactions · products · orders · order_items│    │
│   │  otp_verifications                                    │    │
│   └───────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

### Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| Mobile Frontend | Flutter 3.x (Dart) | Cross-platform iOS & Android |
| State Management | Riverpod 2.x | Reactive state, DI |
| HTTP Client | Dio 5.x | JWT injection, token refresh interceptors |
| Local Storage | Flutter Secure Storage + Hive | Tokens, offline cache |
| Backend Runtime | Node.js 20 LTS | API server |
| API Framework | Express.js 4.x + TypeScript | REST endpoints |
| ORM | Prisma 5.x | Type-safe PostgreSQL queries |
| Database | PostgreSQL 15 | Primary relational datastore |
| Authentication | jsonwebtoken + bcrypt | Stateless JWT, password hashing |
| Validation | Zod | Request schema enforcement |
| SMS Gateway | Africa's Talking | Cameroon OTP delivery |
| Backend Hosting | Render.com | MVP cloud deployment |
| CI/CD | GitHub Actions | Automated checks on push |
| Admin Frontend | React 18 + TypeScript | Operations dashboard (Phase 2) |

---

## 📁 Project Structure

```
crrf-digital-ecosystem/
│
├── 📱 mobile_app/                          # Flutter Frontend
│   └── lib/
│       ├── core/
│       │   ├── constants/
│       │   │   └── app_constants.dart      # Routes, enums, credit rules, spacing
│       │   └── theme/
│       │       ├── app_colors.dart         # Brand palette (Green/Brown/Gold)
│       │       └── app_text_styles.dart    # DM Sans + DM Serif Display type system
│       │
│       ├── shared/
│       │   ├── screens/
│       │   │   ├── splash_screen.dart              # S-01 — Animated launch screen
│       │   │   ├── onboarding_screen.dart           # S-02 — 4-slide carousel
│       │   │   └── role_selection_screen.dart       # S-03 — ZyroBin-style list picker
│       │   └── widgets/
│       │       └── common_widgets.dart              # Shared UI component library
│       │
│       ├── features/
│       │   │
│       │   ├── auth/
│       │   │   └── screens/
│       │   │       ├── register_screen.dart         # S-04 — Role-adaptive form
│       │   │       └── otp_verification_screen.dart # S-05 — 6-box OTP entry
│       │   │
│       │   ├── household/
│       │   │   └── screens/
│       │   │       ├── h01_dashboard_screen.dart    # H-01 — Home + credit hero card
│       │   │       ├── h02_schedule_pickup_screen.dart  # H-02 — 5-step scheduling form
│       │   │       ├── h03_pickup_confirmation_screen.dart  # H-03 — Post-submit success
│       │   │       ├── h04_pickup_history_screen.dart   # H-04 — Filterable pickup list
│       │   │       ├── h05_pickup_detail_screen.dart    # H-05 — Single pickup expanded
│       │   │       ├── h06_cancel_pickup_sheet.dart     # H-06 — Bottom sheet modal
│       │   │       ├── h07_voucher_wallet_screen.dart   # H-07 — Collapsible wallet ledger
│       │   │       ├── h08_transaction_detail_screen.dart # H-08 — Single tx detail
│       │   │       ├── h09_waste_guide_screen.dart      # H-09 — Swipeable category cards
│       │   │       ├── h10_credit_rates_screen.dart     # H-10 — Rates + FAQ accordion
│       │   │       ├── h11_impact_summary_screen.dart   # H-11 — Stats + milestones
│       │   │       ├── h12_support_screen.dart          # H-12 — Help + contact
│       │   │       └── household_screens.dart           # Barrel export
│       │   │
│       │   ├── farmer/
│       │   │   └── screens/
│       │   │       ├── f01_dashboard_screen.dart        # F-01 — Home + promo banners
│       │   │       ├── f02_marketplace_catalog_screen.dart  # F-02 — Product grid + search
│       │   │       ├── f03_product_detail_screen.dart   # F-03 — Detail + cart add
│       │   │       ├── f04_cart_screen.dart             # F-04 — Order review + subtotals
│       │   │       ├── f05_delivery_details_screen.dart # F-05 — Address + window form
│       │   │       ├── f06_order_confirmation_screen.dart  # F-06 — Success state
│       │   │       ├── f07_order_history_screen.dart    # F-07 — Order list + filters
│       │   │       ├── f08_order_detail_screen.dart     # F-08 — Status timeline view
│       │   │       ├── f09_micro_loan_screen.dart       # F-09 — Loan info + interest CTA
│       │   │       └── farmer_screens.dart              # Barrel export
│       │   │
│       │   └── driver/
│       │       └── screens/
│       │           ├── d00_driver_shell.dart            # Shell — Bottom nav (4 tabs)
│       │           ├── d01_dashboard_screen.dart        # D-01 — Progress + shift toggle
│       │           ├── d02_daily_route_screen.dart      # D-02 — Route list + summary bar
│       │           ├── d03_pickup_task_detail_screen.dart  # D-03 — Task + navigate CTA
│       │           ├── d04_confirm_pickup_screen.dart   # D-04 — Weight entry + live calc
│       │           ├── d05_confirm_success_screen.dart  # D-05 — Credits issued success
│       │           ├── d06_report_issue_screen.dart     # D-06 — Skip + reason selector
│       │           ├── d07_history_screen.dart          # D-07 — Date-grouped history
│       │           └── driver_screens.dart              # Barrel export
│       │
│       └── main.dart                                    # App entry point + MaterialApp
│
├── ⚙️  backend_api/                        # Node.js / Express API
│   ├── src/
│   │   ├── routes/
│   │   │   ├── auth.routes.ts              # POST /auth/register|login|verify-otp|refresh
│   │   │   ├── collections.routes.ts       # POST /collections/request · GET /my-requests
│   │   │   ├── wallet.routes.ts            # GET /wallet/balance|transactions
│   │   │   ├── marketplace.routes.ts       # GET /marketplace/products · POST /orders
│   │   │   ├── driver.routes.ts            # GET /driver/routes · POST /pickups/:id/confirm
│   │   │   └── admin.routes.ts             # Admin-only endpoints
│   │   ├── middleware/
│   │   │   ├── auth.middleware.ts          # JWT verification + RBAC
│   │   │   └── validate.middleware.ts      # Zod schema validation
│   │   ├── services/
│   │   │   ├── credit.service.ts           # CRF Credit calculation engine
│   │   │   ├── sms.service.ts              # Africa's Talking OTP delivery
│   │   │   └── wallet.service.ts           # Atomic wallet transactions
│   │   ├── prisma/
│   │   │   └── schema.prisma               # Database schema (8 models)
│   │   └── app.ts                          # Express app setup
│   ├── tests/                              # Jest unit + integration tests
│   └── package.json
│
├── 📄 docs/
│   ├── CRRF_SRS_v1.0.docx                 # Software Requirements Specification
│   ├── CRRF_Screen_Inventory.md           # All 43 screens across 4 actors
│   └── CRRF_Demo_Flow.md                  # Stakeholder simulation script
│
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| Flutter SDK | 3.x | Mobile app |
| Dart | 3.x | Flutter language |
| Node.js | 20 LTS | Backend API |
| PostgreSQL | 15+ | Database |
| npm | 9+ | Package management |

### 1 — Clone the Repository

```bash
git clone https://github.com/your-org/crrf-digital-ecosystem.git
cd crrf-digital-ecosystem
```

### 2 — Mobile App (Flutter)

```bash
cd mobile_app

# Install dependencies
flutter pub get

# Verify setup
flutter doctor

# Run on connected device or emulator
flutter run

# Build release APK (for demo distribution)
flutter build apk --release
```

> **Demo mode:** All screens run fully offline with hardcoded mock data. No backend connection is required to demo the UI to stakeholders.

### 3 — Backend API (Node.js)

```bash
cd backend_api

# Install dependencies
npm install

# Copy environment template
cp .env.example .env
# Fill in: DATABASE_URL, JWT_SECRET, JWT_REFRESH_SECRET, AT_API_KEY, AT_USERNAME

# Run database migrations
npx prisma migrate dev

# Seed demo data
npx prisma db seed

# Start development server
npm run dev

# Run tests
npm test
```

### 4 — Environment Variables

```env
# backend_api/.env

# Database
DATABASE_URL="postgresql://user:password@localhost:5432/crrf_db"

# JWT
JWT_SECRET="your-access-token-secret-min-32-chars"
JWT_REFRESH_SECRET="your-refresh-token-secret-min-32-chars"
JWT_ACCESS_EXPIRES_IN="15m"
JWT_REFRESH_EXPIRES_IN="7d"

# Africa's Talking (SMS / OTP)
AT_API_KEY="your-africastalking-api-key"
AT_USERNAME="your-africastalking-username"

# App
PORT=3000
NODE_ENV=development
```

---

## 📱 Screen Inventory

### Shared / Onboarding (9 screens)

| ID | Screen | File |
|---|---|---|
| S-01 | Splash / Launch | `shared/screens/splash_screen.dart` |
| S-02 | Onboarding Carousel | `shared/screens/onboarding_screen.dart` |
| S-03 | Role Selection | `shared/screens/role_selection_screen.dart` |
| S-04 | Registration Form | `auth/screens/register_screen.dart` |
| S-05 | OTP Verification | `auth/screens/otp_verification_screen.dart` |
| S-06 | Login | `auth/screens/login_screen.dart` |
| S-07 | Forgot Password | `auth/screens/forgot_password_screen.dart` |
| S-08 | Notification Centre | `shared/screens/notifications_screen.dart` |
| S-09 | Profile Settings | `shared/screens/profile_screen.dart` |

### Household (12 screens)

| ID | Screen | Description |
|---|---|---|
| H-01 | Dashboard | Credit balance hero, collection CTA, activity feed |
| H-02 | Schedule Pickup | 5-step date/time/waste/weight form |
| H-03 | Pickup Confirmation | Post-submit success with reference number |
| H-04 | Pickup History | Filterable chronological list |
| H-05 | Pickup Detail | Driver data, actual weight, credits issued |
| H-06 | Cancel Pickup | Bottom sheet with reason selector |
| H-07 | Voucher Wallet | Collapsible SliverAppBar + tab-filtered ledger |
| H-08 | Transaction Detail | Single entry with source pickup deep-link |
| H-09 | Waste Separation Guide | 3-card swipeable carousel (Plastic/Organic/Rejected) |
| H-10 | Credit Earning Rates | Rates table, calculation example, FAQ accordion |
| H-11 | Impact Summary | Stats grid, milestone tracker, neighbourhood rank |
| H-12 | Support / Help | Contact cards, report missed pickup, FAQ |

### Farmer (9 screens)

| ID | Screen | Description |
|---|---|---|
| F-01 | Dashboard | Promo banners, stats row, recent orders |
| F-02 | Marketplace Catalog | Search + category filters + 2-col product grid |
| F-03 | Product Detail | NPK profile, benefits, payment toggle, qty stepper |
| F-04 | Cart / Order Review | Line items, balance validation, subtotals |
| F-05 | Delivery Details | Address + time window + notes form |
| F-06 | Order Confirmation | Success state with order ID and delivery ETA |
| F-07 | Order History | Status-filtered order list |
| F-08 | Order Detail | Status timeline + items + driver contact |
| F-09 | Micro-Loan Info | Eligibility, offtake explainer, loan tiers, interest CTA |

### Driver (7 screens + Shell)

| ID | Screen | Description |
|---|---|---|
| D-00 | Driver Shell | Bottom nav (Home · Route · History · Profile) |
| D-01 | Dashboard | Progress card, shift toggle, next pickup preview |
| D-02 | Daily Route List | Summary bar, filter chips, sequence-ordered tasks |
| D-03 | Pickup Task Detail | Full household info, Maps deep-link, dual action buttons |
| D-04 | Confirm Pickup | Weight entry with live credit calculator |
| D-05 | Confirmation Success | Animated success + credits issued display |
| D-06 | Report Issue | Reason selector + free-text note + submit |
| D-07 | Pickup History | Date-grouped with per-day weight and credit totals |

**Total: 43 screens across 4 user roles.**

---

## 🎬 Demo Flow

The application is designed to be fully demoable offline. The following three-act flow demonstrates the complete circular economy cycle for investors and stakeholders.

### Act 1 — Household (Ama schedules a pickup)
```
App Launch → Onboarding → Role Selection (Household)
→ Register → OTP (123456) → Dashboard
→ "Request Collection" → Schedule Pickup → Confirmation
→ Wallet (credits balance visible) → Impact Summary
```

### Act 2 — Driver (Didier confirms the pickup)
```
Login (driver credentials) → Driver Dashboard (shift ON)
→ Route List → Task Detail (Ama Mbarga)
→ Confirm Pickup (enter weights) → Live credit preview
→ Submit → Success screen (38 pts issued to Ama)
```

### Act 3 — Farmer (Emmanuel uses the credits)
```
Role Selection (Farmer) → Register → Dashboard
→ Marketplace → Product Detail (Premium Organic Manure)
→ Add to Cart → Delivery Details → Place Order
→ Confirmation → Order History → Status Timeline
```

> **The complete loop:** Ama's household waste → Didier's confirmation → CRF Credits → Emmanuel's manure order. This is the CRRF circular economy, demonstrated end-to-end in under 5 minutes.

---

## 🔌 API Reference

### Authentication
| Method | Endpoint | Description |
|---|---|---|
| POST | `/auth/register` | Register household or farmer |
| POST | `/auth/verify-otp` | Verify phone with 6-digit OTP |
| POST | `/auth/login` | Login, receive JWT pair |
| POST | `/auth/refresh` | Refresh access token |

### Collections
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/collections/request` | Household | Submit pickup request |
| GET | `/collections/my-requests` | Household | List own requests |
| PATCH | `/collections/:id/cancel` | Household | Cancel pending request |

### Wallet
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/wallet/balance` | Household | Current credit balance |
| GET | `/wallet/transactions` | Household | Paginated ledger |

### Driver
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/driver/routes/today` | Driver | Today's assigned pickups |
| POST | `/driver/pickups/:id/confirm` | Driver | Confirm with actual weights |
| PATCH | `/driver/pickups/:id/skip` | Driver | Mark as unable to complete |

### Marketplace
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/marketplace/products` | Farmer | List available products |
| POST | `/marketplace/orders` | Farmer | Place new order |
| GET | `/marketplace/orders` | Farmer | Farmer's order history |

---

## 💳 Credit Calculation Rules

```
Plastic:  10 CRF Credits per kg confirmed
Organic:   5 CRF Credits per kg confirmed

Minimum:   0.5 kg per waste type to earn credits
Rounding:  Weights rounded DOWN to nearest 0.5 kg before calculation
Expiry:    Credits expire 12 months after issuance
Atomicity: Credit issuance + wallet transaction in a single DB transaction

Example:
  3.2 kg plastic → rounded to 3.0 kg → 3.0 × 10 = 30 pts
  1.8 kg organic → rounded to 1.5 kg → 1.5 ×  5 =  8 pts
  ─────────────────────────────────────────────────────────
  Total issued: 38 CRF Credits
```

---

## 🗂 Database Schema

Eight PostgreSQL tables covering the full domain:

```
users                  ─── core user records, roles, verification status
otp_verifications      ─── SMS OTP codes with expiry and usage tracking
pickup_requests        ─── household-submitted collection requests
pickup_confirmations   ─── driver weight logs (triggers credit issuance)
wallet_transactions    ─── immutable credit ledger (earned / spent / expired)
products               ─── manure marketplace catalogue with stock levels
orders                 ─── farmer purchase orders with delivery details
order_items            ─── line items with price snapshots at time of purchase
```

> Full schema with column types, constraints, and ER relationships is documented in `docs/CRRF_SRS_v1.0.docx` — Section 5.

---

## 🧪 Testing

```bash
# Backend — Jest
cd backend_api
npm test                     # All tests
npm run test:coverage        # With coverage report
npm run test:watch           # Watch mode

# Mobile — Flutter test
cd mobile_app
flutter test                 # All widget + unit tests
flutter test --coverage      # With coverage
```

**Coverage targets:**
- Backend credit calculation logic: 100%
- Backend API endpoints: ≥ 70%
- Flutter widget tests: critical screens (H-01, H-02, H-07, D-04)

---

## 🚢 Deployment

### Backend → Render.com

1. Push to `main` branch — GitHub Actions runs lint + tests
2. Render auto-deploys on merge to `main`
3. Set all environment variables in Render dashboard
4. Run `npx prisma migrate deploy` via Render build command

### Mobile → Firebase App Distribution (Demo)

```bash
# Build APK
flutter build apk --release

# Upload to Firebase App Distribution
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
  --app YOUR_FIREBASE_APP_ID \
  --groups "stakeholders"
```

---

## 📐 Design System

| Token | Value | Usage |
|---|---|---|
| `forestGreen` | `#1B6B3A` | Primary brand, CTAs, icons |
| `earthBrown` | `#6D4C41` | Farmer theme, secondary actions |
| `creditGold` | `#F59E0B` | Credits, collection CTA, highlights |
| `infoBlue` | `#2563EB` | Driver theme, info states |
| Primary font | DM Sans | All body, labels, navigation |
| Display font | DM Serif Display | Credit balances, hero numbers |
| Border radius | 8 / 12 / 16 / 24 / 32 | Consistent component rounding |

---

## 🗓 Roadmap

- [x] **Phase 1** — SRS & Architecture documentation
- [x] **Phase 2** — Flutter UI: All 43 screens (Household, Farmer, Driver, Shared)
- [x] **Phase 3** — Screen-to-screen navigation wiring + offline demo build
- [ ] **Phase 4** — Node.js/Express REST API with JWT auth and credit engine
- [ ] **Phase 5** — Flutter ↔ API integration (Riverpod providers, Dio interceptors)
- [ ] **Phase 6** — React Admin Panel (user management, analytics, operations)
- [ ] **Phase 7** — Africa's Talking SMS OTP integration
- [ ] **Phase 8** — QA, UAT with pilot households and farmers in Yaounde
- [ ] **Phase 9** — Render deployment + Firebase App Distribution
- [ ] **Phase 10** — Mobile money payment gateway (Orange Money / MTN MoMo)

---

## 🤝 Contributing

This project is developed under the **DigiMark Consulting** banner for the CRRF initiative.

```bash
# Branching convention
feature/H-01-dashboard-screen
fix/otp-countdown-timer
chore/update-prisma-schema
docs/api-endpoint-reference

# Commit convention (Conventional Commits)
feat(household): add pickup cancellation bottom sheet
fix(driver): correct credit calculation rounding
chore(deps): update Flutter to 3.22.0
docs(api): document wallet endpoints
```

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'feat: your change'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request with a clear description of the change

---

## 👥 Team

| Role | Name |
|---|---|
| Product Lead & Full-Stack Developer | Kanjo Elkamira Ndi |
| Organisation | Alchemy Codes |
| Institution | Yaounde International Business School |

---

## 📄 License

This project is proprietary and confidential.
© 2026 Cam Recycle Roads & Farms / Alchemy Codes. All rights reserved.

Unauthorised copying, distribution, or use of this software or its documentation,
via any medium, is strictly prohibited without the express written permission of the authors.

---

<div align="center">

**Built in Cameroon 🇨🇲 · For Cameroon · By Alchemy Codes**

*Waste to Value. Crops to Markets.*

♻ · 🌿 · 🚛 · 🌾

</div>