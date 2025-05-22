using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__6235923.Models;

[Table("Moteur", Schema = "Configurationn")]
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

    [Column("VersioID")]
    public int VersioId { get; set; }

    [ForeignKey("VersioId")]
    [InverseProperty("Moteurs")]
    public virtual Versio Versio { get; set; } = null!;
}
