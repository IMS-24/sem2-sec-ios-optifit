namespace qb8s.net.OptiFit.CQRS.Dtos.User;

public class UserStatsDto
{
    public int ActiveDays { get; set; }
    public int TotalWorkouts { get; set; }
    public int TotalExercises { get; set; }
    public int TotalSets { get; set; }
    public int TotalReps { get; set; }
    public int TotalWeight { get; set; }
    public int TotalDuration { get; set; }
    public int TotalCalories { get; set; }
    public int WorkoutStreak { get; set; }
    public int AverageDuration { get; set; }
}