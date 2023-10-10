// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import {get } from "@rails/request.js"

export default class extends Controller {
    static targets = ["stateSelect", "tglkunjunganSelect"]

    poli(event) {
        let poli = event.target.selectedOptions[0].value
        let target = this.stateSelectTarget.id
            // console.log(target)
        get(`/antrian/dokter?target=${target}&poli=${poli}`, {
            responseKind: "turbo-stream"
        })
    }

    jadwal_poli(event) {

        let jadwal = event.target.selectedOptions[0].value
        let target = this.tglkunjunganSelectTarget.id

        get(`/antrian/jadwal_poli?target=${target}&jadwal_poli=${jadwal}`, {
            responseKind: "turbo-stream"
        })
    }
}