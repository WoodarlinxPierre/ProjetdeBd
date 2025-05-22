using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__6235923.Models;

[Keyless]
public partial class VwRechercherVoiture
{
    [Column("VoitureID")]
    public int VoitureId { get; set; }

    [StringLength(50)]
    public string Modele { get; set; } = null!;

    [Column(TypeName = "decimal(18, 2)")]
    public decimal Prix { get; set; }

    public int Kilometrage { get; set; }

    [StringLength(30)]
    public string TypeCarburant { get; set; } = null!;

    public bool Disponible { get; set; }

    [StringLength(10)]
    [Unicode(false)]
    public string Categorie { get; set; } = null!;
}
