# BeyondChallenge
This project was developed to a apply a job position on Beyond Domotics. The main idea is use the Moscapsule framework to realize a connection to a broker, after that the app must publish messages on a topic and obtain the value from a topic that was realize a subscribe.

### Prerequisites

For execute this project you need have installed Cocoapods and Xcode.
```
$ gem install cocoapods
```
Through terminal go to the project folder and execute the following command:
```
$ pod install
```

### Configuration

To run the project, you need fill the beyond.plist fields. It's necessary the host, client id and publish/subscribe topics.

## Build With

* [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxGesture](https://github.com/RxSwiftCommunity/RxGesture)
* [Snapkit](https://github.com/SnapKit/SnapKit)
* [Moscapsule](https://github.com/flightonary/Moscapsule)

## To Do:

Need study how to test using RxSwift to make some tests on it.
