// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'bootstrap'
import 'url-polyfill'

// Turbolinks for super fast page loads

import Turbolinks from 'turbolinks'
Turbolinks.start()

// Load stimulus for application
// Schedules uses stimulus for JavaScript components, which is a much
// more lightweight solution than React, for example
//
// Read more here: https://stimulusjs.org/handbook/origin
// It's really cool.

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('src/controllers', true, /\.js$/)
application.load(definitionsFromContext(context))
