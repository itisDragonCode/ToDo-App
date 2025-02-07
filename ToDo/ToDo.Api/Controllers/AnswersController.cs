using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Api.Controllers
{
    public class AnswersController : BaseCrudController<AnswerDto, AnswerUpsertDto, AnswersSearchObject, IAnswersService>
    {
        public AnswersController(IAnswersService service, ILogger<AnswersController> logger) : base(service, logger)
        {
        }

    }
}
