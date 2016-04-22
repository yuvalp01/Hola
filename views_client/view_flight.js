
//var _url = api_url + '/api/flights';



//Constructor for an object with two properties
function Flight(data) {
    this.num = data.num;
    var d = new Date(data.date);
    this.date = d.yyyymmdd();

    this.time = data.time;

    this.destination = data.destination;
    this.direction = data.direction;
    this.time_approved = data.time_approved;
    this.date_update = data.date_update;
};


function FlightViewModel(data) {

    var self = this;
    ///
    self.flights = ko.observableArray([]);

    var self_list = self.flights;

    self.new_num = ko.observable();
    self.new_date = ko.observable();
    self.new_time = ko.observable();
    self.new_destination = ko.observable();
    self.new_direction = ko.observable();
    self.new_time_approved = ko.observable();
    self.new_date_update = ko.observable();
    self.selected_flight = ko.observable();
    radioSelectedOptionValue: ko.observable();


    $.getJSON(url_flights, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new Flight(item);
        });
        self.flights(mappedData);
    });


    self.new_destination.subscribe(function (new_) {
        switch (new_) {
            case 'BCN':
            case 'Valencia':
                self.new_direction('IN');
                return;
            case 'TLV':
                self.new_direction('OUT');
            default:

        }

    });

    //Operations
    self.add_server = function () {
        if (isValid()) {
            var new_obj = {
                num: self.new_num(),
                date: self.new_date(),
                time: self.new_time(),
                destination: self.new_destination(),
                direction: self.new_direction(),

            };
            $.post(url_flights, new_obj, function (obj_from_server) {
                new_obj.ID = obj_from_server.ID;
                self_list.unshift(new_obj);
                self.new_num('');
                self.new_date('');
                self.new_time('');
                self.new_destination('');
                self.new_direction('');

            });
        }
    };

    self.remove_server = function (obj) {

        $.ajax({
            url: url_flights + '?num=' + obj.num() + '&date=' + obj.date(),
            type: 'DELETE',
        }).done(function () {
            self_list.remove(obj)
        }).fail(function (error) {
            alert("error");
        });
    }


}

// Activates knockout.js
ko.applyBindings(new FlightViewModel());



