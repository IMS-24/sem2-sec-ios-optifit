using AutoMapper;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class CreateExerciseDto
{
    public string I18NCode { get; set; } = null!;
    public string Description { get; set; } = null!;
    public Guid ExerciseCategoryId { get; set; }

    public IList<CreateExerciseMuscleMappingDto> CreateExerciseMuscleMappingDtos { get; set; } =
        new List<CreateExerciseMuscleMappingDto>();
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