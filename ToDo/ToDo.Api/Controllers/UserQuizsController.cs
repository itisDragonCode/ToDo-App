using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Api.Controllers
{
    public class UserQuizsController : BaseCrudController<UserQuizDto, UserQuizUpsertDto, UserQuizsSearchObject, IUserQuizsService>
    {
        public UserQuizsController(IUserQuizsService service, ILogger<UserQuizsController> logger) : base(service, logger)
        {
        }

    }
}
