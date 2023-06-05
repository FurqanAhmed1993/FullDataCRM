using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class DAL_Lead:DAL
    {
        protected DataSet Crud_Lead(int OperationTypeId, int? LoginUserId = null, int? PageSize=100,int? PageNumber=1, int? LeadId=null,string FirstName=null,string MiddleName = null
        , string LastName = null, string Address = null, int? StatusId = null, string PhoneNumber = null, string City = null
       , string State = null, string Zip = null, string Email = null, string SSN = null, string MMN = null
        , string DateOfBirth = null, string ConfirmNumber = null, decimal? Fee = null, string QAnumber = null
        , string PaymentNotes = null, string TimeStamp = null, string Agent = null, string Closer = null
        , int? AdvisersId = null, decimal? TotalDebt = null, decimal? Savings = null, decimal? Deal = null
        ,string UserIP=null, int? DispositionId = null , DataTable tbl_ud_LeadsFinancial=null ,string Comments = null , string TollFreeNumber = null)
        {
            DataSet ds = new DataSet();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_LeadDetail"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationTypeId", SqlDbType.Int).Value = OperationTypeId;
                    cmd.Parameters.Add("@LeadId", SqlDbType.Int).Value = LeadId;
                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = FirstName;
                    cmd.Parameters.Add("@MiddleName", SqlDbType.VarChar).Value = MiddleName;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = LastName;
                    cmd.Parameters.Add("@Address", SqlDbType.VarChar).Value = Address;
                    cmd.Parameters.Add("@City", SqlDbType.VarChar).Value = City;
                    cmd.Parameters.Add("@State", SqlDbType.VarChar).Value = State;
                    cmd.Parameters.Add("@Zip", SqlDbType.VarChar).Value = Zip;
                    cmd.Parameters.Add("@PhoneNumber", SqlDbType.VarChar).Value = PhoneNumber;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = Email;
                    cmd.Parameters.Add("@SSN", SqlDbType.VarChar).Value = SSN;
                    cmd.Parameters.Add("@MMN", SqlDbType.VarChar).Value = MMN;
                    cmd.Parameters.Add("@DateOfBirth", SqlDbType.VarChar).Value = DateOfBirth;
                    cmd.Parameters.Add("@ConfirmNumber", SqlDbType.VarChar).Value = ConfirmNumber;
                    cmd.Parameters.Add("@Fee", SqlDbType.Decimal).Value = Fee;
                    cmd.Parameters.Add("@QAnumber", SqlDbType.VarChar).Value = QAnumber;
                    cmd.Parameters.Add("@PaymentNotes", SqlDbType.VarChar).Value = PaymentNotes;
                    cmd.Parameters.Add("@TimeStamp", SqlDbType.VarChar).Value = TimeStamp;
                    cmd.Parameters.Add("@Agent", SqlDbType.VarChar).Value = Agent;
                    cmd.Parameters.Add("@Closer", SqlDbType.VarChar).Value = Closer;
                    cmd.Parameters.Add("@StatusId", SqlDbType.Int).Value = StatusId;
                    cmd.Parameters.Add("@AdvisersId", SqlDbType.Int).Value = AdvisersId;
                    cmd.Parameters.Add("@TotalDebt", SqlDbType.Decimal).Value = TotalDebt;
                    cmd.Parameters.Add("@Savings", SqlDbType.Decimal).Value = Savings;
                    cmd.Parameters.Add("@Deal", SqlDbType.Decimal).Value = Deal;
                    cmd.Parameters.Add("@LoginUserId", SqlDbType.VarChar).Value = LoginUserId;
                    cmd.Parameters.Add("@tbl_ud_LeadsFinancial", SqlDbType.Structured).Value = tbl_ud_LeadsFinancial;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = PageSize;
                    cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = PageNumber;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIP;
                    cmd.Parameters.Add("@DispositionId", SqlDbType.Int).Value = DispositionId;
                    cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = Comments;
                    cmd.Parameters.Add("@TollFreeNumber", SqlDbType.VarChar).Value = TollFreeNumber;

                    ds = GetDataSet(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during Crud_Lead : {0}", ex.Message), ex);
            }
            return ds;
        }

        protected DataSet UploadFileRecording(int OperationTypeId,int?LeadId=null,string RecordingFileName = null
            , string RecordingFileOrignalName = null, string RecordingFilePath = null, int? LoginUserId = null
            , string UserIP = null)
        {
            DataSet ds = new DataSet();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_LeadDetail"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationTypeId", SqlDbType.Int).Value = OperationTypeId;
                    cmd.Parameters.Add("@LeadId", SqlDbType.Int).Value = LeadId;
                    cmd.Parameters.Add("@RecordingFileName", SqlDbType.VarChar).Value = RecordingFileName;
                    cmd.Parameters.Add("@RecordingFileOrignalName", SqlDbType.VarChar).Value = RecordingFileOrignalName;
                    cmd.Parameters.Add("@RecordingFilePath", SqlDbType.VarChar).Value = RecordingFilePath;
                    cmd.Parameters.Add("@LoginUserId", SqlDbType.VarChar).Value = LoginUserId;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIP;

                    ds = GetDataSet(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during UploadFileRecording : {0}", ex.Message), ex);
            }
            return ds;
        }

        protected DataSet UploadSnapshot(int OperationTypeId, int? LeadId = null, string SnapShotFileName = null
           , string SnapShotFileOrignalName = null, string SnapShotFilePath = null, int? LoginUserId = null
           , string UserIP = null)
        {
            DataSet ds = new DataSet();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_LeadDetail"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationTypeId", SqlDbType.Int).Value = OperationTypeId;
                    cmd.Parameters.Add("@LeadId", SqlDbType.Int).Value = LeadId;
                    cmd.Parameters.Add("@SnapShotFileName", SqlDbType.VarChar).Value = SnapShotFileName;
                    cmd.Parameters.Add("@SnapShotFileOrignalName", SqlDbType.VarChar).Value = SnapShotFileOrignalName;
                    cmd.Parameters.Add("@SnapShotFilePath", SqlDbType.VarChar).Value = SnapShotFilePath;
                    cmd.Parameters.Add("@LoginUserId", SqlDbType.VarChar).Value = LoginUserId;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIP;

                    ds = GetDataSet(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during UploadSnapshot : {0}", ex.Message), ex);
            }
            return ds;
        }
    }
}
