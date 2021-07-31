$(window).scroll(function () {
    if ($(window).scrollTop() >= $('#mainNav').height()) {
        $(".logo").attr('height', '84');
        $(".logo").attr('width', '84');
        $('#my_header').css('border-bottom', '1px solid #edeff2');
    } else {
        $(".logo").attr('height', 'auto');
        $(".logo").attr('width', '150');
        $('#my_header').css('border-block', 'none');
    }
});