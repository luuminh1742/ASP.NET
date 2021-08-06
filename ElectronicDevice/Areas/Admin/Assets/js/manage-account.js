const clickMoveEmployeeToTrash = (id_account) => {
    let checkDelete = confirm("Xác nhận xóa tài khoản này!");
    if (checkDelete == false)
        return;

    $.ajax({
        url: '/Admin/Account/ChangeStatusAccount',
        data: { id_account: id_account, status: false },
        type: "GET",
        success: (result) => {
            if (result) {
                showAlertMessage('Di chuyển tài khoản nhân viên vào thùng rác!', true);
                $('#' + id_account).remove();
            } else {
                showAlertMessage('Xóa tài khoản nhân viên vào thất bại!', false);
            }
            

        },
        error: (error) => {
            //alert("Xãy ra lỗi trong quá trình xóa tài khoản!");
            showAlertMessage('Xãy ra lỗi trong quá trình xóa tài khoản!', false);
        }
    });
}

const loadFile = (event) => {
    var image = document.getElementById('output');
    image.src = URL.createObjectURL(event.target.files[0]);
};

let regexPassword = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*_]).{6,}$");

const clickChangePassword = (id_account) => {
    event.preventDefault();
    let newPassowrd = $('#NewPassword').val();
    let oldPassowrd = $('#OldPassword').val();
    let checkError = false;
    if (oldPassowrd == '') {
        $('#error_old_password').show();
        $('#error_old_password').text("Mật khẩu cũ không được để trống");
        checkError = true;
    }
    if (!regexPassword.test(newPassowrd)) {
        $('#error_new_password').show();
        $('#error_new_password').text("Mật khẩu ít nhất 6 ký tự và gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt!");
        checkError = true;
    }
    if ($('#NewPassword').val() != $('#ConfirmPassword').val()) {
        $('#error_confirm_password').show();
        $('#error_confirm_password').text("Nhập lại mật khẩu mới không trùng khớp!");
        checkError = true;
    }

    if (checkError) return;

    $.ajax({
        url: '/Admin/Account/UpdatePassword',
        data: {
            OldPassword: oldPassowrd,
            NewPassword: newPassowrd,
            ID_Account: id_account
        },
        type: "GET",
        success: (result) => {
            if (result) {
                //showAlertMessage('Cập nhật mật khẩu thành công!', true);
                //location.reload();
                window.location = '/Admin/Account?status=update_success';
            } else {
                $('#error_old_password').show();
                $('#error_old_password').text("Mật khẩu cũ không đúng!");
                $('#error_new_password').hide();
                $('#error_confirm_password').hide();
            }

        },
        error: (error) => {
            showAlertMessage('Cập nhật mật khẩu thất bại!',false);
        }
    });
}

const clickUpdateInfo = () => {

    let fullName = $('#FullName').val();
    let address = $('#Address').val();
    let email = $('#Email').val();
    let phone = $('#Phone').val();
    let checkError = false;
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    let phoneFormat = /^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/;
    if (fullName == '') {
        $('#error_full_name').show();
        $('#error_full_name').text('Họ tên không được để trống');
        checkError = true;
    }
    if (address == '') {
        $('#error_address').show();
        $('#error_address').text('Địa chỉ không được để trống');
        checkError = true;
    }
    if (!emailPattern.test(email)) {
        $('#error_email').show();
        $('#error_email').text('Lỗi định dạng email');
        checkError = true;
    }
    if (!phoneFormat.test(phone)) {
        $('#error_phone').show();
        $('#error_phone').text('Số điện thoại nhập không đúng định dạng');
        checkError = true;
    }
    if (checkError) event.preventDefault();

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
    setTimeout(() => {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    }, 3000);
};