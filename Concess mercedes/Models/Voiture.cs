using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Concess_mercedes.Models;

[Table("Voiture", Schema = "Voitures")]
public partial class Voiture
{
    [Key]
    [Column("VoitureID")]
    public int VoitureId { get; set; }

    [StringLength(30)]
    public string Couleur { get; set; } = null!;

    [Column(TypeName = "decimal(18, 2)")]
    public decimal Prix { get; set; }

    public int Kilometrage { get; set; }

    public bool Disponible { get; set; }

    [Column("VersionID")]
    public int VersionId { get; set; }

    [ForeignKey("VersionId")]
    [InverseProperty("Voitures")]
    public virtual Version Version { get; set; } = null!;
}
