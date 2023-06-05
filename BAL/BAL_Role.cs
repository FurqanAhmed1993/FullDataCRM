﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DAL;

namespace BAL
{
    public class BAL_Role : DAL_Role
    {
        DataTable dt = new DataTable();

        public DataTable usp_GetUserRole(int? RoleId, string RoletName, bool? IsActive, int LoginRoleId)
        {
            dt = usp_UserRole_Get(RoleId, RoletName, IsActive, LoginRoleId);
            return dt;
        }
        public DataTable usp_Insert_UserRole(string RoleName, bool IsActive, int UserId, string UserIp)
        {
            dt = Usp_UserRole_Insert(RoleName, IsActive, UserId, UserIp);
            return dt;
        }
        public DataTable usp_Update_UserRole(int RoleId, string RoleName, bool IsActive, int UserId, string UserIp)
        {
            dt = usp_UserRole_Update(RoleId, RoleName, IsActive, UserId, UserIp);
            return dt;
        }
        public DataTable usp_Delete_UserRole(int RoleId, int UserId, string UserIp)
        {
            dt = usp_UserRole_Delete(RoleId, UserId, UserIp);
            return dt;
        }
    }
}
