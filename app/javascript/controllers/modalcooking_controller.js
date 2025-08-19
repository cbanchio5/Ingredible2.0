import { Controller } from "stimulus";

export default class extends Controller {

  static targets = ["index", "content", "previous", "next"]
    initialize() {
      let step = this.indexTarget.innerText
      step = step.replace(/\D/g, '') * 1

      this.contentTarget.querySelectorAll('.step')[step -1].classList.remove('inactive--div')

      if (step === 1) {
        this.previousTarget.setAttribute("style", "display:none")
      } else {
        this.previousTarget.removeAttribute("style", "display:none")
        this.previousTarget.setAttribute("style", "display:flex")
      }
      let totalSteps = this.contentTarget.querySelectorAll('.step').length
      if (totalSteps < 2) {
        this.nextTarget.setAttribute("style", "display:none")
      }


    }

    open() {
      document.body.classList.add("modal-open");
      this.element.setAttribute("style", "display: block;");
      this.element.classList.add("show");
      document.body.innerHTML += '<div class="modal-backdrop fade show"></div>';
  }

  close() {
    document.body.classList.remove("modal-open");
    this.element.removeAttribute("style");
    this.element.classList.remove("show");
    document.getElementsByClassName("modal-backdrop")[0].remove();
}

  next() {

    //Get total steps of recipe
    let totalSteps = this.contentTarget.querySelectorAll('.step').length

    //Step text for div
    let step = this.indexTarget.innerText

    //Extract number of String
    let stepNumber = step.replace(/\D/g, '') * 1

    let nextStep = stepNumber + 1

    //Disable next button if current step is last step
    if (nextStep === totalSteps) {
      this.nextTarget.setAttribute("style", "display:none")
    } else {
      this.nextTarget.removeAttribute("style", "display:none")
      this.nextTarget.setAttribute("style", "display:flex")
    }

    //Able the previous button if not in first step

    if(nextStep > 1) {
      this.previousTarget.removeAttribute("style", "display:none")
      this.previousTarget.setAttribute("style", "display:flex")
    } else {
      this.previousTarget.setAttribute("style", "display:flex")
    }

    //Update step title

    this.indexTarget.innerText = step.replace(stepNumber, nextStep)

    //Add inactive class again to previous step
    this.contentTarget.querySelectorAll('.step')[stepNumber-1].classList.toggle('inactive--div')
    // this.contentTarget.querySelectorAll('.step')[stepNumber].classList.add('inactive--div')
    this.contentTarget.querySelectorAll('.step')[stepNumber].classList.toggle('inactive--div')
    //Remove inactive class to current step
    // this.contentTarget.querySelectorAll('.step')[stepNumber + 1].classList.remove('inactive--div')


  }

  previous() {
    //Get total steps of recipe
    let totalSteps = this.contentTarget.querySelectorAll('.step').length

    //Step text for div
    let step = this.indexTarget.innerText

    //Extract number of String
    let stepNumber = step.replace(/\D/g, '') * 1

    let previousStep = stepNumber - 1

    //Disable next button if current step is last step
    if (previousStep === totalSteps) {
      this.nextTarget.setAttribute("style", "display: none")
    } else {
      this.nextTarget.removeAttribute("style", "display:none")
      this.nextTarget.setAttribute("style", "display:flex")
    }


    //Able the previous button if not in first step

    if(previousStep > 1) {
      this.previousTarget.removeAttribute("style", "display:none")
      this.previousTarget.setAttribute("style", "display:flex")
    } else {
      this.previousTarget.setAttribute("style", "display: none")
    }


    //Update step title

    this.indexTarget.innerText = step.replace(stepNumber, previousStep)

    //Add inactive class again to next step
    this.contentTarget.querySelectorAll('.step')[previousStep].classList.toggle('inactive--div')

    //Add active class to previous step

    this.contentTarget.querySelectorAll('.step')[previousStep - 1].classList.toggle('inactive--div')

  }
}
