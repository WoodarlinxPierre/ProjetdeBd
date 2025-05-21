using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Photo", Schema = "racing")]
[Index("ConducteurId", Name = "IX_Photo_ConducteurId")]
[Index("Identifiant", Name = "UC_Photo_Identifiant", IsUnique = true)]
public partial class Photo
{
    [Key]
    [Column("PhotoID")]
    public int PhotoId { get; set; }

    public Guid Identifiant { get; set; }

    public int? ConducteurId { get; set; }

    public byte[]? PhotoContent { get; set; }

    [ForeignKey("ConducteurId")]
    [InverseProperty("Photos")]
    public virtual Conducteur? Conducteur { get; set; }
}
