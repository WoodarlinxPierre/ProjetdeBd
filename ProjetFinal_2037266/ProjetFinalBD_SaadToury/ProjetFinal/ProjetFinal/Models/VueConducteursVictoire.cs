using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Keyless]
public partial class VueConducteursVictoire
{
    [Column("ConducteurID")]
    public int ConducteurId { get; set; }

    [StringLength(50)]
    public string ConducteurNom { get; set; } = null!;

    [StringLength(50)]
    public string ConducteurPrenom { get; set; } = null!;

    public int? Age { get; set; }

    [StringLength(50)]
    public string PaysOrigine { get; set; } = null!;

    public int? NombreVictoiresTotales { get; set; }

    public int? NombreVoituresDifferentGagnees { get; set; }
}
