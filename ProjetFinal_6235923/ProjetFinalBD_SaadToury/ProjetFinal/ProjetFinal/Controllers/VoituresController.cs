using System;
using System.Collections.Generic;
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
    public class VoituresController : Controller
    {
        private readonly ConcessionaireMercedesContext _context;

        public VoituresController(ConcessionaireMercedesContext context)
        {
            _context = context;
        }

        // GET: Voitures
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
            return View(await _context.Voitures.ToListAsync());
        }

        // GET: Voitures/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var voiture = await _context.Voitures
                .Include(v => v.Versio)
                .FirstOrDefaultAsync(m => m.VoitureId == id);
            if (voiture == null)
            {
                return NotFound();
            }
            ImageVoiture photo = await _context.ImageVoitures.FirstOrDefaultAsync(p => p.VoitureId == id);

            string photoBase64 = null;
            if (photo?.PhotoContent != null)
            {
                photoBase64 = $"data:image/jpeg;base64,{Convert.ToBase64String(photo.PhotoContent)}";
            }

            PhotoViewModel photoViewModel = new PhotoViewModel
            {
                voiture = voiture,
                Photo = photoBase64
            };
            return View(photoViewModel);
        }

        // GET: Voitures/Create
        public IActionResult Create()
        {
            ViewData["VersioId"] = new SelectList(_context.Versios, "VersioId", "VersioId");
            return View();
        }

        // POST: Voitures/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("VoitureId,Couleur,Prix,Kilometrage,Disponible,VersioId")] Voiture voiture)
        {
            if (ModelState.IsValid)
            {
                _context.Add(voiture);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["VersioId"] = new SelectList(_context.Versios, "VersioId", "VersioId", voiture.VersioId);
            return View(voiture);
        }

        // GET: Voitures/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var voiture = _context.Voitures
     .Include(v => v.Versio)
     .FirstOrDefault(v => v.VoitureId == id);

            if (voiture == null)
            {
                return NotFound();
            }
            ViewData["VersioId"] = new SelectList(_context.Versios, "VersioId", "Nom", voiture.VersioId);
            return View(voiture);
        }

        // POST: Voitures/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("VoitureId,Couleur,Prix,Kilometrage,Disponible,VersioId")] Voiture voiture)
        {
            if (id != voiture.VoitureId)
            {
                return NotFound();
            }
            ModelState.Remove("Versio");

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(voiture);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!VoitureExists(voiture.VoitureId))
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
            ViewData["VersioId"] = new SelectList(_context.Versios, "VersioId", "Nom", voiture.VersioId);
            return View(voiture);
        }

        // GET: Voitures/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var voiture = await _context.Voitures
                .Include(v => v.Versio)
                .FirstOrDefaultAsync(m => m.VoitureId == id);
            if (voiture == null)
            {
                return NotFound();
            }

            return View(voiture);
        }

        // POST: Voitures/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var voiture = await _context.Voitures.FindAsync(id);
            if (voiture != null)
            {
                _context.Voitures.Remove(voiture);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool VoitureExists(int id)
        {
            return _context.Voitures.Any(e => e.VoitureId == id);
        }
        [HttpPost]
        public async Task<IActionResult> Procedure(string carburant, bool? disponible, decimal? prixMax, string? categorie)
        {
            var query = "EXEC Voitures.usp_RechercherVoitures @Carburant, @Disponible, @PrixMax, @Categorie";

            var parameters = new List<SqlParameter>
        {
            new SqlParameter("@Carburant", string.IsNullOrWhiteSpace(carburant) ? (object)DBNull.Value : carburant),
            new SqlParameter("@Disponible", disponible.HasValue ? (object)disponible : DBNull.Value),
            new SqlParameter("@PrixMax", prixMax.HasValue ? (object)prixMax : DBNull.Value),
            new SqlParameter("@Categorie", string.IsNullOrWhiteSpace(categorie) ? (object)DBNull.Value : categorie)
        };

            var voitures = await _context.VwRechercherVoitures.FromSqlRaw(query, parameters.ToArray()).ToListAsync();
            var result = voitures.Select(v => new VoitureProcedureResult
            {
                Modele = v.Modele,
                Prix = v.Prix,
                Kilometrage = v.Kilometrage,
                TypeCarburant = v.TypeCarburant,
                Disponible = v.Disponible,
                Categorie = v.Categorie
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
