using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Voiture", Schema = "Voitures")]
[Index("VersioId", Name = "IX_Voiture_VersioID")]
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

    [Column("VersioID")]
    public int VersioId { get; set; }

    [InverseProperty("Voiture")]
    public virtual ICollection<ImageVoiture> ImageVoitures { get; set; } = new List<ImageVoiture>();

    [ForeignKey("VersioId")]
    [InverseProperty("Voitures")]
    public virtual Versio Versio { get; set; } = null!;
}
