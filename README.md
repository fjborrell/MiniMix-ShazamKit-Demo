# MiniMix (ShazamKit Demo)

## Vision, Description, and Features

MiniMix is a song-identification iOS application. It listens to your surroundings, and uses ShazamKit to return any identified tracks as well as detailed information about that song.

**Prototype & Key Features:**

This MVP/prototype was developed in ~4 days, and leverages Apple’s ShazamKit and MusicKit (+ Apple Music API) frameworks. 

* The main driver of the application is the ShazamKitHelper class. Here, SHSession is initialized, which handles communicating captured audio signatures with the Shazam servers. The helper also handles microphone audio capture, audio configuration, and session events such (e.g successful and failed matches). 

* Song data returned from the helper class is stored in a custom BinarySong data type -> Consolidates SHMediaItem and Song (MusicKit) data into one. This is used to display detailed track information.

* Matched songs can be added to your Shazam Library

* An identified song can be opened in the native Shazam or Apple Music applications

* A user can view their song request history

## Getting Started

### Requirements

This app was developed with the following environment in mind:
* iPhone 12, iOS 16+, Xcode 14.2+

### Miscellaneous and Privacy
1. App requests access to microphone for audio capture
2. App requests access to Apple Music catalog for detailed track data

## Frameworks
* [SwiftUI](https://developer.apple.com/documentation/swiftui/)
* [ShazamKit](https://developer.apple.com/documentation/shazamkit)
* [MusicKit](https://developer.apple.com/documentation/MusicKit)

## Acknowledgements
Inspiration, tutorials, attributions, references, etc.
* [Welcome Screen Illustration](https://storyset.com)
* [SwiftUI Animation Tutorials](https://www.youtube.com/@Kavsoft)

## Known Limitations & Future Development Steps:
* **Unit Tests are required!** Time constraints did not allow for them.
* Current app architecture can be improved. More seperation of concerns is possible. MVVM? MVC?
* No data persistence for song request history.
* Need to add optional cancel button to stop song matching once started.
* Future features I wish to add: Share button, song suggestions, scrollable "mini mixes".

## QA Testing Results:
1. Welcome Screen -> Leave App (success)
2. Welcome Screen -> Listen View (success)
3. Match Success w/ Shazam Data (success)
4. Match Success w/ and w/o Apple Music Data (success)
5. Match Fail in silence (success)
6. Match Fail with unknown song (success)
7. Start Listening -> History (success)
8. Start Listening -> History -> ListenView (success)
9. Start Listening -> Leave App (success)
10. Start Listening -> Leave App -> History (success)
11. Start Listening -> History -> Detailed Song View -> History (FAIL)
* **REPRODUCIBLE BUG; Test 11**: Identifies correct song and adds to history, but breaks ListenView's detailed track sheet. Requires app restart)
