﻿using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System;
using System.Web;
using System.Collections.Generic;
using Microsoft.VisualBasic.FileIO;

public partial class pages_Client_Upload : System.Web.UI.Page
{

    readonly string sql_connString = ConfigurationManager.ConnectionStrings["HolaShalomDB"].ConnectionString;
    readonly string FolderPath = ConfigurationManager.AppSettings["FolderPath"];

    protected void btnUpload_Click(object sender, EventArgs e)
    {

        if (ddlAgencies.SelectedIndex!=0)
        {
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            //string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FilePath = Server.MapPath(FolderPath + "_" + FileName);
            FileUpload1.SaveAs(FilePath);

            DataTable tblExcel = GetDataTabletFromCSVFile(FilePath);
            InsertDataIntoSQLServerUsingSQLBulkCopy(tblExcel);
            LoadGrid();
        }
        else
        {
            lblFeedback.Text = "Please select agency";
            pnlFeedback.CssClass = "alert  alert-dismissable alert-danger";
            pnlFeedback.Style["display"] = "block";

        }

    }


    private DataTable GetDataTabletFromCSVFile(string csv_file_path)
    {
        DataTable csvData = new DataTable();
        try
        {
            using (TextFieldParser csvReader = new TextFieldParser(csv_file_path))
            {
                csvReader.SetDelimiters(new string[] { ";" });
                csvReader.HasFieldsEnclosedInQuotes = true;
                string[] colFields = csvReader.ReadFields();
                DataColumn ID_column = new DataColumn("ID");
                csvData.Columns.Add(ID_column);
                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;
                    csvData.Columns.Add(datecolumn);
                }

                int count = 1;

                while (!csvReader.EndOfData)
                {
                    string[] fieldData = csvReader.ReadFields();
                    string[] fieldData_ID = new string[fieldData.Length+1];
                    fieldData_ID[0] = count.ToString();
                    for (int i = 0; i < fieldData_ID.Length-1; i++)
                    {
                        fieldData_ID[i + 1] = fieldData[i];
                    }
                    count++;
                    //Making empty value as null
                    //for (int i = 0; i < fieldData.Length; i++)
                    //{
                    //    if (fieldData[i] == "")
                    //    {
                    //        fieldData[i] = null;
                    //    }
                    //}
                    csvData.Rows.Add(fieldData_ID);
                }

            }
        }
        catch (Exception ex)
        {
            lblFeedback.Text = "There was a problem with the CSV file (internal error message: " + ex.Message + ")";
            pnlFeedback.Style["display"] = "block";

        }
        return csvData;
    }



    private void InsertDataIntoSQLServerUsingSQLBulkCopy(DataTable csvFileData)
    {
        try
        {
            using (SqlConnection cnn = new SqlConnection(sql_connString))
            {
                using (var cmd = cnn.CreateCommand())
                {
                    cnn.Open();
                    cmd.CommandText = "DELETE FROM Upload_temp";
                    cmd.ExecuteNonQuery();
                }


                using (SqlBulkCopy s = new SqlBulkCopy(cnn))
                {
                    s.DestinationTableName = "Upload_temp";
                    foreach (var column in csvFileData.Columns)
                        s.ColumnMappings.Add(column.ToString(), column.ToString());
                    s.WriteToServer(csvFileData);
                }
            }
        }
        catch (Exception ex)
        {

            lblFeedback.Text = "There was a problem inserting into 'Upload_temp' db table (internal error message: " + ex.Message + ")";
            pnlFeedback.Style["display"] = "block";
        }

    }



    private void LoadGrid()
    {
        using (SqlConnection conn = new SqlConnection(sql_connString))
        {
            using (SqlCommand cmd = new SqlCommand("select * from Upload_temp order by ID", conn))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
    }


    private void LoadAgencies()
    {
        using (SqlConnection conn = new SqlConnection(sql_connString))
        {
            using (SqlCommand cmd = new SqlCommand("select ID, name from agencies", conn))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlAgencies.DataSource = dt;
                    ddlAgencies.DataBind();
                    ListItem unknown = ddlAgencies.Items.FindByText("UNKNOWN");
                    ddlAgencies.Items.Remove(unknown);
                    ListItem hola = ddlAgencies.Items.FindByText("Hola Shalom");
                    ddlAgencies.Items.Remove(hola);
                    ListItem select = new ListItem() { Text = "Select Agency", Value = "0" };
                    ddlAgencies.Items.Insert(0, select);

                }
            }
        }

    }


    private DataTable LoadHotels()
    {
        using (SqlConnection conn = new SqlConnection(sql_connString))
        {
            using (SqlCommand cmd = new SqlCommand("select ID, name from hotels order by name", conn))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    DataRow row_select = dt.NewRow();
                    row_select["ID"] = "0";
                    row_select["name"] = "Select Hotel";
                    dt.Rows.InsertAt(row_select,0);
                    return dt;
                }
            }
        }

    }


    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "InsertClient") return;
        lblFeedback.Text = e.CommandArgument.ToString();
        int rowIndex = ((GridViewRow)((System.Web.UI.Control)e.CommandSource).BindingContainer).RowIndex;
        Result result = insertClient(e.CommandArgument.ToString(), rowIndex);
        GridView gv = sender as GridView;

        gv.Rows[rowIndex].CssClass = result.status;
        lblFeedback.Text = result.message;
        lblFeedback.CssClass = result.status;
        pnlFeedback.Style["display"] = "block";

        pnlFeedback.CssClass = "alert alert-dismissable alert-"+result.status;

        //if (result.status=="success")
        //{
           
        //    pnlFeedback.CssClass = "alert alert-dismissable alert-danger";
            
        //}

        //if (success == 1)
        //{
        //    //gv.Rows[rowIndex].BackColor = System.Drawing.Color.Green;
        //    gv.Rows[rowIndex].CssClass = "success";

        //}
        //else
        //{
        //    //gv.Rows[rowIndex].BackColor = System.Drawing.Color.Red;
        //    gv.Rows[rowIndex].CssClass = "danger"; 

        //}

    }

    private Result insertClient(string fieldsStr, int rowIndex)
    {
        ClientDTO client = new ClientDTO();
        Result result = new Result();
        int count_success = 0;
        int count_client = 0;
        int count_sale = 0;

        try
        {

            client = getClientObj(fieldsStr, rowIndex);


            if (client.hotel_fk == 0 || ddlAgencies.SelectedValue == "0")
            {
                //throw new Exception("Please choose hotel and agency");
                result.status = "warning";
                result.message = "Please choose hotel and agency";
                return result;
            }

            if ((client.num_dep != "" && client.date_dep == null) || (client.num_dep == "" && client.date_dep != null))
            {
                //throw new Exception("It is impossible have a flight number without a flight date or vice versa.");
                //return "It is impossible have a flight number without a flight date or vice versa.";
                result.status = "danger";
                result.message = "It is impossible have a flight number without a flight date or vice versa. Please correct the csv file and try again.";
                return result;

            }
            using (SqlConnection cnn = new SqlConnection(sql_connString))
            {


                string cmdText_Client = @"INSERT INTO [dbo].[Clients]
                           ([PNR]
                           ,[names]
                           ,[PAX]
                           ,[num_arr]
                           ,[date_arr]
                           ,[num_dep]
                           ,[date_dep]
                           ,[phone]
                           ,[hotel_fk]
                           ,[agency_fk]
                           ,[oneway]
                           ,[comments]
                           ,[date_update]
                           ,[canceled])
                           
                    values  
                           (@PNR
                           ,@names
                           ,@PAX
                           ,@num_arr
                           ,@date_arr
                           ,@num_dep
                           ,@date_dep
                           ,@phone
                           ,@hotel_fk
                           ,@agency_fk
                           ,@oneway
                           ,@comments
                           ,@date_update
                           ,@canceled )";


                //string cmdText= "insert into Insert values(@PNR,@names,@PAX)";
                using (SqlCommand cmd = new SqlCommand(cmdText_Client, cnn))
                {
                    cmd.Parameters.AddWithValue("@PNR", client.PNR);
                    cmd.Parameters.AddWithValue("@names", client.names);
                    cmd.Parameters.AddWithValue("@PAX", client.PAX);
                    cmd.Parameters.AddWithValue("@num_arr", client.num_arr);
                    cmd.Parameters.AddWithValue("@date_arr", client.date_arr);

                    if (client.num_dep == "") cmd.Parameters.AddWithValue("@num_dep", DBNull.Value);
                    else cmd.Parameters.AddWithValue("@num_dep", client.num_dep);

                    if (client.date_dep == null) cmd.Parameters.AddWithValue("@date_dep", DBNull.Value);
                    else cmd.Parameters.AddWithValue("@date_dep", client.date_dep);

                    cmd.Parameters.AddWithValue("@phone", client.phone);
                    cmd.Parameters.AddWithValue("@comments", client.comments);
                    cmd.Parameters.AddWithValue("@oneway", client.oneway);
                    cmd.Parameters.AddWithValue("@agency_fk", client.agency_fk);
                    cmd.Parameters.AddWithValue("@hotel_fk", client.hotel_fk);
                    cmd.Parameters.AddWithValue("@date_update", DateTime.Now);
                    cmd.Parameters.AddWithValue("@canceled", false);
                    cnn.Open();
                     count_client = cmd.ExecuteNonQuery();

                }

                string cmdText_Sale = @"INSERT INTO [dbo].[Sales]
                           ([PNR]
                           ,[product_fk]
                           ,[persons]
                           ,[price]
                           ,[sale_type]
                           ,[date_sale]
                           ,[date_update]
                           ,[paid]
                           ,[canceled]
                           ,[agency_fk])
                           
                    values  
                           (@PNR
                           ,@product_fk
                           ,@persons
                           ,@price
                           ,@sale_type
                           ,@date_sale
                           ,@date_update
                           ,@paid
                           ,@canceled
                           ,@agency_fk )";


                using (SqlCommand cmd = new SqlCommand(cmdText_Sale, cnn))
                {
                    int product_fk = 1;
                    decimal price = 4.5M;
                    if (client.num_dep=="")
                    {
                        product_fk = 2;
                        price = 2;
                    }
                    cmd.Parameters.AddWithValue("@PNR", client.PNR);
                    cmd.Parameters.AddWithValue("@product_fk", product_fk);
                    cmd.Parameters.AddWithValue("@persons", client.PAX);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@sale_type", "BIZ");

                    cmd.Parameters.AddWithValue("@date_sale", DateTime.Today);
                    cmd.Parameters.AddWithValue("@date_update", DateTime.Now);
                    cmd.Parameters.AddWithValue("@paid", false);
                    cmd.Parameters.AddWithValue("@canceled", false);
                    cmd.Parameters.AddWithValue("@agency_fk", client.agency_fk);

                    count_sale = cmd.ExecuteNonQuery();
                    count_success =  +count_sale;

                }

            }


        }

        catch (SqlException ex)
        {
            if (ex.Number == 547)
            {

                result.status = "warning";
                result.message = "One of the flights does not exist in the system. Please enter the flights and try again.";
                return result;
                //return "One of the flights does not exist in the system. Please enter the flights and try again.";
            }
            else if(ex.Number==2627)
                {
                result.status = "info";
                result.message = String.Format("Reservation <b>[{0}] {1}</b> already exists in the system. No need to insert it again.", client.PNR, client.names);
                return result;
            }
            //lblFeedback.Text = "There was a problem inserting the row into the 'Client' table (internal error message: " + ex.Message + ")";
            result.status = "danger";
            result.message = "There was a problem inserting the row into the 'Client' table (internal error message: " + ex.Message + ")";
            return result;
            //return "There was a problem inserting the row into the 'Client' table (internal error message: " + ex.Message + ")";
        }

        if (count_success == 2)
        {
            result.status = "success";
            result.message = String.Format("[Reservation <b>'[{0}] {1}'</b> was successfully inserted into the database.", client.PNR, client.names);
            return result;
        }
        else
        {
            result.status = "danger";
            result.message = "Please save print screen and contact Yuval 626650117";
            return result;
        }

    }

    private ClientDTO getClientObj(string fieldsStr, int rowIndex)
    {


        ClientDTO client = new ClientDTO();
        try
        {

            string[] fields = fieldsStr.Split('~');
            client.PNR = fields[0];
            client.names = fields[1];
            client.PAX = int.Parse(fields[2]);
            client.num_arr = fields[3];
            client.date_arr = Convert.ToDateTime(fields[4]);
            client.num_dep = fields[5];

            if (fields[6] != "")
            {
                client.date_dep = Convert.ToDateTime(fields[6]);
                client.oneway = false;
            }
            else
            {
                client.date_dep = null;
                client.oneway = true;
            }



            client.phone = fields[7];
            client.comments = fields[8];

            client.agency_fk = int.Parse(ddlAgencies.SelectedValue);

            DropDownList ddlHotels = GridView1.Rows[rowIndex].FindControl("ddlHotels") as DropDownList;
            client.hotel_fk = int.Parse(ddlHotels.SelectedValue);


        }
        catch (Exception ex)
        {
            pnlFeedback.Style["display"] = "block";
            lblFeedback.Text = "There was a problem creating the  'ClientDTO' object (internal error message: " + ex.Message + ")";
        }


        return client;

    }








    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadAgencies();

        }

    }






    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var ddl = e.Row.FindControl("ddlHotels") as DropDownList;
            if (ddl != null)
            {
                //ddl.DataSource = new List<string>() { "0", "1", "2", "3", "4" };
                ddl.DataSource = LoadHotels();
                ddl.DataTextField = "name";
                ddl.DataValueField = "ID";
                ddl.DataBind();
            }
        }
    }






    protected void lnkDownloadExample_Click(object sender, EventArgs e)
    {
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment; filename=UploadFile_example.csv");
        string FilePath = Server.MapPath(FolderPath + "UploadFile_example.csv");
        Response.TransmitFile(FilePath);
        Response.End();
    }


}

