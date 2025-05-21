using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using ProjetFinal__2037266.Data;
using ProjetFinal__2037266.Models;
using ProjetFinal__2037266.ViewModels;
using System.Security.Claims;

namespace ProjetFinal__2037266.Controllers
{
    public class UtilisateursController : Controller
    {
        readonly ProjetFinalBdLeMansContext _context;

        public UtilisateursController(ProjetFinalBdLeMansContext context)
        {
            _context = context;
        }
		public IActionResult Inscription()
		{
            return View();
		}
		public IActionResult Connexion()
		{
			return View();
		}

		[HttpPost]
        public async Task<IActionResult> Inscription(InscriptionViewModel ivm)
        {
            bool ex = await _context.Utilisateurs.AnyAsync(x => x.Email == ivm.Email);

            if (ex)
            {
                ModelState.AddModelError("Email", "Cet utilisateur existe déja");
                return View(ivm);
            }

            string querry = "EXEC users.USP_CreerUtilisateur @Email, @MotDePasse";
            List<SqlParameter> sqlParameters = new List<SqlParameter>
            {
                new SqlParameter {ParameterName = "@Email", Value = ivm.Email },
                new SqlParameter {ParameterName = "@MotDePasse", Value = ivm.MotDePasse }
            };
            try
            {
                await _context.Database.ExecuteSqlRawAsync(querry, sqlParameters.ToArray());
            }
            catch (Exception)
            {
                ModelState.AddModelError("", "Une erreur est survenue. Veuillez réessayer.");
                return View(ivm);
            }
            return RedirectToAction("Connexion", "Utilisateurs");
        }
        [HttpPost]
        public async Task<IActionResult> Connexion(ConnexionViewModel cvm)
        {

            

            string querry = "EXEC  users.USP_AuthClient @Email, @MotDePasse";
            List<SqlParameter> sqlParameters = new List<SqlParameter>
            {
                new SqlParameter {ParameterName = "@Email", Value = cvm.Email },
                new SqlParameter {ParameterName = "@MotDePasse", Value = cvm.Mpd }
            };
            Utilisateur? utilisateur = (await _context.Utilisateurs.FromSqlRaw(querry, sqlParameters.ToArray()).ToListAsync()).FirstOrDefault();
            if(utilisateur == null)
            {
                ModelState.AddModelError("","Courriel ou Mot de passe invalide");
                return View(cvm);
            }
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, utilisateur.UtilisateurId.ToString()),
                new Claim(ClaimTypes.Email, utilisateur.Email)
            };

            ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            ClaimsPrincipal principal = new ClaimsPrincipal(claimsIdentity);
            await HttpContext.SignInAsync(principal);

            return RedirectToAction("Index", "Conducteurs");
        }

        public async Task<IActionResult>  Deconnexion()
        {
            await HttpContext.SignOutAsync();
            return RedirectToAction("Index", "Conducteurs");

        }
    }
}
