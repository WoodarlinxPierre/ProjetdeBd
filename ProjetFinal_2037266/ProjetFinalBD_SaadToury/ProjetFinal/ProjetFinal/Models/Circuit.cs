using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Circuit", Schema = "ref")]
public partial class Circuit
{
    [Key]
    [Column("CircuitID")]
    public int CircuitId { get; set; }

    [StringLength(100)]
    public string Nom { get; set; } = null!;

    [Column(TypeName = "decimal(6, 2)")]
    public decimal Longueur { get; set; }

    public int NombreVirages { get; set; }

    [InverseProperty("Circuit")]
    public virtual ICollection<Course> Courses { get; set; } = new List<Course>();
}
