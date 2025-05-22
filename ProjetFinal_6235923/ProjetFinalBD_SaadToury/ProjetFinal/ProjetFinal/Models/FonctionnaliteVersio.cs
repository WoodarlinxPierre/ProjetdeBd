using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("FonctionnaliteVersio", Schema = "Configurationn")]
public partial class FonctionnaliteVersio
{
    [Key]
    [Column("FonctionnaliteVersioID")]
    public int FonctionnaliteVersioId { get; set; }

    public bool EstOptionel { get; set; }

    [Column("FonctionnaliteID")]
    public int FonctionnaliteId { get; set; }

    [Column("VersioID")]
    public int VersioId { get; set; }

    [ForeignKey("FonctionnaliteId")]
    [InverseProperty("FonctionnaliteVersios")]
    public virtual Fonctionnalite Fonctionnalite { get; set; } = null!;

    [ForeignKey("VersioId")]
    [InverseProperty("FonctionnaliteVersios")]
    public virtual Versio Versio { get; set; } = null!;
}
