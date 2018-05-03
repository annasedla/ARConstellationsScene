# ARContellations

Constellation Visualizer
5th April 2018

Anna Sedlackova & Daniel Grigsby

OVERVIEW

The purpose of this app is to be able to stargaze from the comfort of your home. Using the Apple AR kit and a location detection, anyone can point their camera at the sky and see the stars above them. There are similar applications available out there; however, they are either costly ($10 and above), have various bugs as reported by the users relating to location detection or not functioning on all phones equally. We are planning to make our app completely free because we believe that since most cities are polluted, anyone should be able to enjoy a beautiful view of the stars at any time.

FUNCTIONALITIES

Get the user’s location and request access to the camera.
Use the Apple AR Kit to display constellations through a user’s phone camera by moving the phone around pointed at the sky.
Display the constellation’s name on the screen.
Detect what specific angle the user has the camera pointed at to display accurate constellation locations when the user rotates their device

MAIN TECHNIQUES

We will use the Core Location framework to locate user’s device. Knowing the correct coordinates is essential for stellar stargazing experience. We will upload images of all the different constellations into the app. Using the Apple AR Kit and the device’s location we will then display the correctly positioned constellations on the user’s screen.  We may also need the Core Motion framework to position the constellations relative to the way the device is posted.
