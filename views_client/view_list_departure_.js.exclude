var _url_flights_out = url_flights + '/getFlights2Days/out/';
var _url_print = '../print/ListDeparture_Print.aspx?';

function Flight(data) {
    this.num = ko.observable(data.num);
    var _date = new Date(data.date).yyyymmdd();
    this.date = ko.observable(_date);
    this.time = ko.observable(data.time);
    this.sum = ko.observable(data.sum);
    this.selected = ko.observable(false);
}


function Plan(data, isEditMode) {
    this.depart_list = ko.observable(data.depart_list);
    this.hotel = ko.observable(data.hotel);
    this.hotel_fk = ko.observable(data.hotel_fk);
    this.time = ko.observable(data.time);
    this.PAX = ko.observable(data.PAX);
    this.editable = ko.observable(isEditMode);
}

function Departure(data) {

    this.title = ko.observable(data.title);
    this.PNR = ko.observable(data.PNR);
    this.names = ko.observable(data.names);
    this.phone = ko.observable(data.phone);
    this.PAX = ko.observable(data.PAX);
    this.hotel = ko.observable(data.hotel);
}



function FlightViewModel(data) {

    var self = this;
    ///
    self.flights = ko.observableArray([]);
    self.plans = ko.observableArray([]);
    self.list = ko.observableArray([]);


    self.date_start = ko.observable();


    self.depart_list = ko.observable();
    self.earliest_time = ko.observable();

    self.editable = ko.observable(false);


    self.updateTime = function () {
        var plan = this;
        var new_time = this.time();
        if (new_time) {
            var _url = url_departures + '/UpdatePlan';
            $.ajax({
                method: "PUT",
                url: _url,
                data: plan,
                dataType: "json",
            }).done(function (result) {
                plan.editable(false);
                $('#lnk_sort').show();
            });
        }
        else {
            //TODO: requeired
            //alert('error');
        }
    }




    //VALIDATE THAT NECESSARY
    self.selected_flights = ko.computed(function () {
        var arr = self.flights();
        return ko.utils.arrayFilter(arr, function (flight) {
            return flight.selected();
        });
    });

    self.print_url = ko.computed(function () {

        return _url_print + 'depart_list=' + self.depart_list();

    }, this);

    self.total_sum = ko.computed(function () {

        if (self.selected_flights().length > 0) {
            var total = 0;
            for (var p = 0; p < self.selected_flights().length; ++p) {

                total += self.selected_flights()[p].sum();
            }
            return total;
        }
        else return 0;

    });


    self.date_start.subscribe(function (newValue) {
        var _url = _url_flights_out + newValue;
        $.getJSON(_url, function (allData) {
            var mappedData = $.map(allData, function (item) {
                return new Flight(item);
            });
            self.flights(mappedData);
        });

    });




    self.select = function (flight) {
        flight.selected(!flight.selected())

    };



    self.create_plan = function () {
        var _flights = self.get_flights_str();
        self.earliest_time(self.selected_flights()[0].time())
        var url = url_departures + '/CreatePlan?' + '&date_dep_start=' + self.date_start() + '&flights=' + _flights;

        $.ajax({
            method: "POST",
            url: url,
            //data: obj,
            dataType: "json",
            //dataType: "application-json",
            //accepts: {
            //    xml: 'text/xml',
            //    text: 'text/plain'
            //}
        })
  .done(function (result) {
      var mappedData = $.map(result, function (item) {
          return new Plan(item, true);
      });

      if (mappedData.length > 0) {
          self.plans(mappedData);
          var _depart_list = self.plans()[0].depart_list();
          self.depart_list(_depart_list);
          
      }
  });

    };


    self.get_flights_str = function () {
        var _flights = "";
        var Flights = self.selected_flights();
        for (var i = 0; i < Flights.length; i++) {
            var num = Flights[i].num();
            var date = Flights[i].date();
            _flights += num + '_' + date + '~';
            //}
        }
        _flights = _flights.replace(/~$/, "");
        return _flights;
    };


    self.get_plan = function () {

        var _url = url_departures + '/GetPlan?' + 'depart_list=' + self.depart_list();

        $.getJSON(_url, function (allData) {
            var mappedData = $.map(allData, function (item) {

                return new Plan(item, false);
            });
            self.plans(mappedData);
        });
    };



    self.edit_mode = function () {

        this.editable(!this.editable());
    };



}


