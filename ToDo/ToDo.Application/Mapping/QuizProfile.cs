using ToDo.Core;

namespace ToDo.Application
{
    public class QuizProfile : BaseProfile
    {
        public QuizProfile()
        {
            CreateMap<QuizDto, Quiz>().ReverseMap();

            CreateMap<QuizUpsertDto, Quiz>();
        }
    }
}
