# Project 4 - Momo Tracker Client

Momo Tracker Client is a basic iOS  app to review and track local momo, a nepali cuisine, restaurants and upload to the cloud. We will use firebase (subject to change) as our cloud db. The application will be able to create reviews and review restaurants even when users do not have access to internet. It will uses persistent memory for all review created and only delete these reviews when connected to internet and the cloud db synchronizes with the local persistent memory. We will use camera and location as our two mobile-oriented features.

Time spent: **X** hours spent in total so far

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow using Twitter or Facebook
- [x] User can view last 20 reviews made and uploaded by all users
- [x] The current signed in user will be persisted across restarts
- [x] The home timeline view will show a series of reviews as snapchat like images, which will have 140 char long review on top of them and ratings
- [x] We will be modelling a review with a restaurant name, restaurant location, author info, rating, created info (including created by and created time), review description, restaurant picture, and rating out of 10
- [x] The home screen should have a (+) button where users will be taken to a camera view.
- [x] Noone should be allowed to delete any review.
- [x] User can logout.
- [x] The home timeline view will have a button to- [-] Users can select each review from their home timeline view and they will be taken to the restaurant the review belonged to
- [x] The cancel button from the picture view will take the user to the camera view again
- [x] The next button from the picture view will take to a form view where users can input resaurant name and a rating out of 5 stars. There will be a next or a cancel button here too.
- [x] The cancel button in the form view will take to the previous picture view

Additional features (optional)
- [ ] In the Detail View, users will view different reviews by other users as series of pictures on top of which there will be 140 char long review text and rating, author of each review, and the top of this view will have average rating for the restaurant and the most recent rating
- [ ] In the Detail View, all ratings by other users can be "loved" by a double tap or "unloved" by double tapping an already "loved" review
- [ ] Users will be able to search for a particular restaurant from the home timeline view
- [ ] Users will be able to love a review or unlove a "loved" review in the home timeline view by double tapping each review
- [ ] "loving" and "unloving" should increment or decrease the "loved" count.
- [ ] The camera view upon clicking a picture will take you to a picture view of the same photo just clicked where users can input text as in snapchat, but limited to 140 char. There will be a cancel or next button.
- [ ] The next button in the form view will add location data to the review and publish the review in the persistent memory initially, which will be uploaded to the cloud db once the device is connected to internet, and only after which other users will be able to access this review in their app
 take to users view where each user can see the reviews they have posted, and logout


The following **optional** features are implemented:


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. 
2. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/Momonai/Momo-Tracker-client/blob/master/walkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2017] [keema inc]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
