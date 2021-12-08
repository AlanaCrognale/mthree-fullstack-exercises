$(document).ready(function () {

    //only show content in main section on document load
    $("#akronInfoDiv").hide();
    $("#minneapolisInfoDiv").hide();
    $("#louisvilleInfoDiv").hide();

    //when city buttons clicked, display city content only (hide weather)
    $('#akronButton').on('click', function() {
      $('#mainInfoDiv').hide();
      $("#minneapolisInfoDiv").hide();
      $("#louisvilleInfoDiv").hide();
      $('#akronInfoDiv').show();
      $('#akronWeather').hide();
    });

    $('#minneapolisButton').on('click', function() {
      $('#mainInfoDiv').hide();
      $("#akronInfoDiv").hide();
      $("#louisvilleInfoDiv").hide();
      $('#minneapolisInfoDiv').show();
      $('#minneapolisWeather').hide();
    });

    $('#louisvilleButton').on('click', function() {
      $('#mainInfoDiv').hide();
      $("#minneapolisInfoDiv").hide();
      $("#akronInfoDiv").hide();
      $('#louisvilleInfoDiv').show();
      $('#louisvilleWeather').hide();
    });

    $('#mainButton').on('click', function() {
      $("#minneapolisInfoDiv").hide();
      $("#louisvilleInfoDiv").hide();
      $('#akronInfoDiv').hide();
      $('#mainInfoDiv').show();
    });

    //when weather button clicked, toggle show/hide for associated city weather
    $('#akronWeatherButton').on('click', function() {
      $("#akronWeather").toggle();
    });

    $('#minneapolisWeatherButton').on('click', function() {
      $("#minneapolisWeather").toggle();
    });

    $('#louisvilleWeatherButton').on('click', function() {
      $("#louisvilleWeather").toggle();
    });

    //change background color of row to whitesmoke when hovering
    $('.table tr').hover(
      //in callback
      function() {
          $(this).css('backgroundColor', 'whitesmoke');
      },
      //out callback
      function() {
          $(this).css('backgroundColor', '');
    });


});
