using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.WorkoutSet;

public class GetWorkoutSetDto
{
    public Guid Id { get; set; }
    public int Order { get; set; }
    public int Reps { get; set; }
    public decimal Weight { get; set; }
    public Guid WorkoutExerciseId { get; set; }
}

public class WorkoutSetDtoProfil : BaseProfile
{
    public WorkoutSetDtoProfil()
    {
        CreateMap<Core.Entities.WorkoutSet, GetWorkoutSetDto>();
    }
}