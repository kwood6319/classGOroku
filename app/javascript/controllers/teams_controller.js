// app/javascript/controllers/teams_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  colors = [
    "#E63946", // red
    "#2A9D8F", // teal
    "#fdd777", // yellow
    "#9B5DE5", // purple
    "#F4A261", // orange
    "#3A86FF", // blue
    "#06D6A0", // green
    "#f87ab1", // pink
  ]

  connect() {
    // Mark the initial team's color as used
    this.usedColors = ["#E63946"]
  }

  addTeam() {
    const teamCount = this.containerTarget.querySelectorAll(".team-fields").length + 1
    const clone = this.containerTarget.querySelector(".team-fields").cloneNode(true)

    clone.querySelectorAll("input[type=text], input:not([type])").forEach(i => {
      i.value = `Team ${teamCount}`
    })

    const color = this.nextColor()
    clone.querySelectorAll("input[type=color]").forEach(i => {
      i.value = color
    })

    const removeBtn = document.createElement("button")
    removeBtn.type = "button"
    removeBtn.className = "btn-remove-team"
    removeBtn.textContent = "x"
    removeBtn.addEventListener("click", () => clone.remove())
    clone.appendChild(removeBtn)

    this.containerTarget.appendChild(clone)
  }

  nextColor() {
    const available = this.colors.filter(c => !this.usedColors.includes(c))

    // Reset if all colors used
    if (available.length === 0) {
      this.usedColors = []
      return this.colors[0]
    }

    const color = available[0]
    this.usedColors.push(color)
    return color
  }
}
