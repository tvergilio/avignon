// Put your application scripts here
var CSRF_TOKEN = '';

function configureCSRF() {
    $.ajax({
        type: 'GET', url: '/api/v1/sessions/csrf_token',
        async: false,
        cache: false,
        success: function (data, textStatus, jqXHR) {
            CSRF_TOKEN = data.csrf;
        },
        fail: function (data, textStatus, jqXHR) {
        }
    })
}