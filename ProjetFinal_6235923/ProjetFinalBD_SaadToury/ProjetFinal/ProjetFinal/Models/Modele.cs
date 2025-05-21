using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Modele", Schema = "Configuration")]
public partial class Modele
{
    [Key]
    [Column("ModeleID")]
    public int ModeleId { get; set; }

    [StringLength(50)]
    public string Nom { get; set; } = null!;

    [StringLength(50)]
    public string TypeCarosserie { get; set; } = null!;

    public DateOnly AnneeLancement { get; set; }

    [InverseProperty("Modele")]
    public virtual ICollection<Version> Versions { get; set; } = new List<Version>();
}
