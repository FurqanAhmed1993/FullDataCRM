<%@ Application Language="C#"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Configuration" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        BundleConfig.RegisterBundles(BundleTable.Bundles);
        AuthConfig.RegisterOpenAuth();

        string dbConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlDependency.Start(dbConnectionString);
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
        string dbConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlDependency.Stop(dbConnectionString);
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }


</script>
