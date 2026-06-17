import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const raw = document.getElementById("teams-data")?.dataset.teams
    this.teams = raw ? JSON.parse(raw) : []
  }

  selectSquare(event) {
    const square = event.currentTarget.dataset.index
    const squareLabel = parseInt(square) + 1

    document.getElementById("picker-square-label").textContent = squareLabel
    document.getElementById("turn-square").value = square

    // Build team buttons
    const list = document.getElementById("picker-team-list")
    list.innerHTML = ""

    this.teams.forEach(team => {
      const btn = document.createElement("button")
      btn.className = "picker-team-btn"
      btn.textContent = team.name
      btn.style.borderColor = team.color
      btn.style.color = team.color
      btn.addEventListener("click", () => this.selectTeam(team))
      list.appendChild(btn)
    })

    document.getElementById("team-picker-modal").style.display = "flex"
  }

  selectTeam(team) {
    document.getElementById("turn-team-id").value = team.id
    document.getElementById("team-picker-modal").style.display = "none"
    document.getElementById("turn-form").requestSubmit()
  }

  showLastInstruction(event) {
    const btn = event.currentTarget
    const box = document.getElementById("last-instruction-modal-box")
    document.getElementById("last-instruction-team").textContent = btn.dataset.team
    document.getElementById("last-instruction-text").textContent = btn.dataset.instruction
    box.style.borderTop = `6px solid ${btn.dataset.color}`
    document.getElementById("last-instruction-modal").style.display = "flex"
  }
}
