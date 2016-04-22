//Controlers urls


var url_flights = api_url + '/api/flights';
var url_agencies = api_url + '/api/agencies';
var url_hotels = api_url + '/api/hotels';
var url_clients = api_url + '/api/clients';
var url_guides = api_url + '/api/guides';
var url_invoice = api_url + '/api/Invoice'; 
var url_arrivals = api_url + '/api/arrivals';
var url_departures = api_url + '/api/departures'; 
var url_products = api_url + '/api/products';
var url_search = api_url + '/api/search';
var url_sales = api_url + '/api/sales';
var url_tour_plan = api_url +  '/api/tourplan';



// Common functions:

Date.prototype.yyyymmdd = function () {
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = this.getDate().toString();
    return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]); // padding
};


function isValid() {
    var isValid = true;
    $(".form-group").removeClass("has-error");
    var inputs = $(".form-group input[type='text'],.form-group input[type='tel'],.form-group input[type='radio'],.form-group input[type='time'], .form-group select");

    for (var i = 0; i < inputs.length; i++) {
        if (!inputs[i].validity.valid) {
            isValid = false;
            $(inputs[i]).closest(".form-group").addClass("has-error");
        }
    }


    if (isValid) {
        return true;
    }
    else {
        return false
    }

}