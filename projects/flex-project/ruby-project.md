# Ruby Project (deprecated)

The point of this project is to impress a technical screener/interviewer. In most cases, it won't have a front-end and won't be accessible to someone without a technical background as the only thing to show will be the GitHub repo. Good projects to pick are Active Record Lite and Rails Lite, or Chess. You're a much better developer now than when you wrote these programs, so there will be low-hanging fruit to improve and polish.

There are specific tasks to do for each project, in addition to the general tasks outlined in the [Flex Project](flex-project.md) description.

### [Active Record Lite][active-record-lite] & [Rails Lite][rails-lite]
  * ActiveRecordLite and RailsLite should be integrated and combined into a single repo (bonus step in Rails Lite instructions)
  * Remove all references of this being a class project
    * Remove everything about phases - filenames (in /lib and /spec) and comments within each file.
  * Remove /lib/00\_attr\_accessor.rb object. That was a warmup in metaprogramming and it's not actually used in the project
  * Once you remove phases, organize files. Still have multiple files that each monkeypatch or extend `SQLObject`.
  * Give it its own name--don't use "Active Record Lite" or "Rails Lite". This includes [changing the name of the repo][renaming-repo].
  * Explain in README how somebody would go about using this instead of the real ActiveRecord/Rails
  * When you talk about this project, and in your README, don't say that it's a clone of ActiveRecord or Rails. Instead, own it. Say something like, "An ORM inspired by the functionality of ActiveRecord" or "Web server MVC framework inspired by the functionality of Ruby on Rails".
  * BONUS: Build a demo app using your new framework/ORM. The app should emphasize the custom framework and ORM, rather than focusing on being a really good web app. One idea is to make the app a simple walkthrough of the functionality of the framework with interactive examples.
  * BONUS: [Release your framework as a gem](http://guides.rubygems.org/make-your-own-gem/).

#### Examples
Some examples are older, and didn't have the same requirements. All show the level of quality we're looking for.
  * [Red Rum](https://github.com/aegatlin/red-rum)
  * [Baby's First MVC](https://github.com/jjjreisss/Babys-First-MVC)
  * [Rails Lite](https://github.com/timhwang21/Rails-Lite)
  * [ActiveRegistry](https://github.com/carsonswope/active_registry)


[active-record-lite]: https://github.com/appacademy/curriculum/tree/master/sql/projects/active_record_lite
[rails-lite]: https://github.com/appacademy/curriculum/tree/master/rails/projects/rails_lite
[renaming-repo]: https://help.github.com/articles/renaming-a-repository/

### Chess
  * Minimum features include:
    * A terminal-based graphical user interface
    * Move validation/check/checkmate
    * Computer AI
      * A random AI is a good first step, but is insufficient for the final build
      * Your AI should avoid check/checkmate and take opportunities to put opponents in check/checkmate. They should also take open pieces and make high-value trades (trading a pawn for a bishop, for example).
    * Most or all of the advanced moves (en passant, castling, etc.)
  * Have only 1 class per file - no matter how small the class
    * Name the files the same as the class (camel_cased)
  * Organize into /lib and /lib/pieces
  * Explain in README how someone would go about downloading and running this
    * Include in README a gif or video of the game in action
    * If using gifs or screenshots, have multiple showing off different features

#### Examples
  * [Chess in the Console](https://github.com/Razynoir/Chess)
  * [Chess w/ AI](https://github.com/collinksmith/chess)
  * [Terminal Chess](https://github.com/brianpgerson/terminal-chess)

### Other

#### Examples
  * [Algo Arena](https://cryptic-tundra-51153.herokuapp.com/)
  * [Soundscape](http://www.soundsscape.com/#/?_k=z8d5he)
  * [Pixpy](http://www.pixpy.tech/)
