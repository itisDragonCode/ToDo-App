using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Api.Controllers
{
    public class QuestionsController : BaseCrudController<QuestionDto, QuestionUpsertDto, QuestionsSearchObject, IQuestionsService>
    {
        public QuestionsController(IQuestionsService service, ILogger<QuestionsController> logger) : base(service, logger)
        {
        }

    }
}
