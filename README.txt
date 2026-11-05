ScapeLedger 0.7.13-https - Windows RuneLite development package

1. Close the previous ScapeLedger development client.
2. Extract this ENTIRE ZIP into a new folder. Keep the lib directory intact.
3. Start Start-ScapeLedger.cmd. Do not launch RuneLite.exe for this package.

Existing RuneLite settings and the upload key remain in your normal RuneLite profile.
Use the matching ScapeLedger 0.8.0 server with accounts migrations 001-015.
Fixed server: https://scapeledger.forhosting.nl

Changes since 0.7.6 include richer goal-completion cards, website-selected goals,
Slayer lifecycle/cache observations, optional saved RuneLite loot-history import,
model-labelled timer starts and bounded loot context. Optional integrations remain
controlled by their RuneLite configuration settings.

Validation: 97 JUnit tests, nine assertion mains and the packaged launcher --check
passed on Linux. Updated Java sources target Java 11 / RuneLite 1.13.5. Unchanged
vendored farming classes and all runtime dependencies are retained from the earlier
Windows distribution. This is an incremental package build, not a clean Gradle build.
A native Windows launch or live game login/sync has not been tested here.

No JRE, game account credentials, profiles or upload keys are included.
No Plugin Hub submission or store release is implied by this development package.
