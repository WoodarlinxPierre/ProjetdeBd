using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Champion", Schema = "racing")]
public partial class Champion
{
    [Key]
    [Column("ChampionID")]
    public int ChampionId { get; set; }

    public int Annee { get; set; }

    [StringLength(100)]
    public string ModeleVoitureGagnante { get; set; } = null!;

    [Column("ConducteurID")]
    public int ConducteurId { get; set; }

    [Column("EcurieID")]
    public int EcurieId { get; set; }

    [ForeignKey("ConducteurId")]
    [InverseProperty("Champions")]
    public virtual Conducteur Conducteur { get; set; } = null!;

    [InverseProperty("Champion")]
    public virtual ICollection<Course> Courses { get; set; } = new List<Course>();

    [ForeignKey("EcurieId")]
    [InverseProperty("Champions")]
    public virtual Ecurie Ecurie { get; set; } = null!;
}
