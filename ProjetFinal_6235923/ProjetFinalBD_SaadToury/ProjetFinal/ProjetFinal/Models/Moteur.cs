using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Moteur", Schema = "Configuration")]
public partial class Moteur
{
    [Key]
    [Column("MoteurID")]
    public int MoteurId { get; set; }

    [StringLength(30)]
    public string TypeCarburant { get; set; } = null!;

    public int NbCylindre { get; set; }

    public bool EstTurbocharger { get; set; }

    public bool EstSupercharger { get; set; }

    [Column("VersionID")]
    public int VersionId { get; set; }

    [ForeignKey("VersionId")]
    [InverseProperty("Moteurs")]
    public virtual Version Version { get; set; } = null!;
}
