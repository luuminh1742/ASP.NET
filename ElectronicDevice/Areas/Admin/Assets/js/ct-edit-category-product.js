
let checkErrorCategory = false;
$('#error_name').hide();
$('#error_image').hide();

$('input').keydown( () => {
    if ($('#Name').val() == "") {
        $('#error_name').show();
        $('#error_name').text("Tên danh mục không được bỏ trống");
        checkErrorCategory = true;
    } else {
        $('#error_name').hide();
        checkErrorCategory = false;
    }
});

$('input').keyup(() => {
    if ($('#Name').val() == "") {
        $('#error_name').show();
        $('#error_name').text("Tên danh mục không được bỏ trống");
        checkErrorCategory = true;
    } else {
        $('#error_name').hide();
        checkErrorCategory = false;
    }
    

});

$("#inputFile").change( () => {
    let file = $('#inputFile')[0].files[0];
    if (file == null) {
        $('#error_image').show();
        $('#error_image').text("Ảnh danh mục không được để trống");
        checkErrorCategory = true;
    } else {
        $('#error_image').hide();
        checkErrorCategory = false;
    }
    
});


const clickSaveCategory = () => {
    let data = {};
    data["Name"] = $('#Name').val();
    if (data["Name"] == "") {
        $('#error_name').show();
        $('#error_name').text("Tên danh mục không được bỏ trống");
        checkErrorCategory = true;
    } else {
        $('#error_name').hide();
        checkErrorCategory = false;
    }
    data["Status"] = $("#show").is(":checked") ? true : false;
    data["ID_Category"] = 0;
    data["ID_Category"] = Number($('#id').val());


    let file = $('#inputFile')[0].files[0];
    if (data["ID_Category"] == 0 && file == null) {
        $('#error_image').show();
        $('#error_image').text("Ảnh danh mục không được để trống");
        checkErrorCategory = true;
    }

    if (checkErrorCategory) return;
    if (file != undefined) {
        var reader = new FileReader();
        reader.onload = function (e) {
            data["Base64"] = e.target.result;
            data["Icon"] = file.name;
            if (data["ID_Category"] == 0) {
                addData(data);
            } else {
                editData(data);
            }
        };
        reader.readAsDataURL(file);
    } else {
        data["Icon"] = $('#imagename').val();
        if (data["ID_Category"] == 0) {
            addData(data);
        } else {
            editData(data);
        }
    }


}

const addData = (data) => {
    $.ajax({
        url: '/Admin/Category/AddProductCategory',
        data: JSON.stringify(data),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: (result) => {
            showAlertMessage('Thêm danh mục thành công!', true);
            //$('#modal-create').modal().hide();
            //$("#modal-create").modal({ backdrop: false });
            //$('.modal-backdrop').remove();
            $('#modal-create').modal().hide();
            $('.modal-backdrop').remove();
            //alert("Thêm danh mục thành công.");
            //$("#modal-create").modal("hide");

            setDataCategory(
                result["ID_Category"],
                result["Name"],
                result["Icon"],
                result["Status"],
                result["Products"].length,
                per_edit,
                per_del
            );
        },
        error: (error) => {
            //alert("Thêm danh mục thất bại!");
            showAlertMessage('Thêm danh mục thất bại!', false);
        }
    });
}
const editData = (data) => {

    $.ajax({
        url: '/Admin/Category/AddProductCategory',
        data: JSON.stringify(data),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: (result) => {
            showAlertMessage('Cập nhật danh mục thành công!', true);

            //$('#modal-create').modal().hide();
            //$("#modal-create").modal({ backdrop: false });
            //$('.modal-backdrop').remove();
            //alert("Cập nhật danh mục thành công.");
            $('#modal-create').modal().hide();
            $('.modal-backdrop').remove();
            editCategory(
                result["ID_Category"],
                result["Name"],
                result["Icon"],
                result["Status"],
                result["Products"].length,
                per_edit,
                per_del
            );

            //$('#modal-create').modal().hide();
            //location.reload();
        },
        error: (error) => {
            showAlertMessage('Cập nhật danh mục thất bại!', false);
            //alert("Cập nhật danh mục thất bại!");
        }
    });
}


