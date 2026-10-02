# Mahali — محلي 🇪🇬

> Egypt's first local fashion brand discovery app.

Mahali connects Egyptian shoppers with local fashion brands — all in one place. No more switching between TikTok, Instagram, and Chrome just to find and shop a local brand. Mahali brings the entire discovery experience into a single, beautifully designed app.

---

## The Problem

Finding local Egyptian fashion brands is frustrating. You discover one on TikTok, search for it on Instagram, then hunt for the website separately — only to realize halfway through that the algorithm never showed you a cheaper, better alternative that exists. Mahali fixes this.

---

## Features

### For Shoppers
- Browse all local Egyptian fashion brands in one place
- Filter by category — Modest Wear, Streetwear, Swimwear, Bags, Basics, Jewelry, Vintage and more
- Live search across all brands
- Featured brands carousel on the home screen
- Open any brand's website directly inside the app (no external browser needed)
- Save favorite brands and access them anytime
- AI Brand Assistant powered by Google Gemini — describe your style, budget, or occasion in Arabic or English and get instant personalized brand recommendations

### For Brand Owners
- Register your brand with name, category, Instagram handle, website, and description
- Brand dashboard showing approval status and brand details
- Brand analytics overview
- Edit brand information at any time

### General
- Two user roles — Shopper and Brand Owner with separate navigation flows
- Full authentication — email and password sign up and login
- Edit profile — name, phone number, and avatar photo
- About Mahali and Privacy Policy screens
- Role badge displayed on profile

---

## App Flow

```
Splash Screen
    ↓
Onboarding (3 slides)
    ↓
Login / Register (choose role: Shopper or Brand Owner)
    ↓
Shopper: Home → Explore → AI Assistant → Profile
Brand Owner: Dashboard → Register Brand → Profile
```

---

## Tech Stack

| Technology | Usage |
|---|---|
| Flutter | Cross-platform mobile framework |
| Supabase | Backend — PostgreSQL database, authentication, storage |
| Google Gemini AI | AI brand assistant via REST API |
| webview_flutter | In-app brand website browsing |
| provider | State management for favorites |
| image_picker | Profile avatar photo selection |
| smooth_page_indicator | Onboarding page dots |
| http | Gemini API REST calls |

---

## Database Schema

```sql
-- Auto-created on signup via Supabase trigger
profiles (
  id uuid PRIMARY KEY,
  email text NOT NULL,
  full_name text,
  role text,         -- 'shopper' or 'brand_owner'
  phone text,
  avatar_url text,
  created_at timestamptz
)

-- Brand registrations
brands (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  instagram text,
  website_url text,
  description text,
  category text,
  owner_id uuid,
  is_approved boolean,
  is_featured boolean,
  created_at timestamptz
)
```

---

## Project Structure

```
lib/
├── core/
│   ├── constants/       → Colors, assets, API config
│   ├── data/            → Local brand seed data
│   ├── models/          → BrandModel
│   ├── providers/       → FavoritesProvider
│   └── theme/           → AppTheme
│
├── features/
│   ├── splash/
│   ├── on_boarding/
│   ├── auth/            → Login, Register
│   ├── home/
│   ├── explore/
│   ├── brand_detail/    → Detail screen + WebView
│   ├── brand_owner/     → Dashboard, Register Brand, Analytics
│   ├── saved/
│   ├── profile/         → Profile, Edit, About, Privacy Policy
│   ├── ai_assistant/    → Gemini AI chat
│   └── navigation/      → Bottom nav with role-based routing
│
├── main.dart
└── my_app.dart
```

---

## Design System

| Role | Color | Hex |
|---|---|---|
| Primary | Sage Green | `#7C9A7E` |
| Secondary | Deep Rose | `#B85C6E` |
| Accent | Dusty Pink | `#E8A5A5` |
| Text | Dark Olive | `#3D4A2E` |
| Background | Warm White | `#FAF7F2` |
| Card | Mint Tint | `#F0F5F0` |

Logo designed in Canva — bilingual (MAHALI + محلي) with an arch motif referencing Egyptian architecture.

---

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/yourusername/mahali.git
cd mahali
```

2. Install dependencies
```bash
flutter pub get
```

3. Add your API keys — create `lib/core/constants/app_constants.dart`:
```dart
class AppConstants {
  AppConstants._();
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
}
```

4. Run the app
```bash
flutter run
```

---

## Future Roadmap

- Google OAuth login
- Push notifications for brand approvals
- Subscription model for featured brand placements
- Real-time analytics dashboard for brand owners
- Brand owner verified badge
- User reviews and ratings for brands
- More categories — Kids, Men, Gym Wear, Accessories

---

## Built During

NTI (National Telecommunication Institute) — Mobile App Development Training, 2026

---

*Mahali is more than a project — it's a real startup idea addressing a genuine gap in the Egyptian fashion market.* 🇪🇬
