namespace SnakeChaser
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Configure Kestrel to listen on port 8000
            builder.WebHost.ConfigureKestrel(options =>
            {
                options.ListenAnyIP(8000); // Set the port here
            });

            var app = builder.Build();

            // Middleware configuration
            app.UseStaticFiles(); // To serve static files like HTML, CSS, and JS
            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapGet("/", async context =>
                {
                    context.Response.Redirect("/index.html");
                });
            });

            app.Run();
        }
    }
}
