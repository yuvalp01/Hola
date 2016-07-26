using HolaAPI.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ListArrival_Print : System.Web.UI.Page
{
    public string DateStart { get; set; }
    public string DateEnd { get; set; }
    public string UrlList { get; set; }
    public string UrlPlan { get; set; }

    public string Passengers { get; set; }
    public string ActivitiesNames { get; set; }
    public string TourPlan { get; set; }

    public string DATA { get; set; }

    private HolaShalomDBEntities db = new HolaShalomDBEntities();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            //if (Request.Form["_details"] != null)
            //{

            int event_fk = int.Parse(Request.QueryString["event_fk"]);
            DateTime date = DateTime.Parse(Request.QueryString["date"]);
            TimeSpan time = TimeSpan.Parse(Request.QueryString["time"]);
            int activity_fk = int.Parse(Request.QueryString["activity_fk"]);
            int guide_fk = int.Parse(Request.QueryString["guide_fk"]);
            string comments_trans = Request.QueryString["comments_trans"];

            TransportList list = new TransportList();
           // list.activity_name = db.Activities.SingleOrDefault(a => a.ID == activity_fk).name;
            Event _event = db.Events.SingleOrDefault(a => a.ID == event_fk);
            list.activity_name = _event.Activity.name;
            list.comments_trans = _event.comments;
            list.date = _event.date;
            list.guide_name = _event.Guide.name;// db.Guides.SingleOrDefault(a => a.ID == _event.guide_fk).name;
            list.passengers = GetPassengersList(event_fk);

            list.pickup_time = _event.time.Value;
            list.tour_plan = GetTourPlan(_event.date, event_fk);


            var PNRs = (from a in db.SoldActivities
                        where a.event_fk == event_fk && a.canceled == false
                        select a.PNR).ToList();
            var existing_tours = (from a in db.SoldActivities
                                  where PNRs.Contains(a.PNR) && a.Activity.category == "tour"
                                  select (a.Activity.subcat)).Distinct();

            var agencies = from a in db.Clients
                           where PNRs.Contains(a.PNR)
                           select a.Agency.name;


            ActivitiesNames = Newtonsoft.Json.JsonConvert.SerializeObject(existing_tours);
            db.Dispose();
            DATA = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            Passengers = Newtonsoft.Json.JsonConvert.SerializeObject(list.passengers);
            TourPlan = Newtonsoft.Json.JsonConvert.SerializeObject(list.tour_plan);
            DateStart = list.date.ToString("yyyy-MM-dd");
        }
    }



    public List<EventDTO> GetTourPlan(DateTime dateStart, int event_fk)
    {

        var lines = (from a in db.SoldActivities
                     where a.event_fk == event_fk && a.canceled == false
                     select a);
        List<string> PNRs = lines.Select(b => b.PNR).ToList();
        DateTime lastDepDate = (from a in db.Clients
                                where PNRs.Contains(a.PNR)
                                orderby a.date_dep descending
                                select a.date_dep).FirstOrDefault();
        DateEnd = lastDepDate.ToString("yyyy-MM-dd");
        var tour_plan = from a in db.Events
                        where a.date >= dateStart && a.date <= lastDepDate && a.category == "tour" && a.canceled==false

                        select new EventDTO
                        {
                            ID = a.ID,
                            date = a.date,
                            time = a.time.Value,
                            activity_fk = a.activity_fk,
                            activity_name = a.Activity.name,
                            guide_fk = a.guide_fk,
                            guide_name = a.Guide.name,
                            comments = a.comments,
                            date_update = a.date_update
                        };
        List<EventDTO> tour_planDTO = new List<EventDTO>(tour_plan);
        return tour_planDTO.ToList(); ;

    }

    public List<PassengersRow> GetPassengersList(int event_fk)
    {

        var lines = (from a in db.SoldActivities
                     where a.event_fk == event_fk && a.canceled == false //&& a.Activity.direction == "IN"
                     select a);
        List<string> PNRs = lines.Select(b => b.PNR).ToList();
        List<PassengersRow> arrivals = new List<PassengersRow>();
        var existing_tours = (from a in db.SoldActivities
                              where PNRs.Contains(a.PNR) && a.Activity.category == "tour"
                              select (a.activity_fk)).Distinct();

        foreach (SoldActivity line in lines)
        {
            PassengersRow arrival = new PassengersRow();
            arrival.PNR = line.PNR;
            Client client = db.Clients.SingleOrDefault(a => a.PNR == line.PNR && a.agency_fk == line.Sale.agency_fk);
            arrival.names = client.names;
            arrival.agency_name = client.Agency.name;
            arrival.phone = client.phone;
            arrival.hotel_name = client.Hotel.name; //db.Clients.Where(a => a.PNR == line.PNR && a.agency_fk == line.agency_fk).Select(b => b.Hotel.name).SingleOrDefault();
            arrival.PAX = client.PAX;
            foreach (var activity_fk in existing_tours)
            {
                var tour_activities = db.SoldActivities.Where(
                     a => a.PNR == line.Sale.PNR &&
                     a.agency_fk == line.Sale.agency_fk &&
                     a.canceled == false &&
                     a.activity_fk == activity_fk);
                arrival.activities.Add(new ActivityPair()
                {
                    activity_fk = activity_fk,
                    sum = tour_activities.Sum(a => (int?)a.Sale.persons) ?? 0
                });
            }
            arrivals.Add(arrival);
        }
        arrivals = arrivals.OrderBy(a => a.hotel_name).ToList();
        return arrivals;


    }


}