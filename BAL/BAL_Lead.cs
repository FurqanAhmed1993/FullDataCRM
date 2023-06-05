using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Utilities;
using DAL;

namespace BAL
{
    public class BAL_Lead : DAL_Lead
    {
        DataSet ds = new DataSet();
        public DataSet Lead_Crud(int OperationTypeId, int? LoginUserId = null, int? PageSize = 100, int? PageNumber = 1, int? LeadId = null, string FirstName = null, string MiddleName = null
       , string LastName = null, string Address = null, int? StatusId = null, string PhoneNumber = null, string City = null, string State = null, string Zip = null
       , string Email = null, string SSN = null, string MMN = null, string DateOfBirth = null
       , string ConfirmNumber = null, decimal? Fee = null, string QAnumber = null, string PaymentNotes = null
       , string TimeStamp = null, string Agent = null, string Closer = null
       , int? AdvisersId = null, decimal? TotalDebt = null, decimal? Savings = null, decimal? Deal = null
       , string UserIP = null, int? DispositionId = null, DataTable tbl_ud_LeadsFinancial = null , string Commments = null, string TollFreeNumber = null)
        {
            ds = Crud_Lead(OperationTypeId, LoginUserId,PageSize, PageNumber, LeadId, FirstName, MiddleName
         , LastName, Address, StatusId, PhoneNumber, City, State, Zip, Email, SSN, MMN, DateOfBirth
         , ConfirmNumber, Fee, QAnumber, PaymentNotes, TimeStamp, Agent, Closer
         , AdvisersId, TotalDebt, Savings, Deal, UserIP, DispositionId, tbl_ud_LeadsFinancial , Commments , TollFreeNumber);

            return ds;
        }

        public DataSet FileRecording_Upload(int OperationTypeId, int? LeadId = null, string RecordingFileName = null
            , string RecordingFileOrignalName = null, string RecordingFilePath = null, int? LoginUserId = null
            , string UserIP = null)
        {
            ds = UploadFileRecording(OperationTypeId,LeadId, RecordingFileName, RecordingFileOrignalName, RecordingFilePath
                , LoginUserId, UserIP);

            return ds;
        }
        public DataSet FileSnapshot_Upload(int OperationTypeId, int? LeadId = null, string SnapShotFileName = null
           , string SnapShotFileOrignalName = null, string SnapShotFilePath = null, int? LoginUserId = null
           , string UserIP = null)
        {
           ds= UploadSnapshot(OperationTypeId, LeadId, SnapShotFileName
           , SnapShotFileOrignalName, SnapShotFilePath, LoginUserId
           , UserIP);

            return ds;
        }
    }
}
