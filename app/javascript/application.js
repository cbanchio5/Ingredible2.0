// app/javascript/application.js

// --- Bootstrap ---
import "bootstrap"
import "@hotwired/turbo-rails"

// --- Stimulus setup ---
import { Application } from "@hotwired/stimulus"
//import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

//import { application } from "./controllers/index"
//import "./controllers" // auto-load all controllers

import "./controllers/index"


// Start Stimulus
window.Stimulus = Application.start()



console.log("✅ Stimulus + Bootstrap loaded")



