using System;
using System.Collections.Generic;
using Concess_mercedes.Models;
using Microsoft.EntityFrameworkCore;
using Version = Concess_mercedes.Models.Version;

namespace Concess_mercedes.Data;

public partial class ConcessionaireMercedesContext : DbContext
{
    public ConcessionaireMercedesContext()
    {
    }

    public ConcessionaireMercedesContext(DbContextOptions<ConcessionaireMercedesContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Fonctionnalite> Fonctionnalites { get; set; }

    public virtual DbSet<FonctionnaliteVersion> FonctionnaliteVersions { get; set; }

    public virtual DbSet<Modele> Modeles { get; set; }

    public virtual DbSet<Moteur> Moteurs { get; set; }

    public virtual DbSet<Version> Versions { get; set; }

    public virtual DbSet<Voiture> Voitures { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConcessionaireMercedes");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Fonctionnalite>(entity =>
        {
            entity.HasKey(e => e.FonctionnaliteId).HasName("PK_Fonctionnalite_FonctionnaliteID");
        });

        modelBuilder.Entity<FonctionnaliteVersion>(entity =>
        {
            entity.HasKey(e => e.FonctionnaliteVersionId).HasName("PK_FonctionnaliteVersion_FonctionnaliteVersionID");

            entity.HasOne(d => d.Fonctionnalite).WithMany(p => p.FonctionnaliteVersions)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FonctionnaliteVersion_FonctionnaliteID");

            entity.HasOne(d => d.Version).WithMany(p => p.FonctionnaliteVersions)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FonctionnaliteVersion_VersionID");
        });

        modelBuilder.Entity<Modele>(entity =>
        {
            entity.HasKey(e => e.ModeleId).HasName("PK_Modele_ModeleID");
        });

        modelBuilder.Entity<Moteur>(entity =>
        {
            entity.HasKey(e => e.MoteurId).HasName("PK_Moteur_MoteurID");

            entity.HasOne(d => d.Version).WithMany(p => p.Moteurs)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Moteur_VersionID");
        });

        modelBuilder.Entity<Version>(entity =>
        {
            entity.HasKey(e => e.VersionId).HasName("PK_Version_VersionID");

            entity.HasOne(d => d.Modele).WithMany(p => p.Versions)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Version_ModeleID");
        });

        modelBuilder.Entity<Voiture>(entity =>
        {
            entity.HasKey(e => e.VoitureId).HasName("PK_Voiture_VoitureID");

            entity.HasOne(d => d.Version).WithMany(p => p.Voitures).HasConstraintName("FK_Voiture_VersionID");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
