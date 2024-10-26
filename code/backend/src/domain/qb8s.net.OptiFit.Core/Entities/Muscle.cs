using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Muscle : BaseI18NEntity
{
    public ICollection<MuscleGroupMapping> MuscleGroupMappings { get; set; } = new HashSet<MuscleGroupMapping>();

    public ICollection<ExerciseMuscleMapping> ExerciseMuscleMappings { get; set; } =
        new HashSet<ExerciseMuscleMapping>();
}