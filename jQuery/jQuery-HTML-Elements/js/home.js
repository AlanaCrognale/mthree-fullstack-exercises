$(document).ready(function () {

  //center all H1 elements
  $("h1").addClass('text-center');

  //center all H2 elements
  $("h2").addClass('text-center');

  //Change the text of "The Squad" to "Yellow Team".
  $("#yellowHeading").text("Yellow Team");

  //Change the background color for each team list to match the name of the team.
  $("#orangeTeamList").css("color","orange");
  $("#blueTeamList").css("color","blue");
  $("#redTeamList").css("color","red");
  $("#yellowTeamList").css("color","yellow");

  //Add Joseph Banks and Simon Jones to the Yellow Team list.
  $("#yellowTeamList").append("<li>Joseph Banks</li>");
  $("#yellowTeamList").append("<li>Simon Jones</li>");

  //Hide the element containing the text "Hide Me!!!"
  $("#oops").hide();

  //Remove the element containing the text "Bogus Contact Info" from the footer.
  $("#footerPlaceholder").remove();

  //Add a paragraph element containing your name and email to the footer.
  //The text must be in Courier font and be 24 pixels in height.
  $(".footer").append("p").text("Alana Crognale crognale.alana@gmail.com").css({"fontFamily": "Courier", "fontSize": "24px"});


});
