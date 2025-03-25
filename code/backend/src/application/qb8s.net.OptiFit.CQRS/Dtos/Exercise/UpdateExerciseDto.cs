using AutoMapper;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class UpdateExerciseDto
{
    public string? I18NCode { get; set; } = null!;
    public string? Description { get; set; } = null!;
    public Guid ExerciseCategoryId { get; set; }
}

public class UpdateExerciseDtoProfile : Profile
{
    public UpdateExerciseDtoProfile()
    {
        CreateMap<UpdateExerciseDto, Core.Entities.Exercise>()
            .ForMember(dest => dest.I18NCode, opt => opt.MapFrom(src => src.I18NCode))
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.ExerciseCategoryId, opt => opt.MapFrom(src => src.ExerciseCategoryId))
            ;
    }
}