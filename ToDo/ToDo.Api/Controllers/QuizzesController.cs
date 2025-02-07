using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ToDo.Api.Controllers
{
    public class QuizzesController : BaseCrudController<QuizDto, QuizUpsertDto, QuizzesSearchObject, IQuizzesService>
    {
        public QuizzesController(IQuizzesService service, ILogger<QuizzesController> logger) : base(service, logger)
        {
        }


        [HttpGet("GetActiveQuizzes")]
        public async Task<IActionResult> GetActiveQuizzes([FromQuery] QuizzesSearchObject quizzesSearchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.GetActiveQuizzes(quizzesSearchObject, cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {

                throw new Exception(e.Message, e?.InnerException);
            }
        }

        [HttpPost("SeedQuizData")]
        public async Task<IActionResult> SeedQuizData(CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.SeedQuizData(cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {

                throw new Exception(e.Message, e?.InnerException);
            }
        }

    }
}
