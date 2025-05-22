using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__6235923.Models;

[Keyless]
public partial class VwStatsCategorie
{
    [StringLength(10)]
    [Unicode(false)]
    public string Categorie { get; set; } = null!;

    public int? NombreVoitures { get; set; }

    [Column(TypeName = "decimal(38, 6)")]
    public decimal? PrixMoyen { get; set; }

    public int? KilometrageMoyen { get; set; }
}
