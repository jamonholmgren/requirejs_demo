# About this App
This is a test project to learn how best to use client-side javascript in a Rails application.  It is a work in progress and is _definitely_ not a polished application.

## Setup
1. Clone the repository.  `git clone git@github.com:danielberkompas/requirejs_demo.git`
2. Create an RVM gemset and .rvmrc file if you're using RVM.
3. `bundle install`
4. `rake db:migrate`
5. `rails s`
6. Visit the app at `localhost:3000`.

## Rationale
This is not about speed.  It is possible to get fast page loads using Rails Russian doll caching and various other techniques.

What caching doesn't get you is an app-like feel.  You get an app that feels like a website, because the kind of rich interactions that make an app feel "native" really _require javascript_.

This demo app is about using javascript to create rich interfaces that are only possible in the client-side.

## Highlights

### Libraries
* **No Ember, No Backbone.** From my research, both of these can be overkill, particularly when you aren't trying to write an app entirely in the client side.
* **[RequireJS](http://requirejs.org)**. (Using the [requirejs-rails](https://github.com/jwhitley/requirejs-rails) gem) Eliminates dependency problems, and structures the code in AMD modules.  
	* This gives the app structure without using a more "sophisticated" framework.
	* From my unscientific research, it seems that AMD modules will be the preferred way of distributing javascript, thanks to node.
* **[KnockoutJS](http://knockoutjs.com)**.  Eliminates a lot of glue code and lets you write dynamic interfaces without worrying about updating your HTML.
* **[Knockout Class Binding Provider](https://github.com/rniemeyer/knockout-classBindingProvider).** Makes Knockout bindings much easier to use, by abstracting them from the view.
* **[Lodash](http://lodash.com)**.  Javascript syntactic sugars.
* **[CoffeeScript](http://coffeescript.org)**.  Because I'm a javascript noob.  Forgive me.

### Positives So Far

* **Choose where you want client-side behavior.**  This structure doesn't require you to rewrite your whole app in javascript.
* **Keep your templating language.** You can use HAML/SLIM if that's your thing.
* **Modular design lets you drop interfaces into your view throughout your app.**  You basically can make javascript-powered interfaces as "widgets" throughout your app.
* **No more glue code.** You know what I'm talking about.  Changing values, ajaxing to the server, then updating the interface, hiding and showing links in different states.

### Needs Work

* **Test Framework.** I'm taking a look at Mocha.
* **More Abstraction/Inheritance.** I think I could extract the setup method into a base view model <s>and extract the persistence part of the Task model into a base object.</s>

## Structure
The javascript for the app is included in the asset pipeline, under `app/assets/javascripts`.

<pre>
|-- app
|   |-- assets
|       |-- javascripts
|           |-- modules
|           |-- application.js.coffee
</pre>

The `modules` folder is intended to store each AMD module that the app uses.  An example of a module would be a task interface, where you can add, edit, and complete tasks.

Each module is designed to be self-contained, with everything it needs to function.  Each consists of the following files and folders:

<pre>
|-- module_name/
|   |-- module_name.js.coffee
|   |-- models/
|       |-- any client-side models this module needs
|   |-- views/
|       |-- any HTML you need for the module
</pre>

### Inspired by Gems
You should be able to require any module by simply requiring the `module_name.js` file.  It contains the main ViewModel (Read more in Knockout's documentation for ViewModels) and requires all the other files it needs.

Every UI-related module has a `setup()` method which takes a jQuery selector. (i.e. `viewModel.setup(".some-wrapper-div")`) The module then inserts its UI into that selected div.

**Models** are also _technically_ view models, in that they have observable properties (Again see Knockout docs).  However, they often map more directly to some server-side model in Rails, and may contain logic to save themselves to Rails via an API.

To be continued...
