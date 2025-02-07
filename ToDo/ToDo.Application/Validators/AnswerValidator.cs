using FluentValidation;

using ToDo.Core;

namespace ToDo.Application
{
    public class AnswerValidator : AbstractValidator<AnswerUpsertDto>
    {
        public AnswerValidator()
        {
            RuleFor(u => u.Content).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(u => u.IsTrue).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.QuestionId).NotNull().WithErrorCode(ErrorCodes.NotNull);

        }
    }
}
