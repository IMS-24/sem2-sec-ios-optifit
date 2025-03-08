using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class InsultEntityTypeConfiguration : BaseEntityTypeConfiguration<Insult>
{
    protected override void Configure(EntityTypeBuilder<Insult> builder)
    {
        builder.ToTable("insult");

        builder.Property(e => e.Level)
            .IsRequired();

        builder.Property(e => e.Message)
            .IsRequired()
            .HasMaxLength(2000);
    }
}