public class ClientDTO
{

    public string PNR { get; set; }
    public string names { get; set; }
    public int PAX { get; set; }
    public string num_arr { get; set; }
    public DateTime date_arr { get; set; }
    public string num_dep { get; set; }
    public Nullable<DateTime> date_dep { get; set; }
    public string phone { get; set; }
    public int hotel_fk { get; set; }
    public Nullable<int> agency_fk { get; set; }
    public bool oneway { get; set; }
    public bool canceled { get; set; }
    public string comments { get; set; }
    public DateTime date_update { get; set; }

}

public class Result
{
    public string status { get; set; }
    public string message { get; set; }
}



//protected void ddlAgencies_SelectedIndexChanged(object sender, EventArgs e)
//{
//    if (ddlAgencies.SelectedIndex!=0)
//    {
//        btnUpload.Enabled = true;
//    }
//    else
//    {
//        btnUpload.Enabled = false;
//    }
//}



//protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
//{
//    GridViewRow gvr = ((DropDownList)sender).NamingContainer as GridViewRow;
//    if (gvr != null)
//    {
//        decimal price = 0.00M;
//        int quantity = 0;
//        //We can find all the controls in this row and do operations on them
//        var ddlQuantity = gvr.FindControl("ddlHotels") as DropDownList;
//        //var lblPrice = gvr.FindControl("lblPrice") as Label;
//        //var lblAmount = gvr.FindControl("lblAmount") as Label;
//        //if (ddlQuantity != null && lblPrice != null && lblAmount != null)
//        if (ddlQuantity != null)
//        {
//            int.TryParse(ddlQuantity.SelectedValue, out quantity);
//            //decimal.TryParse(lblPrice.Text, out price);

