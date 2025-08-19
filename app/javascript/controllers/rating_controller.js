import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["link1", "link2", "link3", "link4", "link5", "rating"]


  getValue1() {
    let rating = this.link1Target.value * 1
    this.ratingTarget.value = rating

  }

  getValue2() {
    let rating = this.link2Target.value * 1
    this.ratingTarget.value = rating

  }

  getValue3() {
    let rating = this.link3Target.value * 1
    this.ratingTarget.value = rating

  }

  getValue4() {
    let rating = this.link4Target.value * 1
    this.ratingTarget.value = rating

  }

  getValue5() {
    let rating = this.link5Target.value * 1
    this.ratingTarget.value = rating

  }
}
