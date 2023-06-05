using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

using Utilities;
using System.IO;
using System.Net;
using System.Threading;

public class SMS_Templete : Base
{
    public static string SMS_API_Key = System.Configuration.ConfigurationManager.AppSettings["SMS_API_Key"];
    public static string SMS_sender = System.Configuration.ConfigurationManager.AppSettings["SMS_sender"];
    public static string SMS_Toll_Free_Number = System.Configuration.ConfigurationManager.AppSettings["SMS_Toll_Free_Number"];

    //public static void Order_SMS(int OrderMasterId)
    //{

    //    Thread sms = new Thread(delegate ()
    //    {
    //        Send_SMS(OrderMasterId);
    //    });
    //    sms.IsBackground = true;
    //    sms.Start();
    //}
    //public static void Send_Consolidate_SMS(string PhoneNumber,string Message)
    //{

    //    Thread sms = new Thread(delegate ()
    //    {
    //        Send_Consolidated_SMS(PhoneNumber, Message);
    //    });
    //    sms.IsBackground = true;
    //    sms.Start();
    //}
    //public static void Send_Consolidated_SMS(string PhoneNumber, string Message)
    //{
    //    if (PhoneNumber != "" && Message != "")
    //    {
    //        try
    //        {
    //            string urlData = String.Empty;
    //            WebClient wc = new WebClient();
    //            string APi = "http://sms.maplesolpk.com/sms/api.php?key=" + SMS_API_Key + "&to=" + PhoneNumber + "&sender=" + SMS_sender + "&msg=" + Message + "";
    //            urlData = wc.DownloadString(APi);
    //            WriteFile("", PhoneNumber, Message, "API Executed Successfully: " + urlData);
    //        }
    //        catch (Exception ex1)
    //        {
    //            WriteFile("", PhoneNumber, Message, "API Not Executed Successfully" + " : Exception : " + ex1.ToString());
    //        }
    //    }
    //    else
    //    {
    //        WriteFile("", PhoneNumber, Message, "Phone Number or message not found");
    //    }
    //}