//            //lblAmount.Text = (price * quantity).ToString();
//        }
//    }
//}




//OleDbConnection Econ;
//SqlConnection con;


//string constr, Query, sqlconn;



//private void ExcelConn(string FilePath)
//{

//    //constr = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=""Excel 12.0 Xml;HDR=YES;""", FilePath);
//    constr = string.Format(ConfigurationManager.ConnectionStrings["ExcelConString"].ConnectionString, FilePath);

//    Econ = new OleDbConnection(constr);

//}
//private void connection()
//{
//    sqlconn = ConfigurationManager.ConnectionStrings["HolaShalomDB"].ConnectionString;
//    con = new SqlConnection(sqlconn);

//}


//private void InsertExcelRecords(string FilePath)
//{
//    ExcelConn(FilePath);
//    using (SqlConnection cnn = new SqlConnection(sql_connString))
//    {
//        using (var cmd = cnn.CreateCommand())
//        {
//            cnn.Open();
//            cmd.CommandText = "DELETE FROM Upload_temp";
//            cmd.ExecuteNonQuery();
//        }
//    }


//    Query = string.Format("Select [PNR],[names],[PAX],[num_arr],[date_arr],[num_dep],[date_dep],[phone],[hotel_name],[comments] FROM [{0}]", "Sheet1$");
//    OleDbCommand Ecom = new OleDbCommand(Query, Econ);
//    Econ.Open();

