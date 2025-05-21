using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal__2037266.Models;

[Table("Utilisateur", Schema = "users")]
[Index("Email", Name = "IX_Utilisateur_Email")]
[Index("Email", Name = "UC_Courriel", IsUnique = true)]
public partial class Utilisateur
{
    [Key]
    [Column("UtilisateurID")]
    public int UtilisateurId { get; set; }

    [MaxLength(32)]
    public byte[] MpdHache { get; set; } = null!;

    [MaxLength(16)]
    public byte[] MpdSel { get; set; } = null!;

    [StringLength(256)]
    public string Email { get; set; } = null!;
}
