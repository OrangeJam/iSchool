
Development Methodology
=========

We maintain a priority queue of user stories on trello.com.
The stories are broken into tasks which are directly implementable.
When a story is selected for development it is moved into the "in progress"
column, and tasks are checked off as they are completed. 
When all tasks are completed and our definition of done is fulfilled, the task
can be moved into the "done" column.

Definition of Done
--------

A story can be considered done when all associated tasks are completed,
unit tests have been written and pass, and a pull-request to master has been
created.

Definition of DoneDone
--------

A story is considered DoneDone when the pull request has been reviewed, 
approved, and merged into master.

Git workflow
--------

Each contributor has his own branch. Feature branches are created for each story
and when done, merged into the contributors branch. A pull request is then
created to merge that branch into master, and reviewed by other contributors.


Architecture Overview
========

We follow established practices in iOS app development, and use the MVC
pattern. Further, we want our models and controllers to be as thin as possible,
and abstract the main app logic into separate classes that are not coupled to 
the CocoaTouch api as much as possible.

The benefits of this approach are numerous:
* Easier unit testing
* Greater potential for code reuse
    * Future desktop client can use a lot of the existing codebase
* Separation of concerns, making debugging easier.
* Less back-end dependency
    * Easy to adapt to new MySchool API

We hope that this will make the code much more maintainable long term, at the
cost of a little bit more effort in the short term.

Testing
=======

We practice Test-Driven development in order to force us to write properly
encapsulated logic, and to avoid obvious bugs.

Code is tested with the `XCTest` unit testing framework in XCode.




