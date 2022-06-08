# Companion projects for **_Get Started with iOS Authentication using Swift and UIKit_**


## About this project

This repository contains starter and completed projects that accompany the Auth0 blog article, [**_Get Started with iOS Authentication using Swift and UIKit_**](https://auth0.com/blog/get-started-ios-authentication-swift-uikit/).

The article shows the reader how to use Auth0 to add fully-featured login and logout to a UIKit-based iOS/iPadOS app. These projects are the initial and final version of the app featured in the article.

The project is for a single-screen iOS app that allows users to log in and log out. It was purposely kept as simple as possible to keep the focus on authentication.


## A quick tour of the app

When launched, the app displays a screen with a greeting, a **Log In** button, and a disabled **Log Out** button:

![The app’s “Welcome” screen. The “Log In” button is enabled, and the “Log In” button is disabled.](https://images.ctfassets.net/23aumh6u8s0i/4hZG5L93r8PUPz9w6KZLCb/45601dc15211cc4befd4023c0c4c87b1/app_screen_1.png)

Pressing the **Log In** button starts the process that leads to the [Auth0 Universal Login screen](https://auth0.com/docs/login/universal-login):

![The default Auth0 Universal Login web page, with Auth0 logo and “email address” and “password” fields.](https://images.ctfassets.net/23aumh6u8s0i/BRb491WFNaF0lzTROs2wn/5fa67f3cae8fcea5d107f6bbe824e4f5/app_screen_3.png)

When the user enters a valid email address/password combination, Auth0 authenticates the user, the Universal Login disappears, and the app displays information about the user:

![The app in its “logged in” state. The “Log In” button is disabled, “Log Out” button is enabled, and the app’s other controls are visible.](https://images.ctfassets.net/23aumh6u8s0i/6e0rndIioalupkrVQXKBNy/f3926c6014c9d656960ee9ee5a4dfc2f/app_screen_6.png)

Pressing the **Log Out** button logs the user out, taking them back to the opening screen, which informs the user that they’ve logged out:

![The app in its “logged out” state. The “Log In” button is enabled, “Log Out” button is disabled, and the app’s other controls are hidden.](https://images.ctfassets.net/23aumh6u8s0i/3HRpkBgBsCPQRE0vvVrSL2/77ab99e8daa7b16d39cf34bffa20e92b/app_screen_8.png)


## How to install and run the projects

You’ll need the following:

1. **An Auth0 account.** The app uses Auth0 to provide authenticate users, which means that you need an Auth0 account. You can <a href="https://auth0.com/signup" 
  data-amp-replace="CLIENT_ID" 
  data-amp-addparams="anonId=CLIENT_ID(cid-scope-cookie-fallback-name)">
  sign up for a free account</a>, which lets you add login/logout to 10 applications, with support for 7,000 users and unlimited logins. This should suit your prototyping, development, and testing needs.
2. **An iOS/iPadOS development setup:** 
	* Any Mac computer from 2013 or later — MacBook, MacBook Air, MacBook Pro, iMac, iMac Pro, Mac Mini, Mac Pro, or Mac Studio — with at least 8 GB RAM. When it comes to RAM, more is generally better.
	* Apple’s developer tool, [Xcode](https://developer.apple.com/xcode/) version 11.0 (September 2019) or later. When writing this article, I used the current version at the time: 13.4 (build 13F17a), released on May 16, 2022.
3. **3. An iOS device, virtual or real.** Xcode comes with the Simulator application, which simulates recent iPhone, iPad, and iPod Touch models. Xcode 13.4’s virtual devices run iOS 15.5 by default.


### Installing and running the starter project

This project is meant to be the starting point for the article’s exercise. It’s not complete, but it _will_ run.

To run the starter project, download it and follow the article’s instructions.


### Installing and running the complete project

The complete project is the result of downloading the start project and following the article’s instructions. It is provided for reference.

To use the complete project, download it, then connect it to Auth0 by doing the following:

* Log into the [Auth0 dashboard](https://manage.auth0.com/dashboard/), select **Applications → Applications** from the left side menu, then click the **Create Application** button.
* Enter a name for the app in the **Name** field and choose the **Native** application type.
* Select the **Settings** tab and copy the **Domain** and **Client ID** values.
* Open `Auth0.plist` in the app project. Paste the **Domain** value that you just copied into the **Value** field of the property list’s `Domain` row.
* Past the **Client ID** value that you just copied into the **Value** field of the property list’s `ClientId` row.
* Copy the project’s Bundle Identifier from Xcode.
* Using the string below, replace `{BUNDLE_IDENTIFIER}` with the app’s bundle identifier and `{YOUR_DOMAIN}` with your tenant’s domain:

```
{BUNDLE_IDENTIFIER}://{YOUR_DOMAIN}/ios/{BUNDLE_IDENTIFIER}/callback
```

* Run the app!


## License

Copyright (c) 2022 [Auth0](http://auth0.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.