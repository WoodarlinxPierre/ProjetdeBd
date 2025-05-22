using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__6235923.Models;

[Table("Versio", Schema = "Configurationn")]
public partial class Versio
{
    [Key]
    [Column("VersioID")]
    public int VersioId { get; set; }

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

    [InverseProperty("Versio")]
    public virtual ICollection<FonctionnaliteVersio> FonctionnaliteVersios { get; set; } = new List<FonctionnaliteVersio>();

    [ForeignKey("ModeleId")]
    [InverseProperty("Versios")]
    public virtual Modele Modele { get; set; } = null!;

    [InverseProperty("Versio")]
    public virtual ICollection<Moteur> Moteurs { get; set; } = new List<Moteur>();

    [InverseProperty("Versio")]
    public virtual ICollection<Voiture> Voitures { get; set; } = new List<Voiture>();
}