    public static void Send_SMS(int OrderMasterId)
    {
        //try
        //{
        //    if (SMS_API_Key != "" && SMS_sender != "")
        //    {
        //        DataTable dt = new BAL_Report().usp_Report_RPT_OrderSlip(OrderMasterId, null, (int)Setup_MasterDetail.Primary, (int)Setup_MasterDetail.Mobile);
        //        if (dt != null && dt.Rows.Count > 0)
        //        {
        //            int OrderStatusId = Convert.ToInt32(dt.Rows[0]["OrderStatusId"].ToString() == "" ? "0" : dt.Rows[0]["OrderStatusId"].ToString());
        //            if (OrderStatusId == OrderStatus.New || OrderStatusId == OrderStatus.Dispatched || OrderStatusId == OrderStatus.Delivered)
        //            {
        //                string PatientMobileNo_ = dt.Rows[0]["PatientMobileNo"].ToString();
        //                string PatientMobileNo = "";
        //                if (PatientMobileNo_ != "")
        //                {
        //                    string[] PatientMobileNumber = PatientMobileNo_.Split(',');
        //                    if (PatientMobileNumber.Length > 0)
        //                    {
        //                        if (PatientMobileNumber[0].Trim() != "")
        //                        {
        //                            PatientMobileNo = PatientMobileNumber[0].Trim();

        //                        }
        //                    }
        //                }

        //                if (PatientMobileNo != "")
        //                {
        //                    ////PatientMobileNo = "03362121281";
        //                    string PatientName = dt.Rows[0]["Patient_FirstName"].ToString();
        //                    string OrderNumber = dt.Rows[0]["OrderNumber"].ToString();
        //                    string Order_Status = "";
        //                    if (OrderStatusId == OrderStatus.New)
        //                    {
        //                        Order_Status = "confirmed";
        //                    }
        //                    else if (OrderStatusId == OrderStatus.Dispatched)
        //                    {
        //                        Order_Status = "dispatched";
        //                    }
        //                    else if (OrderStatusId == OrderStatus.Delivered)
        //                    {
        //                        Order_Status = "delivered";
        //                    }

        //                    if (PatientName != "" && OrderNumber != "" && Order_Status != "")
        //                    {
        //                        try
        //                        {
        //                            string Message = "Dear " + PatientName + "," + Environment.NewLine + "Your order " + OrderNumber + " has been " + Order_Status + "." + Environment.NewLine + "For more information call " + SMS_Toll_Free_Number + ".";
        //                            string urlData = String.Empty;
        //                            WebClient wc = new WebClient();
        //                           // string APi = "http://sms.maplesol.com/api_sms/api.php?key=" + SMS_API_Key + "&receiver=" + PatientMobileNo + "&sender=" + SMS_sender + "&msgdata=" + Message + "";
								//    string APi = "http://sms.maplesolpk.com/sms/api.php?key=" + SMS_API_Key + "&to=" + PatientMobileNo + "&sender=" + SMS_sender + "&msg=" + Message + "";
        //                            urlData = wc.DownloadString(APi);
        //                            WriteFile(OrderNumber, PatientMobileNo, Order_Status, "API Executed Successfully: " + urlData);
        //                        }
        //                        catch (Exception ex1)
        //                        {
        //                            WriteFile(OrderNumber, PatientMobileNo, Order_Status, "API Not Executed Successfully" + " : Exception : " + ex1.ToString());
        //                        }
        //                    }
        //                    else
        //                    {
        //                        WriteFile(OrderNumber, PatientMobileNo, Order_Status, "PatientName or OrderNumber or OrderStatus not found");
        //                    }
        //                }
        //                else
        //                {
        //                    WriteFile("", "", "", "Patient Mobile No not found");
        //                }
        //            }
        //        }
        //        else
        //        {
        //            WriteFile("", "", "", "Order Not Found");
        //        }
        //    }
        //    else
        //    {
        //        WriteFile("", "", "", "SMS_API_Key or SMS_sender not found");
        //    }
        //}
        //catch (Exception ex)
        //{
        //    WriteFile("", "", "", "Exception : " + ex.ToString());
        //    Logger.WriteErrorLog("SMS_Templete.cs", "Order_SMS()", ex.ToString());
        //}
    }
    private static void WriteFile(string OrderNumber, string MobileNo, string Order_Status, string APIResponse)
    {
        OrderNumber = " ---- [ Order #: " + OrderNumber + " ]";
        MobileNo = " ---- [ Mobile #: " + MobileNo + " ]";
        Order_Status = " ---- [ OrderStatus: " + Order_Status + " ]";
        APIResponse = " ---- [ Log: " + APIResponse + " ]";

        DateTime dateTime = DateTime.Now;
        string SMSLog = CommonObjects.GetFileUploadPath(GenericConstants.SMSLog);
        if (!Directory.Exists(SMSLog))
            Directory.CreateDirectory(SMSLog);
        string Year = SMSLog + "/" + dateTime.ToString("yyyy");
        if (!Directory.Exists(Year))
            Directory.CreateDirectory(Year);
        string Month = Year + "/" + dateTime.ToString("MMM");
        if (!Directory.Exists(Month))
            Directory.CreateDirectory(Month);
        string Date = dateTime.ToString(GenericConstants.DateFormat1_);
        string LogFileName = Month + "/" + Date + ".txt";

        if (!System.IO.File.Exists(LogFileName))
        {
            // Create a file to write to. 
            using (System.IO.StreamWriter sw = System.IO.File.CreateText(LogFileName))
            {

            }
        }
        // This text is always added, making the file longer over time 
        // if it is not deleted. 
        using (System.IO.StreamWriter sw = System.IO.File.AppendText(LogFileName))
        {
            sw.WriteLine(DateTime.Now.ToString() + OrderNumber + MobileNo + Order_Status + APIResponse);
        }
    }

}