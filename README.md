# RxGesturePlayGarden
A few simple samples for RxGesture (an extension of RxSwift) as the different cases from official examples (at the time).

* First, it is a pan-gesture (one-touch) for rotation. (in case someone wouldn't like to use UIRotationGestureRecognizer)

* Second, it is about translation.

* Third, it is about scaling.

* All of above samples will not reset transform to .identity before the next round, therefore, you can continue to where you left off.

* Last, it is just a simple drawing with dragging and erase all with long-pressing. Writing this with traditional way (touched-delegating) is quite tedious but RxGesture makes thing cleaner and simple.

For more information about RxGesture, [here](https://github.com/RxSwiftCommunity/RxGesture).

Any suggestions (e.g. more elegant or cleaner implementation) and questions are always welcome.

![demo](https://user-images.githubusercontent.com/19208995/36740191-134a3394-1c25-11e8-9487-70680a1d333b.gif)
## Requirements
XCode 9.1, Swift 4.0, iOS 9 or above

## Installation
Download or clone the project and please do ```pod install``` to install pods' dependencies. Learn more about [CocoaPods](http://cocoapods.org).

## License
RxGesturePlayGarden is available under the MIT license. See the LICENSE file for more info.
