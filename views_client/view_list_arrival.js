
var _url_flights_in = url_flights+'/getFlights2Days/in/';
var _url_print = '../print/ListArrival_Print.aspx?';

function Flight(data) {
    this.num = ko.observable(data.num);
    var _date = new Date(data.date).yyyymmdd();
    this.date = ko.observable(_date);
    this.time = ko.observable(data.time);
    this.sum = ko.observable(data.sum);
    this.selected = ko.observable(false);


}


function FlightViewModel(data) {

    var self = this;
    ///
    self.flights = ko.observableArray([]);
    self.date_start = ko.observable();
    self.date_end = ko.observable();
    self.print_url = ko.observable();

    self.selected_flights = ko.computed(function () {
        var arr = self.flights();
        return ko.utils.arrayFilter(arr, function (flight) {
            return flight.selected();
        });
    });

    self.date_start.subscribe(function (newValue) {
        var _url = _url_flights_in + newValue;
        $.getJSON(_url, function (allData) {
            var mappedData = $.map(allData, function (item) {
                return new Flight(item);
            });
            self.flights(mappedData);

        });
        self.update_print_url();

    });


    self.select = function (flight) {
        flight.selected(!flight.selected())
        self.update_print_url();

    };

    self.date_end.subscribe(function (new_date_end) {
        self.update_print_url();
    });

    self.update_print_url = function () {


        if (self.date_start() && self.selected_flights().length > 0 && self.date_end()) {


            var url = _url_print +
                        'date_start=' + self.date_start() +
                        '&date_end=' + self.date_end() +
                        '&flights=' + self.get_flights_str();

            self.print_url(url);
        }
    };


    self.total_sum = ko.computed(function () {
     
        if (self.selected_flights().length>0) {
            var total = 0;
            for (var p = 0; p < self.selected_flights().length; ++p) {
               
                total += self.selected_flights()[p].sum();
            }
            return total;
        }
        else return 0;

    });




    self.get_flights_str = function () {
        var _flights = "";
        var Flights = self.selected_flights();
        for (var i = 0; i < Flights.length; i++) {

            //if (Flights[i].selected()) {

            var num = Flights[i].num();
            var date = Flights[i].date();
            _flights += num + '_' + date + '~';
            //}
        }
        _flights = _flights.replace(/~$/, "");
        return _flights;
    };






}





    //Date.prototype.yyyymmdd = function () {
    //    var yyyy = this.getFullYear().toString();
    //    var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
    //    var dd = this.getDate().toString();
    //    return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]); // padding
    //};

