
function Agency(data) {
    this.ID = ko.observable(data.ID);
    this.name = ko.observable(data.name);
    this.address = ko.observable(data.address);
}

function Product(data) {
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
    self.products = ko.observableArray([]);
    self.sales = ko.observableArray([]);


    //fields 
    self.date_arr = ko.observable();
    self.agency_fk = ko.observable();
    self.product_fk = ko.observable();
    self.sale_type = ko.observable('BIZ');


    self.PNR = ko.observable();
    self.names = ko.observable();
    self.persons = ko.observable();
    self.persons_max = ko.observable();

    self.agency_filter_name = ko.observable();
    self.date_arr_filter = ko.observable();

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
    //get services from server:
    $.getJSON(url_products, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new Product(item);
        });
        self.products(mappedData);
    });

    /// Subscriptions

    self.agency_filter_name.subscribe(function (_new) {
        if (_new == undefined) { _new = '' }
        dataTable.column(4).search(_new).draw();

    });


    self.date_arr_filter.subscribe(function (_new) {
        dataTable.column(3).search(_new).draw();

    });

    //// Operations
    self.add = function () {
        if (isValid()) {
            var _sale = {
                PNR: self.PNR(),
                product_fk: self.product_fk(),
                sale_type: self.sale_type(),
                persons: self.persons()
            };

            $.post(url_sales, _sale, function (sale_from_server) {
                self.sales.push(new Sale(_sale));
                self.product_fk('');
                self.persons(self.persons_max());
                self.show_table();

            });
        }
    };

    self.remove_server = function (hotel) {
        //TODO: use PUT with boolean 'deleted'


        //$.ajax({
        //    url: _url + '/' + hotel.ID(),
        //    type: 'DELETE',
        //}).done(function () {
        //    self.hotels.remove(hotel)
        //}).fail(function (error) {
        //    alert("error");
        //});
    }



    //self.agency_name.subscribe(function (new_) {

    //});


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
                    //"data": mappedData,
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
Date.prototype.yyyymmdd = function () {
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = this.getDate().toString();
    return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]); // padding
};





