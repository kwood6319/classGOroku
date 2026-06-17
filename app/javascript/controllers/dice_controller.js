import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["result"]

  roll() {
    const result = Math.floor(Math.random() * 6) + 1
    this.resultTarget.textContent = result
  }
}
