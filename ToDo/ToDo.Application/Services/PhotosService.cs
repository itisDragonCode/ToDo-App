using AutoMapper;
using FluentValidation;
using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application
{
    public class PhotosService : BaseService<Photo, PhotoDto, PhotoUpsertDto, BaseSearchObject, IPhotosRepository>, IPhotosService
    {
        public PhotosService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PhotoUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

       
    }
}
