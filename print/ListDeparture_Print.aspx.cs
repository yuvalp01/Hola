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
    public string UrlList { get; set; }
    public string UrlPlan { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["depart_list"] != null )
            {
                var api_url = ConfigurationManager.AppSettings["api_url"];
                string base_url = api_url + "/api/departures";
                string depart_list  = Request.QueryString["depart_list"];

                DateStart = depart_list.Substring(0, depart_list.IndexOf('_'));
                UrlList = base_url + "/GetList?depart_list=" + depart_list;

            }

        }
    }
}