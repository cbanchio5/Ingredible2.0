// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
// Import controllers manually
import DemoController from "./demo_controller"
import Demo1Controller from "./demo_controller"
import ModalController from "./modal_controller"
import ModalCookingController from "./modalcooking_controller"
import RatingController from "./rating_controller"


const application = Application.start()
//const context = require.context("controllers", true, /_controller\.js$/)
//application.load(definitionsFromContext(context))


application.register("demo", DemoController)
application.register("demo1", Demo1Controller)
application.register("modal", ModalController)
application.register("rating", RatingController)
application.register("modalcooking", ModalCookingController)

export { application }









