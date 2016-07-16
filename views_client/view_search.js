//var col_names = 2;
//var col_date_arr = 5;
//var col_date_dep = 7;
//var col_hotel = 8;
//var col_agency = 9;

var col_names = 1;
var col_date_arr = 4;
var col_date_dep = 6;
var col_hotel = 7;
var col_agency = 8;
var col_phone = 9;




function Agency(data) {
    this.ID = ko.observable(data.ID);
    this.name = ko.observable(data.name);
    this.address = ko.observable(data.address);
}

function Product(data) {
    this.ID = ko.observable(data.ID);
    this.name = ko.observable(data.name);
}

function Hotel(data) {
    this.ID = ko.observable(data.ID);
    this.name = ko.observable(data.name);
}


function Sale(data) {
    this.PNR = ko.observable(data.PNR);
    this.product_fk = ko.observable(data.product_fk);
    this.persons = ko.observable(data.persons);
    this.price = ko.observable(data.price);
    this.sale_type = ko.observable(data.sale_type);
    this.date_sale = ko.observable(data.date_sale);
    this.date_update = ko.observable(data.date_update);
    this.paid = ko.observable(data.paid);

}


function SaleViewModel(data) {

    var self = this;
    ///

    //arrays
    self.agencies = ko.observableArray([]);
    self.hotels = ko.observableArray([]);
    // self.sales = ko.observableArray([]);


    //fields 
    self.date_arr = ko.observable();
    self.date_dep = ko.observable();
    self.agency_fk = ko.observable();
    self.product_fk = ko.observable();
    self.sale_type = ko.observable('External');

    self.PNR = ko.observable();
    self.names = ko.observable();
    self.persons = ko.observable();
    self.persons_max = ko.observable();


    self.agency_name = ko.observable();
    self.hotel_name = ko.observable();

    //fields for new record
    self.product_fk_new = ko.observable();
    self.type_sale_new = ko.observable();

    //get agencies from server:
    $.getJSON(url_agencies, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new Agency(item);
        });
        self.agencies(mappedData);
    });
    //get hotels from server:
    $.getJSON(url_hotels, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new Hotel(item);
        });
        self.hotels(mappedData);
    });


    /// Subscriptions

    self.date_arr.subscribe(function (_new) {
        //if (_new == undefined) { _new = '' }
        dataTable.column(col_date_arr).search(_new).draw();
    });

    self.date_dep.subscribe(function (_new) {
        //if (_new == undefined) { _new = '' }
        dataTable.column(col_date_dep).search(_new).draw();
    });

    self.hotel_name.subscribe(function (_new) {
        if (_new == undefined) { _new = '' }
        dataTable.column(col_hotel).search(_new).draw();
    });

    self.agency_name.subscribe(function (_new) {
        //var agency = my.viewModel.agency_name();
        //var hotel = my.viewModel.hotel_name();
        if (_new == undefined) { _new = '' }
        dataTable.column(col_agency).search(_new).draw();
    });


    self.remove_server = function (hotel) {
    }


    var tbl;
    self.show_table = function () {
        if (self.PNR()) {
            var _url = url_sales +
            '?PNR=' + self.PNR();

            if (tbl) {
                tbl.ajax.url(_url).load();
            }

            else {
                tbl = $('#tbl_sales').DataTable({
                    "ajax": _url,
                    "searching": false,
                    "info": false,
                    "footer": false,
                    "paging": false,
                    "sAjaxDataProp": "",

                    "columns": [

                        { "data": "product_name", },
                        { "data": "persons" },
                        { "data": "sale_type" },

                    ],

                    "dom": '<"toolbar">rtip',
                });
                //$("div.toolbar").append('<a class="dt-button buttons-copy buttons-html5" tabindex="0" aria-controls="tbl"><span>TEST</span></a>');

            }


            //tbl.on('xhr', function () {
            //    var json = tbl.ajax.json();
            //    debugger;

            //});

        };

    }
}
//Date.prototype.yyyymmdd = function () {
//    var yyyy = this.getFullYear().toString();
//    var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
//    var dd = this.getDate().toString();
//    return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]); // padding
//};





