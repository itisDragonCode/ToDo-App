using FluentValidation;
using ToDo.Core;

namespace ToDo.Application.Validators
{
    public class ToDoItemValidator : AbstractValidator<ToDoItemUpsertDto>
    {
        public ToDoItemValidator()
        {
            RuleFor(x => x.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(x => x.IsDone).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(x => x.DueDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
