$(document).ready(function(){
    loadCurrentConditions();
});

function loadCurrentConditions() {
  $('#weatherButton').click(function (event) {
    //var haveValidationErrors = checkAndDisplayValidationErrors($('#addForm').find('input'));

    // if(haveValidationErrors) {
    //     return false;
    // }

      $.ajax({
         type: 'GET',
         url: 'http://api.openweathermap.org/data/2.5/weather?zip='+$('#addZipcode').val()+',us&units='+$('#setUnits').val()+'&appid=113c82cda502c2d2218f5f4e795da2ce',
         success: function(data, status) {
           alert(data.name);
             //$('#cityName').append(val(data.name));
             $('#currentCondition').show();
         },
         error: function () {
            alert("error");
             // $('#errorMessages')
             //  .append($('<li>')
             //  .attr({class: 'list-group-item list-group-item-danger'})
             //  .text('Error calling web service. Please try again later.'));
         }
      })
  });
}
