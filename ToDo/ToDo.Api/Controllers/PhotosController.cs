using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ToDo.Api.Controllers
{
    [Authorize]
    public class PhotosController : BaseCrudController<PhotoDto, PhotoUpsertDto, BaseSearchObject, IPhotosService>
    {
        public PhotosController(IPhotosService service, ILogger<PhotosController> logger) : base(service, logger)
        {
        }

        private async Task<byte[]> Converter(string s)
        {
            return Convert.FromBase64String(s);
        }

        [AllowAnonymous]
        [HttpGet("GetUrl")]
        public async Task<IActionResult> GetUrl(int id, CancellationToken cancellationToken = default)
        {
            try
            {

                var dto = await Service.GetByIdAsync(id, cancellationToken);
                byte[] bytes = await Converter(dto.Data);
                MemoryStream ms = new MemoryStream(bytes);
                return new FileStreamResult(ms, "image/png");
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", id);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }

    }
}
