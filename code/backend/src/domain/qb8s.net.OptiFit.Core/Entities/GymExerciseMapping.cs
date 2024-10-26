using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class GymExerciseMapping : BaseEntity
{
    public Guid GymId { get; set; }
    public Gym Gym { get; set; } = null!;
    public Guid ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;
    public bool IsAvailable { get; set; } = true;
    public string? Notes { get; set; } //Machine name, dumbbell weight, etc.
}