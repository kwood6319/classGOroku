import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hidden", "content"]

  show() {
    this.hiddenTarget.style.display = "none"
    this.contentTarget.style.display = "block"
  }
}
