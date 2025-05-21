using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Conducteur", Schema = "racing")]
public partial class Conducteur
{
    [Key]
    [Column("ConducteurID")]
    public int ConducteurId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    [StringLength(50)]
    public string Prenom { get; set; } = null!;

    public DateOnly DateNaissance { get; set; }

    [StringLength(50)]
    public string PaysOrigine { get; set; } = null!;

    public int NombreVictoires { get; set; }

    [InverseProperty("Conducteur")]
    public virtual ICollection<Champion> Champions { get; set; } = new List<Champion>();

    [InverseProperty("Conducteur")]
    public virtual ICollection<Ecurie> Ecuries { get; set; } = new List<Ecurie>();

    [InverseProperty("Conducteur")]
    public virtual ICollection<Photo> Photos { get; set; } = new List<Photo>();
}
