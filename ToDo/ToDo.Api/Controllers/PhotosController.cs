using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Authorization;

namespace ToDo.Api.Controllers
{
    [Authorize]
    public class PhotosController : BaseCrudController<PhotoDto, PhotoUpsertDto, BaseSearchObject, IPhotosService>
    {
        public PhotosController(IPhotosService service, ILogger<PhotosController> logger) : base(service, logger)
        {
        }
    }
}
