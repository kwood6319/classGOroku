import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  addTeam() {
    const teamCount = this.containerTarget.querySelectorAll(".team-fields").length + 1
    const clone = this.containerTarget.querySelector(".team-fields").cloneNode(true)

    clone.querySelectorAll("input[type=text], input:not([type])").forEach(i => {
      i.value = `Team ${teamCount}`
    })

    clone.querySelectorAll("input[type=color]").forEach(i => {
      i.value = this.randomColor()
    })

    this.containerTarget.appendChild(clone)
  }

  randomColor() {
    const colors = [
      "#E63946", "#2A9D8F", "#E9C46A", "#F4A261",
      "#457B9D", "#8338EC", "#FB5607", "#3A86FF",
      "#06D6A0", "#FF006E", "#FFBE0B", "#8ECAE6"
    ]
    return colors[Math.floor(Math.random() * colors.length)]
  }
}
