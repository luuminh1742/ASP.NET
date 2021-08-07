
$(document).ready(function () {

    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });


    $('#ReceiverNameMessage').hide();
    $('#ReceiverEmailMessage').hide();
    $('#ReceiverPhoneMessage').hide();
    $('#ReceiverAddressMessage').hide();

    $('#ReceiverName').keydown(function () {
        $('#ReceiverNameMessage').hide();
    });

    $('#ReceiverEmail').keydown(function () {
        $('#ReceiverEmailMessage').hide();
    });

    $('#ReceiverPhone').keydown(function () {
        $('#ReceiverPhoneMessage').hide();
    });

    $('#ReceiverAddress').keydown(function () {
        $('#ReceiverAddressMessage').hide();
    });

    $('#ReceiverName').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#ReceiverNameMessage').find('.message-content').text("Tên người nhận không được rỗng!");
            $('#ReceiverNameMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#ReceiverNameMessage').hide();
            $('#btn_submit').attr("type", "submit");
        }
    });

    $('#ReceiverEmail').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#ReceiverEmailMessage').find('.message-content').text("Email người nhận không được rỗng!");
            $('#ReceiverEmailMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!expr.test($(this).val())) {
                $('#ReceiverEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
                $('#ReceiverEmailMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#ReceiverEmailMessage').hide();
                $('#btn_submit').attr("type", "submit");
            }
        }

    });

    $('#ReceiverPhone').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#ReceiverPhoneMessage').find('.message-content').text("Số điện thoại người nhận không được rỗng!");
            $('#ReceiverPhoneMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            var val = /^[0]{1}[0-9]{9}$/;
            if (!val.test($(this).val())) {
                $('#ReceiverPhoneMessage').find('.message-content').text("Số điện thoại người nhận không hợp lệ!");
                $('#ReceiverPhoneMessage').show();
                $('#btn_submit').attr("type", "button");
            } else {
                $('#ReceiverPhoneMessage').hide();
                $('#btn_submit').attr("type", "submit");
            }
        }

    });

    $('#ReceiverAddress').focusout(function () {
        if ($(this).val() == "" || $(this).val() == null) {
            $('#ReceiverAddressMessage').find('.message-content').text("Địa chỉ người nhận không được rỗng!");
            $('#ReceiverAddressMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#ReceiverAddressMessage').hide();
            $('#btn_submit').attr("type", "submit");
        }
    });

    preLoad();
});

function preLoad() {
    if ($('#ReceiverName').val() == "" || $('#ReceiverName').val() == null) {
        $('#ReceiverNameMessage').find('.message-content').text("Tên người nhận không được rỗng!");
        $('#ReceiverNameMessage').show();
        $('#btn_submit').attr("type", "button");
    } else {
        $('#ReceiverNameMessage').hide();
        $('#btn_submit').attr("type", "submit");
    }

    if ($('#ReceiverEmail').val() == "" || $('#ReceiverEmail').val() == null) {
        $('#ReceiverEmailMessage').find('.message-content').text("Email người nhận không được rỗng!");
        $('#ReceiverEmailMessage').show();
        $('#btn_submit').attr("type", "button");
    } else {
        var expr = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!expr.test($('#ReceiverEmail').val())) {
            $('#ReceiverEmailMessage').find('.message-content').text("Email người nhận không hợp lệ!");
            $('#ReceiverEmailMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#ReceiverEmailMessage').hide();
            $('#btn_submit').attr("type", "submit");
        }
    }


    if ($('#ReceiverPhone').val() == "" || $('#ReceiverPhone').val() == null) {
        $('#ReceiverPhoneMessage').find('.message-content').text("Số điện thoại người nhận không được rỗng!");
        $('#ReceiverPhoneMessage').show();
        $('#btn_submit').attr("type", "button");
    } else {
        var val = /^[0]{1}[0-9]{9}$/;
        if (!val.test($('#ReceiverPhone').val())) {
            $('#ReceiverPhoneMessage').find('.message-content').text("Số điện thoại người nhận không hợp lệ!");
            $('#ReceiverPhoneMessage').show();
            $('#btn_submit').attr("type", "button");
        } else {
            $('#ReceiverPhoneMessage').hide();
            $('#btn_submit').attr("type", "submit");
        }
    }

    if ($('#ReceiverAddress').val() == "" || $('#ReceiverAddress').val() == null) {
        $('#ReceiverAddressMessage').find('.message-content').text("Địa chỉ người nhận không được rỗng!");
        $('#ReceiverAddressMessage').show();
        $('#btn_submit').attr("type", "button");
    } else {
        $('#ReceiverAddressMessage').hide();
        $('#btn_submit').attr("type", "submit");
    }
}


function showAlertMessage(message, messageState) {
    if (messageState) {
        $('#alert_message').css({ "background": "#C5F3D7", "border-left": "8px solid #2BD971" });
        $("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
        $("#icon-alert-message").find('i').css({ "color": "#2BD971" });
        $(".msg").css({ "color": "#24AD5F" });
        $(".close-btn-alert").css({ "background": "#2BD971", "color": "#24AD5F" });
        $(".close-btn-alert").find('.fas').css({ "color": "#24AD5F" });
        $(".close-btn-alert").hover(function (e) {
            $(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
        })
    } else {
        $('#alert_message').css({ "background": "#FFE1E3", "border-left": "8px solid #FF4456" });
        $("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
        $("#icon-alert-message").find('i').css({ "color": "#FE4950" });
        $(".msg").css({ "color": "#F694A9" });
        $(".close-btn-alert").css({ "background": "#FF9CA4", "color": "#FD4653" });
        $(".close-btn-alert").find('.fas').css({ "color": "#FD4653" });
        $(".close-btn-alert").hover(function (e) {
            $(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
        })
    }

    $('.msg').text(message);
    $('.alert').addClass("show");
    $('.alert').removeClass("hide");
    $('.alert').addClass("showAlert");
    setTimeout(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    }, 3000);
};