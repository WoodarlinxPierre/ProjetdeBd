using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Concess_mercedes.Data;
using Concess_mercedes.Models;

namespace Concess_mercedes.Controllers
{
    public class ModelesController : Controller
    {
        private readonly ConcessionaireMercedesContext _context;

        public ModelesController(ConcessionaireMercedesContext context)
        {
            _context = context;
        }

        // GET: Modeles
        public async Task<IActionResult> Index()
        {
            return View(await _context.Modeles.ToListAsync());
        }

        // GET: Modeles/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var modele = await _context.Modeles
                .FirstOrDefaultAsync(m => m.ModeleId == id);
            if (modele == null)
            {
                return NotFound();
            }

            return View(modele);
        }

        // GET: Modeles/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Modeles/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ModeleId,Nom,TypeCarosserie,AnneeLancement")] Modele modele)
        {
            if (ModelState.IsValid)
            {
                _context.Add(modele);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(modele);
        }

        // GET: Modeles/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var modele = await _context.Modeles.FindAsync(id);
            if (modele == null)
            {
                return NotFound();
            }
            return View(modele);
        }

        // POST: Modeles/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ModeleId,Nom,TypeCarosserie,AnneeLancement")] Modele modele)
        {
            if (id != modele.ModeleId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(modele);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ModeleExists(modele.ModeleId))
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
            return View(modele);
        }

        // GET: Modeles/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var modele = await _context.Modeles
                .FirstOrDefaultAsync(m => m.ModeleId == id);
            if (modele == null)
            {
                return NotFound();
            }

            return View(modele);
        }

        // POST: Modeles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var modele = await _context.Modeles.FindAsync(id);
            if (modele != null)
            {
                _context.Modeles.Remove(modele);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ModeleExists(int id)
        {
            return _context.Modeles.Any(e => e.ModeleId == id);
        }
    }
}
