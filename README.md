# task_manager
# when ever I write bash(it refers to run in a terminal)
# Task Manager App (Flutter + Supabase)

![Dark Theme with Gold Accents]

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK (3.19.0 or newer)
- Dart (3.3.0 or newer)
- Android Studio/Xcode (for emulators)
- Supabase account

### Installation
Clone the repository:
   ```bash
   git clone https://github.com/joe2130/task-manager-flutter.git
   cd task-manager

Install dependencies:

bash
flutter pub get
Run the app:

bash
flutter run

Supabase Setup Steps
1. Create New Project
Go to supabase.com and create a new project

Wait for database to initialize (2-3 mins)

2. Database Setup
Run these SQL commands in SQL Editor:
-- Create tasks table
CREATE TABLE task (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  is_completed BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT now()
);

-- Enable RLS
ALTER TABLE task ENABLE ROW LEVEL SECURITY;

-- Add policies
CREATE POLICY "User access" ON task
FOR ALL USING (user_id = auth.uid());

3. Authentication Setup
Go to Authentication → Settings

Disable "Email Confirmations" (for development)

Add your app URL in "Redirect URLs":

io.supabase.flutter://login-callback/
4. Environment Variables
Create lib/utils/constants.dart:

dart
const SUPABASE_URL = 'your-project-url';
const SUPABASE_ANON_KEY = 'your-anon-key';

 Running the App
 flutter run --debug

 production build
 flutter build apk --release

Features
Dark mode with gold accents
Supabase authentication
Real-time task sync
Responsive design

### Additional Recommended Sections:

**For Deployment:** 
## Deployment

### Android
1. Generate signing key:
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

2. Update android/app/build.gradle with signing configs

3. Build APK:
bash
flutter build apk --release

**Troubleshooting:**  
```markdown
## 🛠 Troubleshooting

### Common Issues
1. **Auth Errors**: 
   - Ensure redirect URLs are whitelisted
   - Check if email confirmations are disabled in dev

2. **RLS Errors**:
   ```sql
   -- Check policies
   SELECT * FROM pg_policies WHERE tablename = 'task';

3.Overflow Errors:
Wrap columns in SingleChildScrollView
Use Flexible instead of Expanded in some cases
