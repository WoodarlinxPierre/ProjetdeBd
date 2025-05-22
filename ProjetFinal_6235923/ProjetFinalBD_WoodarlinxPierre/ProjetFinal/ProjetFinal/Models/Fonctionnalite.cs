using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__6235923.Models;

[Table("Fonctionnalite", Schema = "Configurationn")]
[Index("Nom", Name = "UQ_Fonctionnalite_Nom", IsUnique = true)]
public partial class Fonctionnalite
{
    [Key]
    [Column("FonctionnaliteID")]
    public int FonctionnaliteId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    [InverseProperty("Fonctionnalite")]
    public virtual ICollection<FonctionnaliteVersio> FonctionnaliteVersios { get; set; } = new List<FonctionnaliteVersio>();
}
