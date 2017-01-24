$(document).ready(function(){
  $("#minesweeper td").click(function(e) {
    $el = $(e.target);
    $.ajax({
      data: {row: $el.find($(".row")).val(), col: $el.find($(".col")).val()},
      url: "games/0/get_adjacent_mines", type: "GET"
    });
  });
});
