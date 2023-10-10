// app/javascript/packs/basic-qr-code-reader.js

import { BrowserQRCodeReader } from "@zxing/library";
import Rails from "@rails/ujs";
import QRCode from "@zxing/library/esm/core/qrcode/encoder/QRCode";


const codeReader = new BrowserQRCodeReader();
codeReader
  .decodeFromInputVideoDevice(undefined, "video")
  .then((result) => {
    // process the result
    console.log(result.text);

    let qrDataReader = result.text;

    var formData = new FormData();

    let qrParams = {
      qrdata: qrDataReader,
    };

    formData.append("qr_code_json_data", JSON.stringify(qrParams));

    Rails.ajax({
      url: "/checkin",
      type: "post",
      data: formData,
      success: function(response) {
        console.log(response)
        alert("checkin success. 💪")
      },
      error: function(error) {
        alert(error)
      }
    });
    document.getElementById("result").textContent = result.text;
    // alert(result.text)
    
  })
  .catch((error) => {
    alert(error)
    console.log(error);
  });


  // by id
  // Let's assume you have a click event handler for the form submission button.
// You can also use other events like form submit, etc.
document.addEventListener("DOMContentLoaded", function() {
  const searchForm = document.getElementById("search-form");

  if (searchForm) {
    searchForm.addEventListener("submit", function(event) {
      event.preventDefault(); // Prevent the default form submission

      const idRegValue = searchForm.querySelector("[name='id_reg']").value;

      var formData = new FormData();
  
      formData.append("id_reg_json_data", JSON.stringify(idRegValue));
      
      Rails.ajax({
        url: "/checkin",
        type: "post",
        data: formData,
        success: function(response) {
          alert(response)
          console.log(response)
          document.getElementById("result").textContent = response;
        },
        error: function(error) {
          alert(error)
        }
      });
    });
  }
});
