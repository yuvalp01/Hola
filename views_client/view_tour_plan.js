
var _url_tour_products = url_products + '?types=tour,other';

function TourPlan(data) {

    this.ID = ko.observable(data.ID);
    var d = new Date(data.date);
    this.date = ko.observable(d.yyyymmdd());
    var t = data.time;
    this.time = ko.observable(t.HHmm());
    this.product_fk = ko.observable(data.product_fk);
    this.tour_name = ko.observable(data.tour_name);

    this.guide_fk = ko.observable(data.guide_fk);
    //this.guide_name = ko.computed(function () {

    //    return ko.utils.arrayFirst(self.guides(), function (guide) {
    //        return (guide.ID === id).name;
    //    });

    //   // return this.guide_fk() + "_test";
    //}, this);

    this.guide_name = ko.observable(data.guide_name);
    this.comments = ko.observable(data.comments);
    var d_u = new Date(data.date_update);
    this.date_update = ko.observable(d_u.yyyymmdd());
    this.editable = ko.observable(false);
    this.editBtnClass = ko.observable('btn btn-circle btn-info');
    this.editBtnText = ko.observable('Edit');
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
        $('#trLoading').hide();
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
                product_fk: self.new_tour_fk(),
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

    self.edit_mode = function () {
        if (this.editable()) {

            self.UpdatePlan(this);
            this.editBtnClass('btn btn-circle btn-info');
            this.editBtnText('Edit');
            this.editable(false);
        }
        else {
            this.editBtnClass('btn btn-circle btn-primary');
            this.editBtnText('Save');
            this.editable(true);
        }
    };

    self.UpdatePlan = function (item) {

        var _url = url_tour_plan + '/UpdatePlan/';
        $.ajax({
            method: "PUT",
            url: _url,
            data: item,
            dataType: "json",
        }).done(function (result) {

            var guide_fk = item.guide_fk();
            var match = ko.utils.arrayFirst(self.guides(), function (guide) {
                return guide.ID() === guide_fk;
            });
            item.editable(false);
            item.guide_name(match.name());
            //self.feedback_sale('');
        }).fail(function (error) {
            // self.feedback_sale(error.responseText)
            alert(error);
        });
    }




    self.CancelPlan = function () {

        if (confirm('Are you sure you want to delete this row?')) {
            var item = this;
            var _url = url_tour_plan + '/CancelPlan/' + this.ID();
            $.ajax({
                method: "PUT",
                url: _url,
                //data: item,
                dataType: "json",
            }).done(function (result) {
                self.tours.remove(item);
                //self.feedback_sale('');
            }).fail(function (error) {
                alert(error.responseText);
                // self.feedback_sale(error.responseText);
            })
        }
    }
}

// Activates knockout.js
ko.applyBindings(new AppViewModel());

String.prototype.HHmm = function () {
    var array = this.split(':');
    var HH = array[0];
    var mm = array[1];
    return (HH[1] ? HH : "0" + HH[0]) + ':' + (mm[1] ? mm : "0" + mm[0]); // padding
};



