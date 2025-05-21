using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using ProjetFinal__2037266.Models;

namespace ProjetFinal__2037266.Data;

public partial class ConcessionaireMercedesContext : DbContext
{
    public ConcessionaireMercedesContext()
    {
    }

    public ConcessionaireMercedesContext(DbContextOptions<ConcessionaireMercedesContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Changelog> Changelogs { get; set; }

    public virtual DbSet<Fonctionnalite> Fonctionnalites { get; set; }

    public virtual DbSet<FonctionnaliteVersion> FonctionnaliteVersions { get; set; }

    public virtual DbSet<ImageVoiture> ImageVoitures { get; set; }

    public virtual DbSet<Modele> Modeles { get; set; }

    public virtual DbSet<Moteur> Moteurs { get; set; }

    public virtual DbSet<Utilisateur> Utilisateurs { get; set; }

    public virtual DbSet<Models.Version> Versions { get; set; }

    public virtual DbSet<Voiture> Voitures { get; set; }

    public virtual DbSet<VueStatsCategorie> VueStatsCategories { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConcessionaireMercedes");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Changelog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__changelo__3213E83FE5A82D78");

            entity.Property(e => e.InstalledOn).HasDefaultValueSql("(getdate())");
        });

        modelBuilder.Entity<FonctionnaliteVersion>(entity =>
        {
            entity.HasOne(d => d.Fonctionnalite).WithMany(p => p.FonctionnaliteVersions)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FonctionnaliteVersion_Fonctionnalite");

            entity.HasOne(d => d.Version).WithMany(p => p.FonctionnaliteVersions)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FonctionnaliteVersion_Version");
        });

        modelBuilder.Entity<ImageVoiture>(entity =>
        {
            entity.Property(e => e.Identifiant).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Voiture).WithMany(p => p.ImageVoitures).HasConstraintName("FK_ImageVoiture_VoitureID");
        });

        modelBuilder.Entity<Moteur>(entity =>
        {
            entity.HasOne(d => d.Version).WithMany(p => p.Moteurs)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Moteur_Version");
        });

        modelBuilder.Entity<Utilisateur>(entity =>
        {
            entity.HasKey(e => e.UtilisateurId).HasName("PK_Utilisateur_UtilisateurID");
        });

        modelBuilder.Entity<Models.Version>(entity =>
        {
            entity.HasOne(d => d.Modele).WithMany(p => p.Versions)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Version_Modele");
        });

        modelBuilder.Entity<Voiture>(entity =>
        {
            entity.HasOne(d => d.Version).WithMany(p => p.Voitures).HasConstraintName("FK_Voiture_Version");
        });

        modelBuilder.Entity<VueStatsCategorie>(entity =>
        {
            entity.ToView("Vue_Stats_Categorie", "Voitures");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
