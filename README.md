# About this App
This is a test project to learn how best to use client-side javascript in a Rails application.  It is a work in progress and is _definitely_ not a polished application.

## Rationale
This is not about speed.  It is possible to get fast page loads using Rails Russian doll caching and various other techniques.

What caching doesn't get you is an app-like feel.  You get an app that feels like a website, because the kind of rich interactions that make an app feel "native" are _javascript_.

This demo app is about using javascript to create rich interfaces that are only possible in the client-side.

## Highlights

### Libraries
* **No Ember, No Backbone.** From my research, both of these can be overkill, particularly when you aren't trying to write an app entirely in the client side.
* **RequireJS**. (Using the [requirejs-rails]() gem) Eliminates dependency problems, and structures the code in AMD modules.  
	* This gives the app structure without using a more "sophisticated" framework.
	* From my unscientific research, it seems that AMD modules will be the preferred way of distributing javascript, thanks to node.
* **KnockoutJS**.  Eliminates a lot of glue code and lets you write dynamic interfaces without worrying about updating your HTML.
* **Lodash**.  Javascript syntactic sugars.
* **CoffeeScript**.  Because I'm a javascript noob.  Forgive me.

### Positives so Far

* **Choose where you want client-side behavior.**  This structure doesn't require you to rewrite your whole app in javascript.
* **Keep your templating language.** You can use HAML/SLIM if that's your thing.
* **Modular design lets you drop interfaces into your view throughout your app.**

## Structure
The javascript for the app is included in the asset pipeline, under `app/assets/javascripts`.

```
|-- app
|   |-- assets
|       |-- javascripts
|           |-- modules
|           |-- application.js.coffee
```
The `modules` folder is intended to store each AMD module that the app uses.  An example of a module would be a task interface, where you can add, edit, and complete tasks.

Each module is designed to be self-contained, with everything it needs to function.  Each consists of the following files and folders:

```
|-- module_name/
|   |-- module_name.js.coffee
|   |-- models/
|       |-- any client-side models this module needs
|   |-- templates/
|       |-- any HTML you need for the module
```

To be continued...
