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
