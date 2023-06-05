﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Utilities;

namespace DAL
{
    public class DAL_Bank : DAL
    {
        public DataTable Crud_Bank(int OperationId, int? PageNumber, int? PageSize, int? BankId , string BankName , bool? IsActive , int? UserId , string UserIp)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand("Crud_Bank"))
                {
                    OpenConnection(true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OperationId", SqlDbType.Int).Value = OperationId;
                    cmd.Parameters.Add("@BankId", SqlDbType.Int).Value = BankId;
                    cmd.Parameters.Add("@BankName", SqlDbType.VarChar).Value = BankName;
                    cmd.Parameters.Add("@IsActive", SqlDbType.VarChar).Value = IsActive;
                    cmd.Parameters.Add("@UserIP", SqlDbType.VarChar).Value = UserIp;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = UserId;
                    cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = PageNumber;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = PageSize;
                    dt = GetData(cmd);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Error occured during Crud_Bank : {0}", ex.Message), ex);
            }
            return dt;
        }

    }
}
