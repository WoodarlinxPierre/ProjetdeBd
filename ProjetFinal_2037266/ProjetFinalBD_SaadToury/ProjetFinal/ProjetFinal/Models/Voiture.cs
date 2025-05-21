using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Voiture", Schema = "racing")]
public partial class Voiture
{
    [Key]
    [Column("VoitureID")]
    public int VoitureId { get; set; }

    [StringLength(100)]
    public string Nom { get; set; } = null!;

    [Column("ModeleID")]
    public int ModeleId { get; set; }

    [InverseProperty("Voiture")]
    public virtual ICollection<Ecurie> Ecuries { get; set; } = new List<Ecurie>();

    [ForeignKey("ModeleId")]
    [InverseProperty("Voitures")]
    public virtual Modele Modele { get; set; } = null!;
}
