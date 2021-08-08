
//============ Bat loi cap nhat thong tin ca nhan - Start ======================

//const { error } = require("jquery");

let regexPassword = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*_]).{6,}$");
let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
let phoneFormat = /^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/;
let checkErrorUpdateInfo = false;
//-------------------------------------------
// Bat loi username
const errorUsername = () => {
    let username = $('#UserName').val();
    if (username == '') {
        $('#error_username').show();
        $('#error_username').text('Tên đăng nhập không được để trống');
        checkErrorUpdateInfo = true;
    } else if (username.search(' ') > 0) {
        $('#error_username').show();
        $('#error_username').text('Tên đăng nhập không được chứa khoảng trắng');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_username').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#UserName').keydown(() => {
    errorUsername();
});
$('#UserName').keyup(() => {
    errorUsername();
});
//-------------------------------------------
// Bat loi full name
const errorFullName = () => {
    if ($('#FullName').val() == '') {
        $('#error_full_name').show();
        $('#error_full_name').text('Họ tên không được để trống');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_full_name').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#FullName').keydown(() => {
    errorFullName();
});
$('#FullName').keyup(() => {
    errorFullName();
});

//------------------------------------------------
// Bat loi address
const errorAddress = () => {
    if ($('#Address').val() == '') {
        $('#error_address').show();
        $('#error_address').text('Địa chỉ không được để trống');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_address').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Address').keydown(() => {
    errorAddress();
});
$('#Address').keyup(() => {
    errorAddress();
});
//------------------------------------------------
// Bat loi email
const errorEmail = () => {
    let email = $('#Email').val();
    if (email == '') {
        $('#error_email').show();
        $('#error_email').text('Email không được để trống');
        checkErrorUpdateInfo = true;
    } else if (!emailPattern.test(email)) {
        $('#error_email').show();
        $('#error_email').text('Lỗi định dạng email');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_email').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Email').keydown(() => {
    errorEmail();
});
$('#Email').keyup(() => {
    errorEmail();
});
//------------------------------------------------
// Bat loi phone
const errorPhone = () => {
    let phone = $('#Phone').val();
    if (phone == '') {
        $('#error_phone').show();
        $('#error_phone').text('Số điên thoại không được để trống');
        checkErrorUpdateInfo = true;
    } else if (!phoneFormat.test(phone)) {
        $('#error_phone').show();
        $('#error_phone').text('Số điện thoại nhập không đúng định dạng');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_phone').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Phone').keydown(() => {
    errorPhone();
});
$('#Phone').keyup(() => {
    errorPhone();
});
//------------------------------------------------------------------------
// Bat lo mat khau 
const errorPassword = () => {
    let Passowrd = $('#Password').val();
    if (Passowrd == '') {
        $('#error_password').show();
        $('#error_password').text("Mật khẩu mới không được bỏ trống!");
        checkErrorUpdateInfo = true;
    } else if (!regexPassword.test(Passowrd)) {
        $('#error_password').show();
        $('#error_password').text("Mật khẩu ít nhất 6 ký tự và gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt!");
        checkErrorUpdateInfo = true;
    } else {
        $('#error_password').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Password').keydown(() => {
    errorPassword();
});
$('#Password').keyup(() => {
    errorPassword();
});
//============ Bat loi cap nhat thong tin ca nhan - End ======================

const clickSaveInforUser = () => {
    errorUsername();
    errorFullName();
    errorEmail();
    errorPhone();
    errorAddress();
    errorPassword();

    if (checkErrorUpdateInfo) event.preventDefault();
}