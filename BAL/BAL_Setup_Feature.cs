﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DAL;

namespace BAL
{
    public class BAL_Setup_Feature : DAL_Setup_Feature
    {
        DataTable dt = new DataTable();
        public DataTable usp_Get_Feature(int? FeatureId,string Feature ,bool?IsActive)
        {
            dt = usp_Feature_Get(FeatureId, Feature, IsActive);
            return dt;
        }

    }
}
