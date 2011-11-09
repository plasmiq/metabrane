var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    $(".weaves_loader").fadeIn();
    $.get( $(".endless").attr("data-action")+".js?page="+currentPage );
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
