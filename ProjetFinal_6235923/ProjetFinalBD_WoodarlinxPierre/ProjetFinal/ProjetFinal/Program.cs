using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Ajout de la chaîne de connexion
builder.Services.AddDbContext<ProjetFinal__6235923.Data.ConcessionaireMercedesContext>(
    options => options.UseSqlServer(builder.Configuration.GetConnectionString("ConcessionaireMercedes"))
    );

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(options =>
{
    options.LoginPath = "/Utilisateurs/Connexion";
    options.LogoutPath = "/Utilisateurs/Deconnexion";
});

// Add services to the container.
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern : "{controller=Utilisateurs}/{action=Connexion}/{id?}"
    );

app.MapRazorPages();

app.Run();
