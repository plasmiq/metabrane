var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    //new Ajax.Request('/weaves.js?page=' + currentPage, {asynchronous:true, evalScripts:true, method:'get'});
    // console.log(currentPage);
    $.get( $(".endless").attr("data-action")+".js?page="+currentPage );
  } else {
    //console.log(currentPage);
    setTimeout(checkScroll, 250);
  }
  console.log(currentPage);
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
  if($(".endless")) {
    checkScroll();
  }
});
