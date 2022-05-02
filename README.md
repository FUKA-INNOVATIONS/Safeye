# Safeye
![Safeye logo](https://users.metropolia.fi/~gintares/Safeye/drawing.svg)

Safeye is an iOS app that lets users keep an eye on their loved ones in emergency situations. This app uses phone's native GPS tracker (Apple's MapKit) to track user's live location and speech recognition technology to record any voices it detects as messages. In case of an emergency, a user can easily send an alert to their contacts on the app who can then view user's live location and read any messages that were recorded. This helps them decide how to best help the user.

Safeye was designed and developed using XCode, SwiftUI, UIKit, Git, and Figma.

## Main features
- Registration and authentication
- Upload a profile image
- Edit user profile
- Search for addresses and save them to personal *safe spaces* list
- Create/delete tracked events
- Live location tracking (MapKit)
- Speech recognition to record messages as text
- Enable/disable emergency mode
- Local notifications
- Search for users by personal connection code
- Send/cancel/approve connection requests, delete connections
- Multiple languages through localization
- Light/dark theme

## Safeye pattern: solving App State issues
![Safeye pattern](https://users.metropolia.fi/~gintares/Safeye/pattern.png)
 
 ## How it works
 ![Icon: Add a contact](https://users.metropolia.fi/~gintares/Safeye/png-64/gps-64x64-10969.png) **Add a contact**
 The user must have at least contact on Safeye before they can use all features of the app. The user can share their personal unique connection code with their friends or family who can then find them on the app using the code.
 
 ![Icon: Create an event](https://users.metropolia.fi/~gintares/Safeye/png-64/map-64x64-10960.png)**Create an event**
 Once the user has at least one contact, they can then create a new event. An event in Safeye context means any occasion during which the user might be away from home and could run into unsafe situations, for example, first date, drinks at a bar, late evening walk alone, etc.
 
When the user is creating a new event, they have to fill out a few details about the event and select one or more contacts from their Safeye contact list. Only those contacts will be able to  see user's location and read any information associated with the event while it is active.
 
 ![Icon: Activate emergency mode](https://users.metropolia.fi/~gintares/Safeye/png-64/gps-64x64-10994.png) **Activate emergency mode**
 In case of an emergency, the user can activate the emergency mode with a tap of one button. This triggers a notification sent to those contacts that were selected for the event. Safeye starts listening to any voices it can detect in user's surroundings and logs them as text messages. Those messages and user's live location can then be viewed by the event contacts. They can then easier determine what kind of situation the user might be in and decide what is the best way to help them.

Of course, in case of grave danger, we advise to call 112 or local emergency services.

![Icon: Disable emergency mode](https://users.metropolia.fi/~gintares/Safeye/png-64/tag-64x64-10962.png)**Disable emergency mode**
Once the user is safe again, they can disable the emergency mode with a click of one button. This will automatically stop any messages from being recorded and user's contacts will be able to see that the user is safe again.

![Icon: Delete event](https://users.metropolia.fi/~gintares/Safeye/png-64/tag-64x64-10961.png)**Delete event**
Once the user event ends and their back to a safe location, they can delete the event. This will automatically delete any information associated with the event including location details and message logs.

## Backend

Firebase Authentication, Storage and Firestore Database.

## Screenshots
![screenshot1](https://users.metropolia.fi/~gintares/Safeye/screenshots/screenshot1.png)
![screenshot2](https://users.metropolia.fi/~gintares/Safeye/screenshots/screenshot2.png)
![screenshot3](https://users.metropolia.fi/~gintares/Safeye/screenshots/screenshot3.png)

## Known bugs
- Application state is not reset upon logout
- Missing or incorrect translations
- Sometimes app crashes when sending a connection request

## Changes after user feedback
We had a few users test our prototype during the design process of this application. We have received a lot of valuable feedback and attempted to implement most of the suggested changes in order to improve the user experience.
Changes implemented:
- Allowing users to navigate within the entire app even in emergency mode.
- Tracked events are disabled only manualy to prevent the app from stopping location tracking if user's event lasts longer than anticipated.
- Simplified address search.
- Changed 'Panic' button to 'SOS' button.
- Clearer communication: consistency in terms used, explanations/alerts throughout the app, a dedicated information section explaining how the app works and answering some of the questions users might have.
- Curtain view in map view wasn't easily findable for users so we tried to make it more visible.
- Select/de-select all contacts at once in event creation.
- Some design improvements.
- ... and many other small changes.

## Future development ideas
- Disable emergency mode only with faceID/fingerprint/password etc.
- Siri or button sequency to activate emergency mode quicker
- Widget for the app
- Push notifications with PushKit
- How-to videos on how to use the app
- Adding a loading indicator to all the views
- Changing and reseting password
- Map: pinpointing location on the map
- Map: showing directions to locations

## Documentation
- [Demo video](https://youtu.be/rBR6bBXuQc4)
- [GitHub project](https://github.com/FUKA-INNOVATIONS/Safeye/projects/2?query=is%3Aopen+sort%3Aupdated-desc)
- [GitHub milestones](https://github.com/FUKA-INNOVATIONS/Safeye/milestones)
- [GitHub issues](https://github.com/FUKA-INNOVATIONS/Safeye/issues?q=is%3Aissue+is%3Aclosed+sort%3Acreated-asc)
- [Figma prototype](https://www.figma.com/proto/LWi7g0OSnzDbrVc7zyeWIe/Safeye-Prototyping?node-id=21%3A86&scaling=scale-down&page-id=0%3A1&starting-point-node-id=21%3A86&show-proto-sidebar=1)
- [Storyboard](https://users.metropolia.fi/~gintares/Safeye/safeye-highres-storyboard.png)


## Developers

- [Fuwad Kalhori](https://github.com/FUKA-INNOVATIONS)
- [David Fallow](https://github.com/dfallow)
- [Gintare Saali](https://github.com/gintaresaali)
- [Pavlo Leinonen](https://github.com/leinonenko)
- [Ali Fahad](https://github.com/Ali-k-fahad)