const setDataCategory = (id, name, icon, status,size_product, per_edit, per_del) => {
    let showStatus = status ? "Hiển thị" : "Ẩn";
    let f_edit = '';
    let f_del = '';
    if (per_edit) {
        f_edit = 'title="Sửa" data-toggle="modal" data-target="#modal-create"' +
            'onclick="clickEditCategory(' + id + ',\'' + name + '\',\'' + icon + '\',' + status + ')"';
    } else {
        f_edit = 'onclick="clickPer()"';
    }
    if (per_del) {
        f_del = 'onclick="deleteCategory(' + id + ')"';
    } else {
        f_del = 'onclick="clickPer()"';
    }
    $('#data-category').append(
        '<tr class="tr-shadow" id="' + id + '">' +
        '<td class="block-icon">' +
        '<img src="/wwwroot/imageUpload/' + icon +
        '" alt="Icon" style="max-width: 25px; max-height: 25px;"/>' +
        '</td>' +
        '<td>' +
        '<span class="block-name-product" id="name-product">' + name + '</span>' +
        '</td>' +
        '<td>' +
        '<span class="status--process" id="show-status">' + showStatus + '</span>' +
        '</td>' +
        '<td>' +
        '<span  >' + size_product + '</span>' +
        '</td>' +
        '<td>' +
        '<div class="table-data-feature">' +
        '<button class="item" title="Sửa" ' + f_edit+'>' +
        '<i class="fas fa-pencil-alt"></i>' +
        '</button>' +
        '<button class="item" title="Xóa" ' + f_del + ' >' +
        '<i class="fas fa-trash-alt"></i>' +
        '</button>' +
        '<a class="item" title="Xem danh sách sản phẩm" href="/Admin/Product?id_category='+id+'">'+
        '<i class= "fas fa-arrow-right" ></i>'+
         '</a >'+
        '</div>' +
        ' </td>' +
        '</tr>' +
        ' <tr class="spacer" id="spacer-' + id + '"></tr>'
    );
}

const editCategory = (id, name, icon, status, size_product, per_edit, per_del) => {
    let showStatus = status ? "Hiển thị" : "Ẩn";
    let f_edit = '';
    let f_del = '';
    if (per_edit) {
        f_edit = 'title="Sửa" data-toggle="modal" data-target="#modal-create"' +
            'onclick="clickEditCategory(' + id + ',\'' + name + '\',\'' + icon + '\',' + status + ')"';
    } else {
        f_edit = 'onclick="clickPer()"';
    }
    if (per_del) {
        f_del = 'onclick="deleteCategory(' + id + ')"';
    } else {
        f_del = 'onclick="clickPer()"';
    }
    $('#' + id).html(
        '<td class="block-icon">' +
        '<img src="/wwwroot/imageUpload/' + icon +
        '" alt="Icon" style="max-width: 25px; max-height: 25px;"/>' +
        '</td>' +
        '<td>' +
        '<span class="block-name-product" id="name-product">' + name + '</span>' +
        '</td>' +
        '<td>' +
        '<span class="status--process" id="show-status">' + showStatus + '</span>' +
        '</td>' +
        '<td>' +
        '<span >' + size_product + '</span>' +
        '</td>' +
        '<td>' +
        '<div class="table-data-feature">' +
        '<button class="item" title="Sửa" ' + f_edit + '>' +
        '<i class="fas fa-pencil-alt"></i>' +
        '</button>' +
        '<button class="item" title="Xóa" ' + f_del + ' >' +
        '<i class="fas fa-trash-alt"></i>' +
        '</button>' +
        '<a class="item" title="Xem danh sách sản phẩm" href="/Admin/Product?id_category=' + id + '">' +
        '<i class= "fas fa-arrow-right" ></i>' +
        '</a >' +
        '</div>' +
        ' </td>'
    );
}