//    DataSet ds = new DataSet();
//    OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
//    Econ.Close();
//    oda.Fill(ds);
//    DataTable Exceldt = ds.Tables[0];
//    connection();
//    //creating object of SqlBulkCopy    
//    SqlBulkCopy objbulk = new SqlBulkCopy(con);
//    //assigning Destination table name    
//    objbulk.DestinationTableName = "Upload_temp";
//    //Mapping Table column    
//    objbulk.ColumnMappings.Add("PNR", "PNR");
//    objbulk.ColumnMappings.Add("names", "names");
//    objbulk.ColumnMappings.Add("PAX", "PAX");
//    objbulk.ColumnMappings.Add("num_arr", "num_arr");
//    objbulk.ColumnMappings.Add("date_arr", "date_arr");
//    objbulk.ColumnMappings.Add("num_dep", "num_dep");
//    objbulk.ColumnMappings.Add("date_dep", "date_dep");
//    objbulk.ColumnMappings.Add("phone", "phone");
//    objbulk.ColumnMappings.Add("hotel_name", "hotel_name");
//    //objbulk.ColumnMappings.Add("agency_name", "agency_name");
//    objbulk.ColumnMappings.Add("comments", "comments");
//    //inserting Datatable Records to DataBase    
//    con.Open();
//    objbulk.WriteToServer(Exceldt);
//    con.Close();

//}

