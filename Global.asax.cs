using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;

namespace PaymentApp
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Initialize API routes
            GlobalConfiguration.Configure(WebApiConfig.Register);

            // Register application routes
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            // Register bundles for optimization
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Log application startup
            System.Diagnostics.Debug.WriteLine("Application Started.");
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code executed when a new session starts
            System.Diagnostics.Debug.WriteLine("New Session Started.");
        }

        void Application_BeginRequest(object sender, EventArgs e)
        {
            // Runs at the start of every request
        }

        void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // Authentication logic if needed
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Handle unhandled exceptions globally
            Exception ex = Server.GetLastError();
            System.Diagnostics.Debug.WriteLine("Application Error: " + ex.Message);
        }

        void Session_End(object sender, EventArgs e)
        {
            // Runs when a session ends
            System.Diagnostics.Debug.WriteLine("Session Ended.");
        }

        void Application_End(object sender, EventArgs e)
        {
            // Code executed when the application stops
            System.Diagnostics.Debug.WriteLine("Application Stopped.");
        }
    }
}
