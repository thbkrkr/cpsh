function getParam(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// https://code.google.com/p/microajax/
function microAjax(B,A){this.bindFunction=function(E,D){return function(){return E.apply(D,[D])}};this.stateChange=function(D){if(this.request.readyState==4){this.callbackFunction(this.request.responseText)}};this.getRequest=function(){if(window.ActiveXObject){return new ActiveXObject("Microsoft.XMLHTTP")}else{if(window.XMLHttpRequest){return new XMLHttpRequest()}}return false};this.postBody=(arguments[2]||"");this.callbackFunction=A;this.url=B;this.request=this.getRequest();if(this.request){var C=this.request;C.onreadystatechange=this.bindFunction(this.stateChange,this);if(this.postBody!==""){C.open("POST",B,true);C.setRequestHeader("X-Requested-With","XMLHttpRequest");C.setRequestHeader("Content-type","application/x-www-form-urlencoded");C.setRequestHeader("Connection","close")}else{C.open("GET",B,true)}C.send(this.postBody)}};

// Built API URL from the current window URL
var urlArr = window.location.href.split("/");
var apiUrl = urlArr[0] + "//" + urlArr[2];

// GET $API/path and replace an HTML element with a Ractive template 
// populated by the API call JSON response.
function get(path, cb, el, raw) {
    if (el) {
        var loader = setTimeout(function() {
            console.log("loader");
            elId = el.replace('#', '');
            document.getElementById(elId).innerHTML = '<div class="spinner"></div>';
        }, 200);
    }

    microAjax(apiUrl + path, function(data) {
        if (!raw) {
            data = JSON.parse(data);
        }
        if (cb) {
            cb(data);
        }
        if (el) {
            clearTimeout(loader);
        }
    });
};

Ractive.DEBUG = false;