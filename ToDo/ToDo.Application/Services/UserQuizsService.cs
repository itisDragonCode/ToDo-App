using AutoMapper;
using FluentValidation;

using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application
{
    public class UserQuizsService : BaseService<UserQuiz, UserQuizDto, UserQuizUpsertDto, UserQuizsSearchObject, IUserQuizsRepository>, IUserQuizsService
    {
        public UserQuizsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserQuizUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
