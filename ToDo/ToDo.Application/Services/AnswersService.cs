using AutoMapper;
using FluentValidation;

using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application
{
    public class AnswersService : BaseService<Answer, AnswerDto, AnswerUpsertDto, AnswersSearchObject, IAnswersRepository>, IAnswersService
    {
        public AnswersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AnswerUpsertDto> validator, IPhotosService photosService) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
