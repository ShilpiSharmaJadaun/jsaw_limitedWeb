# JSAW Safety Portal — Web App

Flutter web front end of the JSAW HSE portal (observations, incident tracking,
investigations, compliance workflow, dashboards). Talks to the Spring Boot
backend in `D:\JSAW_BACKEND_API\JSAW` (context path `/JSAW`).

- **Production portal:** http://103.107.26.146:8078/jsawportal/#/login_page
- **Production API root:** http://103.107.26.146:8078/JSAW/
- App version: see `appVersion` in `lib/service/constant.dart`
  (shown in-app at the bottom of the **Write Us** page).

## Local development

1. **Start the backend** (serves `http://localhost:8091/JSAW/`, DB = HSE_DEV):

   ```powershell
   cd D:\JSAW_BACKEND_API\JSAW
   $env:MAVEN_OPTS="-Xmx256m"
   .\mvnw.cmd spring-boot:run "-Dspring-boot.run.jvmArguments=-Xmx640m -XX:MaxMetaspaceSize=256m"
   ```

   The capped heap keeps the JVM alive on low-memory machines. The backend
   needs the VPN/DB host `172.16.23.7:1433` reachable to start — if it dies at
   startup with a JDBC connection error, check the VPN first
   (`Test-NetConnection 172.16.23.7 -Port 1433`).

2. **Point the app at the local backend** — in `lib/service/constant.dart`,
   the active `root` must be:

   ```dart
   const root = 'http://localhost:8091/JSAW/';
   ```

3. **Run on Chrome:**

   ```powershell
   flutter run -d chrome
   ```

   Each relaunch opens a NEW Chrome window; old windows keep running the old
   code with a dead debug session — always use the newest window.

Dev login hint: passwords on HSE_DEV equal the employee ID (e.g. `116500`).

## Production release build

1. In `lib/service/constant.dart`:
   - switch `root` to `http://103.107.26.146:8078/JSAW/`
   - bump `appVersion` (and `version:` in `pubspec.yaml` alongside it)
2. Build — **the icon flag is mandatory**:

   ```powershell
   flutter build web --release --no-tree-shake-icons
   ```

   > **Why `--no-tree-shake-icons`:** this app references many icons
   > non-const, so a default release build strips their glyphs from the icon
   > font — icons then render blank ONLY in production. The flag ships the
   > full `MaterialIcons-Regular.otf` (~1.6 MB). Verify after building:
   > `build\web\assets\fonts\MaterialIcons-Regular.otf` must be ~1.6 MB,
   > not ~20 KB.

3. Verify the baked API root (`localhost` must not appear):

   ```powershell
   Select-String -Path build\web\main.dart.js -Pattern "localhost:8091" | Measure-Object
   ```

4. **Restore** `root` in `constant.dart` to `localhost:8091` for local dev.

## Deployment (manual, done by the project owner)

Order matters — the web app may call endpoints only the matching WAR has:

1. Package the backend: `cd D:\JSAW_BACKEND_API\JSAW; .\mvnw.cmd -o package -DskipTests`
   → `target\JSAW.war`.
2. Deploy **the WAR first** on the 103.107.26.146:8078 server.
3. Publish the contents of `build\web` as the `jsawportal` context.
4. Hard-refresh the portal (Ctrl+F5). Users who cached an older build may see
   blank icons once — the service worker self-heals by their second visit;
   the manual fix is DevTools → Application → Clear site data.

New DB columns auto-create via Hibernate (`ddl-auto=update`). One-time
migration scripts (already applied on HSE_DEV) live in
`database/migrations/` in the backend repo — run them once on any new DB.

## Project notes

- Routing uses hash URLs (`#/route`) — no SPA rewrite config needed on the
  server.
- Drawer entries are role-gated from the login response (medical officer,
  HSE team, HOD, CAPA owner flags).
- Excel/PDF generation happens in the backend; the app downloads bytes.
  PDFs open in an in-app viewer dialog (`showPdfViewer` in
  `lib/utils/pdf_download.dart`) with a download option in its header.
- The All Incident page's Excel export produces the consolidated
  "INCIDENT REPORTING & TRACKER" (FR-16) sheet with embedded photos
  (`incidentReport/exportTrackerExcel`).
