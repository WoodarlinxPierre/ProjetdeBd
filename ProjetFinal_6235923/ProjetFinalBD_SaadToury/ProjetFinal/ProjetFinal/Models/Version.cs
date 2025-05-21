using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Version", Schema = "Configuration")]
public partial class Version
{
    [Key]
    [Column("VersionID")]
    public int VersionId { get; set; }

    [StringLength(20)]
    public string Nom { get; set; } = null!;

    public int NbChevaux { get; set; }

    [StringLength(20)]
    public string BoiteVitesse { get; set; } = null!;

    public DateOnly AnneeLancement { get; set; }

    public int Couple { get; set; }

    public int CapReservoir { get; set; }

    [Column("ModeleID")]
    public int ModeleId { get; set; }

    [InverseProperty("Version")]
    public virtual ICollection<FonctionnaliteVersion> FonctionnaliteVersions { get; set; } = new List<FonctionnaliteVersion>();

    [ForeignKey("ModeleId")]
    [InverseProperty("Versions")]
    public virtual Modele Modele { get; set; } = null!;

    [InverseProperty("Version")]
    public virtual ICollection<Moteur> Moteurs { get; set; } = new List<Moteur>();

    [InverseProperty("Version")]
    public virtual ICollection<Voiture> Voitures { get; set; } = new List<Voiture>();
}
