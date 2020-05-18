using System.Web.Mvc;
using System.Web.Routing;

namespace ManagerSide
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Login", action = "Login", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Index",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Index", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Suppliers",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Suppliers", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Products",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Products", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Categories",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Categories", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Orders",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Orders", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Inventories",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Inventories", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Users",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Users", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
