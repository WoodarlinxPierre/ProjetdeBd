using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("ImageVoiture", Schema = "Voitures")]
[Index("Identifiant", Name = "UC_ImageVoiture_Identifiant", IsUnique = true)]
public partial class ImageVoiture
{
    [Key]
    [Column("ImageVoitureID")]
    public int ImageVoitureId { get; set; }

    public Guid Identifiant { get; set; }

    [Column("VoitureID")]
    public int? VoitureId { get; set; }

    public byte[]? PhotoContent { get; set; }

    [ForeignKey("VoitureId")]
    [InverseProperty("ImageVoitures")]
    public virtual Voiture? Voiture { get; set; }
}
