// Import Turbo from @hotwired/turbo-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = true

// Import Stimulus controllers
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))