using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base.Create;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class CreateExerciseDto : CreateI18NDto
{
    public string Description { get; set; } = null!;
    public Guid ExerciseCategoryId { get; set; }
}

public class CreateExerciseDtoProfile : Profile
{
    public CreateExerciseDtoProfile()
    {
        CreateMap<CreateExerciseDto, Core.Entities.Exercise>()
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.ExerciseCategoryId, opt => opt.MapFrom(src => src.ExerciseCategoryId))
            ;
    }
}