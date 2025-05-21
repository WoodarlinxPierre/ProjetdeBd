using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Modele", Schema = "ref")]
public partial class Modele
{
    [Key]
    [Column("ModeleID")]
    public int ModeleId { get; set; }

    public int AnneeConception { get; set; }

    [Column(TypeName = "decimal(5, 2)")]
    public decimal VitesseMax { get; set; }

    [StringLength(50)]
    public string Transmission { get; set; } = null!;

    [StringLength(50)]
    public string Motorisation { get; set; } = null!;

    [InverseProperty("Modele")]
    public virtual ICollection<Voiture> Voitures { get; set; } = new List<Voiture>();
}
