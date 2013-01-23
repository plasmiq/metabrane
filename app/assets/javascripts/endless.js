var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    $(".weaves_loader").fadeIn();
    var select = $("#metatags_sorting");
    var order = select.val();
    $.ajax( {
      url: $(".endless").attr("data-action")+"?page="+currentPage+"&order="+order,
      dataType: "script"
    } );
  } else {
    setTimeout(checkScroll, 250);
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

$(document).ready( function() {
  if($(".endless").size() > 0) {
    checkScroll();
  }
});
