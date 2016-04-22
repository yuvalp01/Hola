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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["date_start"] != null && Request.QueryString["date_end"] != null && Request.QueryString["flights"] != null)
            {
                var api_url = ConfigurationManager.AppSettings["api_url"];
                string _url_arrivals = api_url+"/api/arrivals?";
                DateStart = Request.QueryString["date_start"];
                DateEnd = Request.QueryString["date_end"];
                string flights = Request.QueryString["flights"];

                UrlList = _url_arrivals +"date_start="+DateStart+ "&flights=" + flights;
                UrlPlan = _url_arrivals + "date_start=" + DateStart + "&date_end=" + DateEnd;

            }



        }
    }
}