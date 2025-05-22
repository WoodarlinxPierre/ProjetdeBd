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

    public virtual DbSet<FonctionnaliteVersio> FonctionnaliteVersios { get; set; }

    public virtual DbSet<ImageVoiture> ImageVoitures { get; set; }

    public virtual DbSet<Modele> Modeles { get; set; }

    public virtual DbSet<Moteur> Moteurs { get; set; }

    public virtual DbSet<Utilisateur> Utilisateurs { get; set; }

    public virtual DbSet<Versio> Versios { get; set; }

    public virtual DbSet<Voiture> Voitures { get; set; }

    public virtual DbSet<VueStatsCategorie> VueStatsCategories { get; set; }

    public virtual DbSet<VwRechercherVoiture> VwRechercherVoitures { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConcessionaireMercedes");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Changelog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__changelo__3213E83FE807FA68");

            entity.Property(e => e.InstalledOn).HasDefaultValueSql("(getdate())");
        });

        modelBuilder.Entity<FonctionnaliteVersio>(entity =>
        {
            entity.HasOne(d => d.Fonctionnalite).WithMany(p => p.FonctionnaliteVersios)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FonctionnaliteVersio_Fonctionnalite");

            entity.HasOne(d => d.Versio).WithMany(p => p.FonctionnaliteVersios)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FonctionnaliteVersio_Versio");
        });

        modelBuilder.Entity<ImageVoiture>(entity =>
        {
            entity.Property(e => e.Identifiant).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Voiture).WithMany(p => p.ImageVoitures).HasConstraintName("FK_ImageVoiture_VoitureID");
        });

        modelBuilder.Entity<Moteur>(entity =>
        {
            entity.HasOne(d => d.Versio).WithMany(p => p.Moteurs)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Moteur_Versio");
        });

        modelBuilder.Entity<Utilisateur>(entity =>
        {
            entity.HasKey(e => e.UtilisateurId).HasName("PK_Utilisateur_UtilisateurID");
        });

        modelBuilder.Entity<Versio>(entity =>
        {
            entity.HasOne(d => d.Modele).WithMany(p => p.Versios)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Versio_Modele");
        });

        modelBuilder.Entity<Voiture>(entity =>
        {
            entity.HasOne(d => d.Versio).WithMany(p => p.Voitures).HasConstraintName("FK_Voiture_Versio");
        });

        modelBuilder.Entity<VueStatsCategorie>(entity =>
        {
            entity.ToView("Vue_Stats_Categorie", "Voitures");
        });

        modelBuilder.Entity<VwRechercherVoiture>(entity =>
        {
            entity.ToView("Vw_RechercherVoitures", "Voitures");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
