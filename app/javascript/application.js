// app/javascript/application.js

// --- Bootstrap ---
import "bootstrap"
import "../assets/stylesheets/application.sass.scss"
import "@hotwired/turbo-rails"

// --- Stimulus setup ---
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

// Start Stimulus
window.Stimulus = Application.start()

// Load all controllers in app/javascript/controllers
const context = require.context("./controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

console.log("✅ Stimulus + Bootstrap loaded")
