using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Claims;
using System.Security.Principal;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using ProjetFinal__2037266.Data;
using ProjetFinal__2037266.Models;
using ProjetFinal__2037266.ViewModels;

namespace ProjetFinal__2037266.Controllers
{
    public class ConducteursController : Controller
    {
        private readonly ProjetFinalBdLeMansContext _context;

        public ConducteursController(ProjetFinalBdLeMansContext context)
        {
            _context = context;
        }

        // GET: Conducteurs
        public async Task<IActionResult> Index()
        {
            ViewData["utilisateur"] = "visiteur";
            IIdentity identity = HttpContext.User.Identity;
            if (identity != null && identity.IsAuthenticated)
            {
                string email = HttpContext.User.FindFirstValue(ClaimTypes.Email);
                Utilisateur? utilisateur = await _context.Utilisateurs.FirstOrDefaultAsync(x => x.Email == email);
                if (utilisateur != null)
                {
                    ViewData["utilisateur"] = utilisateur.Email;
                }
            }
            return View(await _context.Conducteurs.ToListAsync());
        }

        // GET: Conducteurs/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var conducteur = await _context.VueConducteursVictoires
                .FirstOrDefaultAsync(m => m.ConducteurId == id);
            if (conducteur == null)
            {
                return NotFound();
            }

            Photo photo = await _context.Photos.FirstOrDefaultAsync(p => p.ConducteurId == id);

            string photoBase64 = null;
            if (photo?.PhotoContent != null)
            {
                photoBase64 = $"data:image/jpeg;base64,{Convert.ToBase64String(photo.PhotoContent)}";
            }

            PhotoViewModel photoViewModel = new PhotoViewModel
            {
                Conducteur = conducteur,
                Photo = photoBase64
            };
            return View(photoViewModel);
        }

        // GET: Conducteurs/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Conducteurs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ConducteurId,Nom,Prenom,DateNaissance,PaysOrigine,NombreVictoires")] Conducteur conducteur)
        {
            if (ModelState.IsValid)
            {
                _context.Add(conducteur);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(conducteur);
        }

        // GET: Conducteurs/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var conducteur = await _context.Conducteurs.FindAsync(id);
            if (conducteur == null)
            {
                return NotFound();
            }
            return View(conducteur);
        }

        // POST: Conducteurs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ConducteurId,Nom,Prenom,DateNaissance,PaysOrigine,NombreVictoires")] Conducteur conducteur)
        {
            if (id != conducteur.ConducteurId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(conducteur);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ConducteurExists(conducteur.ConducteurId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(conducteur);
        }

        // GET: Conducteurs/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var conducteur = await _context.Conducteurs
                .FirstOrDefaultAsync(m => m.ConducteurId == id);
            if (conducteur == null)
            {
                return NotFound();
            }

            return View(conducteur);
        }

        // POST: Conducteurs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var conducteur = await _context.Conducteurs.FindAsync(id);
            if (conducteur != null)
            {
                _context.Conducteurs.Remove(conducteur);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ConducteurExists(int id)
        {
            return _context.Conducteurs.Any(e => e.ConducteurId == id);
        }
        

        [Authorize]
        public async Task<IActionResult> Procedure(DateTime dateDebut, DateTime dateFin)
        {
            if (dateDebut == null || dateFin == null)
            {
                return BadRequest("Les paramètres sont invalides.");
            }


            var query = "EXEC racing.usp_ConducteursNesEntreDeuxDates @DateDebut, @DateFin";

            List<SqlParameter> parameters = new List<SqlParameter>
                {
                    new SqlParameter{ParameterName="@DateDebut", Value=dateDebut},
                    new SqlParameter{ParameterName="@DateFin", Value=dateFin }
                };
            var conducteurs = await _context.VueConducteursNesEntreDeuxDates.FromSqlRaw(query, parameters.ToArray()).ToListAsync();

            var result = conducteurs.Select(c => new ProcedureConducteurViewModel
            {
                Nom = c.Nom,
                Prenom = c.Prenom,
                DateNaissance = c.DateNaissance,
                PaysOrigine = c.PaysOrigine,
                NombreVictoires = c.NombreVictoires
            }).ToList();
            return View(result);
        }
        [Authorize]
        public async Task<IActionResult> Index2()
        {
            return View();
        }
    }
}


