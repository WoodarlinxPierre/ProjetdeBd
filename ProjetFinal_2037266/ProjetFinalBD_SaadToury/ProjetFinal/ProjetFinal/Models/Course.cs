using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Course", Schema = "racing")]
public partial class Course
{
    [Key]
    [Column("CourseID")]
    public int CourseId { get; set; }

    [StringLength(100)]
    public string Nom { get; set; } = null!;

    public DateOnly Date { get; set; }

    [StringLength(50)]
    public string Pays { get; set; } = null!;

    [Column("CircuitID")]
    public int CircuitId { get; set; }

    [Column("ChampionID")]
    public int ChampionId { get; set; }

    [ForeignKey("ChampionId")]
    [InverseProperty("Courses")]
    public virtual Champion Champion { get; set; } = null!;

    [ForeignKey("CircuitId")]
    [InverseProperty("Courses")]
    public virtual Circuit Circuit { get; set; } = null!;
}
