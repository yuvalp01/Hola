
var _url_tour_products = url_products +'?types=tour,other';

function TourPlan(data) {

    this.ID = ko.observable(data.ID);
    var d = new Date(data.date);
    this.date = ko.observable(d.yyyymmdd());
    this.time = ko.observable(data.time);
    this.tour_fk = ko.observable(data.tour_fk);
    this.tour_name = ko.observable(data.tour_name);
    this.guide_fk = ko.observable(data.guide_fk);
    this.guide_name = ko.observable(data.guide_name);
    this.comments = ko.observable(data.comments);
    var d_u = new Date(data.date_update);
    this.date_update = ko.observable(d_u.yyyymmdd());


}

function Product(data) {
    this.ID = ko.observable(data.ID);
    this.name = ko.observable(data.name);
}

function Guide(data) {
    this.ID = ko.observable(data.ID);
    this.name = ko.observable(data.name);
}






function AppViewModel(data) {
    var self = this;

    self.tours = ko.observableArray([]);
    self.products = ko.observableArray([]);
    self.guides = ko.observableArray([]);

    //product_fk = ko.observable();
    //guide_fk = ko.observable();


    self.new_ID = ko.observable();
    self.new_date = ko.observable();
    self.new_time = ko.observable();
    self.new_tour_fk = ko.observable();
    self.new_guide_fk = ko.observable();
    self.new_comments = ko.observable();


    $.getJSON(url_tour_plan, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new TourPlan(item);
        });
        self.tours(mappedData);
    });

    $.getJSON(_url_tour_products, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new Product(item);
        });
        self.products(mappedData);
    });

    $.getJSON(url_guides, function (allData) {
        var mappedData = $.map(allData, function (item) {
            return new Guide(item);
        });
        self.guides(mappedData);
    });


    //// Operations
    self.add_server = function () {

        if (isValid()) {
            var _tour = {
                ID: self.new_ID(),
                date: self.new_date(),
                time: self.new_time(),
                tour_fk: self.new_tour_fk(),
                guide_fk: self.new_guide_fk(),
                comments: self.new_comments(),

            };
            $.post(url_tour_plan, _tour, function (tour_from_server) {

                _tour.ID = tour_from_server.ID;
                _tour.date_update = Date.now();

                var select_str_product = "#ddlProducts option[value='" + self.new_tour_fk() + "']"
                var _tour_name = $(select_str_product).text()
                _tour.tour_name = _tour_name;

                var select_str_guide = "#ddlGuides option[value='" + self.new_guide_fk() + "']"
                var _guide_name = $(select_str_guide).text()
                _tour.guide_name = _guide_name;


                self.tours.unshift(new TourPlan(_tour));
                self.new_ID('')
                self.new_date('')
                self.new_time('')
                self.new_tour_fk('')
                self.new_guide_fk('')
                self.new_comments('')

            });
        }
    };

    self.remove_server = function (tour) {

        $.ajax({
            url: url_tour_plan + '/' + tour.ID(),
            type: 'DELETE',
        }).done(function () {
            self.tours.remove(tour)
        }).fail(function (error) {
            alert("error");
        });
    }
}

// Activates knockout.js
ko.applyBindings(new AppViewModel());


Date.prototype.yyyymmdd = function () {
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = this.getDate().toString();
    return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + (dd[1] ? dd : "0" + dd[0]); // padding
};



