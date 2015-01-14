# RestartUpdate
Scripts and instructions for implementing the "Restart and Update" system.


Chalenge:
Give our users a SIMPLE way to keep they computer up to date.

We had no real way for users to update all there software them selfs.
Software update only updates Apple software, and is now tied to the app store, and we are removing the app store.
Microsoft, Abobe, and other 3rd party software is not updated.

So when users had computer issues and there software was way out of date, I had no way to say "Your out of date. All you had todo is XYZ to stay up to date"
I had no XYZ.
I needed an XYZ

With 90% laptops it is hard to know when to push updates.
Are they on our trusted WiFi? Is there network cable plugged in?
How much longer will they be in the office?
Are they using the app that needs updating?
Would they have time now to close that app and wait for it to update?

With our environment and culture it was not really acceptable to interrupt users with messages. 
So notices to close apps or restart demands really was not an option.
I really wanted to respect our users time.

Our users can be in client critical presentations, or working on tight deadlines, and a message from I.T. would not be well received.

I needed a way for users to install all updates on there terms.
When they wanted.

Options:
Self Service
I could have done something in self service, sure.
For some of our users this would be to much to ask.
I wanted to keep this as simple as posable.

I decided installing all updates at restart was the beat way to go.
But how to do this?
How to not always install them at restart?
How to give the user the option?
And how to install all the updates?

I needed something at logout to ask the user if they wanted to install updates.
So a script of some sort.

----EDIT----

I found cocoaDialog.
cocoaDialog is an OS X application that allows the use of common GUI controls such as file selectors, text input, progress bars, yes/no confirmations and more with a command-line application. It requires no knowledge of Cocoa, and is ideal for use in shell and Perl scripts (or Ruby, or Python, or... etc). 

It worked consistently, it was easy to script, it had lots of options.
So i created a logout script to ask the user if they wanted to install updates.
Yes or no.
https://jamfnation.jamfsoftware.com/featureRequest.html?id=1148
-------------

I am now useing jamfhelper

So no if they click yes, how do I install al the updates?
The script kicks off a policy to:
Install all Apple updates
I created an Apple update server for all the Apple updates. I only approve the ones we need.
Install all Creative Suite updates
I actually got an internal Adobe update server working!
Install all 3rd party updates
I simply cache them








