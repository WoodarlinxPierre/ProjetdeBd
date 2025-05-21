using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Ecurie", Schema = "racing")]
public partial class Ecurie
{
    [Key]
    [Column("EcurieID")]
    public int EcurieId { get; set; }

    [StringLength(100)]
    public string Nom { get; set; } = null!;

    public DateOnly DateIntegration { get; set; }

    [StringLength(50)]
    public string PaysOrigine { get; set; } = null!;

    public int NombreVictoires { get; set; }

    [Column("ConducteurID")]
    public int? ConducteurId { get; set; }

    [Column("VoitureID")]
    public int? VoitureId { get; set; }

    [InverseProperty("Ecurie")]
    public virtual ICollection<Champion> Champions { get; set; } = new List<Champion>();

    [ForeignKey("ConducteurId")]
    [InverseProperty("Ecuries")]
    public virtual Conducteur? Conducteur { get; set; }

    [ForeignKey("VoitureId")]
    [InverseProperty("Ecuries")]
    public virtual Voiture? Voiture { get; set; }
}
