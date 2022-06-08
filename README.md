# get-started-ios-authentication-swift-uikit
Starter and completed companion projects for the blog article “Get Started with iOS Authentication using Swift and UIKit”

## The projects

The projects in this repo are companion projects for the Auth0 blog article, [Get Started with iOS Authentication using Swift and UIKit](https://auth0.com/blog/get-started-ios-authentication-swift-uikit/).


### The starter project

This project is meant to be the starting point for the article’s exercise. It’s not complete, but it _will_ run.

To run the starter project, download it and follow the article’s instructions.


### The complete project

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



 