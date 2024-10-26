using System.Globalization;
using Microsoft.EntityFrameworkCore;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.Context;

public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> dbContextOptions) : DbContext(dbContextOptions)
{
    public DbSet<Muscle> Muscles { get; set; }
    public DbSet<MuscleGroup> MuscleGroups { get; set; }
    public DbSet<MuscleGroupMapping> MuscleGroupMappings { get; set; }
    public DbSet<Exercise> Exercises { get; set; }
    public DbSet<ExerciseType> ExerciseTypes { get; set; }
    public DbSet<ExerciseMuscleGroupMapping> ExerciseMuscleGroupMappings { get; set; }
    public DbSet<Gym> Gyms { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<UserRole> UserRoles { get; set; }
    public DbSet<Workout> Workouts { get; set; }


    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        base.OnConfiguring(optionsBuilder);
#if DEBUG
        optionsBuilder.EnableDetailedErrors();
#endif
        optionsBuilder.UseSnakeCaseNamingConvention(CultureInfo.InvariantCulture);
        optionsBuilder.EnableDetailedErrors();
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.HasPostgresExtension("uuid-ossp");
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ApplicationDbContext).Assembly);
    }
}