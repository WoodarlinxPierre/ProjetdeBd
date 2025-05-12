using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Concess_mercedes.Models;

[Table("FonctionnaliteVersion", Schema = "Configurations")]
public partial class FonctionnaliteVersion
{
    [Key]
    [Column("FonctionnaliteVersionID")]
    public int FonctionnaliteVersionId { get; set; }

    public bool EstOptionel { get; set; }

    [Column("FonctionnaliteID")]
    public int FonctionnaliteId { get; set; }

    [Column("VersionID")]
    public int VersionId { get; set; }

    [ForeignKey("FonctionnaliteId")]
    [InverseProperty("FonctionnaliteVersions")]
    public virtual Fonctionnalite Fonctionnalite { get; set; } = null!;

    [ForeignKey("VersionId")]
    [InverseProperty("FonctionnaliteVersions")]
    public virtual Version Version { get; set; } = null!;
}
