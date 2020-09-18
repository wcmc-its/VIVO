$(document).ready(function() {
    //Remove links that don't go anywhere on page from secondary nav bar on profile pages
    if($('#property-group-menu li:only-child').length){
        $('#property-group-menu').hide();
        $('.property-group').css('border-top', 'none');
        $('nav.scroll-up').hide();
    }
    if(!$("#overview").length){
        $('li a[href="#overview"]').parent().hide();
    }
    if(!$("#affiliation").length){
    	$('li a[href="#affiliation"]').parent().hide();
    }
    //Smooth scroll (meant for profile pages)
    $('a[href*=#][title="group name"]:not([href=#])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
            || location.hostname == this.hostname) {

            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
               if (target.length) {
                 $('html,body').animate({
                     scrollTop: target.offset().top
                }, 1000);
                 $(target).addClass("targeted");
                 setTimeout(function(){
                    $(target).removeClass("targeted");},1500);
                return false;
            }
        }
    });
});