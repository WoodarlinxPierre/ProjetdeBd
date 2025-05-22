using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__6235923.Models;

[Table("Modele", Schema = "Configurationn")]
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
    public virtual ICollection<Versio> Versios { get; set; } = new List<Versio>();
}
