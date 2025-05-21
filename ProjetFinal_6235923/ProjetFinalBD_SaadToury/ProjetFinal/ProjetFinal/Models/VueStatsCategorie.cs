using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Keyless]
public partial class VueStatsCategorie
{
    [StringLength(10)]
    [Unicode(false)]
    public string Categorie { get; set; } = null!;

    public int? NombreVoitures { get; set; }

    [Column(TypeName = "decimal(38, 6)")]
    public decimal? PrixMoyen { get; set; }

    public int? KilometrageMoyen { get; set; }
}
