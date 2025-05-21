using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using ProjetFinal__2037266.Models;

namespace ProjetFinal__2037266.Data;

public partial class ProjetFinalBdLeMansContext : DbContext
{
    public ProjetFinalBdLeMansContext()
    {
    }

    public ProjetFinalBdLeMansContext(DbContextOptions<ProjetFinalBdLeMansContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Changelog> Changelogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ProjetFinalBdLeMans_2037266");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Changelog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__changelo__3213E83F2EEB2742");

            entity.Property(e => e.InstalledOn).HasDefaultValueSql("(getdate())");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
