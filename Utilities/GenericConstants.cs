using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilities
{
    public struct GenericConstants
    {
        public const string ConnectionStringKey = "ConnectionString";
        public static int Sql_CommandTimeout = 36000;
        public const string DefaultDate = "01/01/1900";
        public const string MYDateFormatLong = "dd/MM/yyyy";
        public const string NEWDateFormat = "yyyy/MM/dd";
        public const string DateFormat1_ = "dd-MMM-yyyy";
        public const string DateTimeFormat11_ = "yyyy/MM/dd hh:mm";
        public const string DateTimeFormat1_ = "dd-MMM-yyyy hh:mm:ss tt";
        public const string DateTimeFormat2_ = "dd MMM yyyy";
        public const string DateTimeFormat2 = "dd-MMM-yyyy";
        public const string DateFormat2 = "MM/dd/yyyy";
        public const string DateFormatWithTime = "MM/dd/yyyy ddd HH:mm";
        public const string DateFormat = "MMM dd,yyyy";
        public const string DateFormat1 = "dd-MMM-yyyy ddd";
        public const string DateTimeFormat1 = "dd-MMM-yyyy ddd hh:mm:ss tt";
        public const string IntDateFormat = "yyyyMMdd";
        public const string TimeFormat = "mm:tt";
        public const string DateFormatLong = "dd/MM/yyyy HH:mm:ss";
        public const string TimeFormatLong = "HH:mm:ss";
        public const string TimeFormatAMPM = "hh:mm:ss tt";
        public const string ErrorLog = "ExceptionsLogs";
        public const string GetDefaultPage = "/Pages/Home.aspx";
        public const string AttachmentsFolderName = "Attachments";
        public const string EmailLog = "EmailLog";
        public const string SMSLog = "SMSLog";
        public const string DateTimeFormat_yMd = "yyyy-MM-dd";
        public const string HasError = "1";
        public const string HasNoError = "0";
        public static int Sybrid_CompanyId = 2000;
        public const string Type_BusinessUnit = "BusinessUnit";
        public const string Type_Department = "Department";
        public const string Type_User = "User";
        public const string SecurityKey = "SecurityKey_TASKMS";
        public const string DefaultPassword = "FullDataCRM123";
        public const string Uploads = "/Uploads";
    }

    public struct UserRole
    {
        public const int SuperAdmin = 1;
        public const int Admin = 2;
        public const int Agent = 3;

    }

    public struct Setup_Master
    {
        public const int OperationType = 1;
        

    }

    public struct Setup_MasterDetail
    {
        public const int OperationType_Insert = 7;
        public const int OperationType_Update = 8;
        public const int OperationType_Delete = 9;
        public const int OperationType_Select = 10;
        public const int OperationType_SelectLastRecord = 11;
        public const int OperationType_ResetUserPassword = 12;

    }

    public struct Feature
    {
        public const int Add = 1;
        public const int Update = 2;
        public const int Delete = 3;
        public const int View = 4;
        public const int UploadRecording= 5;
        public const int UploadSnapShot = 6;
        public const int EditFinancial = 7;
        public const int DeleteFinancial = 8;

    }

    

    public class ResponseKeys
    {
        public static string Data = "Data";
        public static string Response = "Response";
        public static string ResponseCode = "ResponseCode";
        public static string ErrorMessage = "ErrorMessage";
        public static string ResponseMessage = "ResponseMessage";
        public static string Token = "Token";
    }

    public class ResponseCodes
    {
        public static string Success = "00";
        public static string TokenExpired = "01";
        public static string NotGeneratedAgainstThisUser = "02";
        public static string InvalidToken = "03";
        public static string InvalidCredentials = "04";
        public static string Exception = "05";
        public static string ValidationError = "07";
        public static string Failure = "11";
    }

    public class ResponseMessages
    {
        public static string Success = "Success";
        public static string TokenExpired = "Token Expired";
        public static string NotGeneratedAgainstThisUser = "Token is not valid for this user";
        public static string InvalidToken = "Invalid Token";
        public static string InvalidCredentials = "Invalid Credentials";
        public static string InvalidErrorCode = "Invalid Error Code";
        public static string Failure = "Failure";
        public static string Exception = "An Exception has been occured";
        public static string NoData = "No Data Found";
        public static string ExceptionMessage = "An Exception has occured. Some thing went wrong";
        public static string InvalidPatientId = "Invalid Patient";
        public static string SuccessfullyRegistered = "SuccessfullyRegistered";
        public static string InvalidParameters = "Invalid Parameters";
        public static string SuccessfullyUpdated = "Successfully Updated";
        public static string SuccessfullyAdded = "Successfully Added";
        public static string SuccessfullyDeleted = "Successfully Deleted";
        public static string InvalidOtp = "Invalid OTP";
        public static string SuccessfullyPasswordChanged = "Password has been successfully updated";
        public static string InvalidRequest = "Invalid Request";
        public static string UnableToReOrder = "Unable To Re-Order";

    }

    public struct OperationTypes
    {
        public const int DropDownValues = 0;
        public const int Insert = 7;
        public const int Update = 8;
        public const int Delete = 9;
        public const int Select = 10;
        
        public const int SaveRecording = 13;
        public const int DeleteRecording = 14;

        public const int SaveSnapShot = 15;
        public const int DeleteSnapShot = 16;

        public const int SelectEventByDate = 17;
    }

    public struct TaskTypes
    {
        public const int GeneralTask = 20;
        public const int ProjectTask = 21;
        public const int SupportTask = 72;
        public const int ChangeManagementTask = 73;
    }

 

}
