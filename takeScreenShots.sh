#!/bin/bash

# The Xcode project to create screenshots for
projectName="./DecisionPoker.xcodeproj"

# The scheme to run tests for
schemeName="ScreenShotTests"


# All the simulators we want to screenshot
# Copy/Paste new names from Xcode's
# "Devices and Simulators" window
# or from `xcrun simctl list`.
#simulators=(
#    "iPhone 15 Pro Max"
#    "iPhone 15 Plus"
#    "iPhone 8 Plus"
#)

simulators=(
    "iPad Pro (12.9-inch) (6th generation)"
    "iPad Pro (12.9-inch) (2nd generation)"
)

# All the languages we want to screenshot (ISO 3166-1 codes)
languages=(
    "en"
    "de"
)

# All the appearances we want to screenshot
# (options are "light" and "dark")
appearances=(
    "light"
    "dark"
)

# Save final screenshots into this folder (it will be created)
targetFolder="/Users/jplenge/Desktop/DecisionPokerScreenshots"


## No need to edit anything beyond this point


for simulator in "${simulators[@]}"
do
    for language in "${languages[@]}"
    do
        for appearance in "${appearances[@]}"
        do
            rm -rf /tmp/DecisionPokerData/Logs/Test
            echo "📲  Building and Running for $simulator in $language"

            # Boot up the new simulator and set it to the correct appearance
            xcrun simctl boot "$simulator"
            xcrun simctl ui "$simulator" appearance $appearance
            
            # Build and Test
            xcodebuild -testLanguage $language -scheme $schemeName -project $projectName -derivedDataPath '/tmp/DecisionPokerData/' -destination "platform=iOS Simulator,name=$simulator" build test
            echo "🖼  Collecting Results..."
            mkdir -p "$targetFolder/$simulator/$language/$appearance"
            find /tmp/DecisionPokerData/Logs/Test -maxdepth 1 -type d -exec xcparse screenshots {} "$targetFolder/$simulator/$language/$appearance" \;
        done
    done
    echo "✅  Done"
done
